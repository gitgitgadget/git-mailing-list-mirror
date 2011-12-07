From: Jonathan Nieder <jrnieder@gmail.com>
Subject: &&-chaining tester
Date: Wed, 7 Dec 2011 04:08:58 -0600
Message-ID: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <CALkWK0mpPoZJWviBesWgy2dZ4xJrNyhED2znFid8iGbSTirPhQ@mail.gmail.com>
 <7vliqph8a6.fsf@alter.siamese.dyndns.org>
 <CALkWK0nNtvrLHxQv17jfrFQ=BcwLfgh7eE9X-nDCCYY0nsOskg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 11:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYER7-0000UC-8n
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 11:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab1LGKJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 05:09:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42988 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab1LGKJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 05:09:04 -0500
Received: by iakc1 with SMTP id c1so702677iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 02:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L4JHY91o6PCw3K4SKHBgvHFPFKhuw8DRt2syBklz0No=;
        b=x1ZfuKYQQ/qcO1WUrPUYfES7CPhZ3V3DznZiGeg7mtLbXXepI+FHTzcKry2s7qquRz
         pY1Mfu5Nbpof6yD7dOoYFefFWrxqBjDgK127ia8Op4SZUDHbpUU46B9GPwnXrtsL+brE
         bqeHFP51pHCUk8nHgp9IwYaqvvVnLWrOM7hqs=
Received: by 10.42.151.4 with SMTP id c4mr17910321icw.39.1323252543418;
        Wed, 07 Dec 2011 02:09:03 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a2sm2738710igj.7.2011.12.07.02.09.02
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 02:09:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nNtvrLHxQv17jfrFQ=BcwLfgh7eE9X-nDCCYY0nsOskg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186453>

Ramkumar Ramachandra wrote:

> Missing the chaining '&&' seems to be quite a common
> error: I vaguely remember seeing a patch to detect this sometime ago.
> Jonathan?

I guess you mean [1].

If you want to deploy it, you have three choices:

 - maintain a list of tests known to have broken &&-chaining, and
   set GIT_SKIP_TESTS to avoid them

 - fix all cases of broken &&-chaining.  For extra bonus points,
   send out those patches, respond to reviews, and gently usher
   them into Junio's tree

 - modify the &&-chaining tester to output a list of tests encountered
   with broken &&-chaining instead of halting on the first one.

Some day, I'd like to (help) carry out option (b), but please don't
hold your breath.

[1] http://thread.gmane.org/gmane.comp.version-control.git/157903/focus=158265
