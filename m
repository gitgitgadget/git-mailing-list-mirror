From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 16:38:06 -0700
Message-ID: <20140428233806.GS9218@google.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <535e91e6c69eb_4565148331047@nysa.notmuch>
 <20140428181506.GA20059@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:38:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wev7q-0008OO-Ba
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbaD1XiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:38:13 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35834 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbaD1XiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:38:10 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so6380830pad.35
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q6zBNCxoJfzDU4FgRo8kAokkaYAICHwq0BVewr1p47k=;
        b=D/VOEkU5+HLXi6GqPMQkecTenvQZ1PyKnkCKMATrTpfwSyyNRxCQ7H4XRu5V5udUB5
         Oakxsf4sgOzhof/I0Za9Yizne9Q9K7/PCzdUD+Z4Sx3YNkck/v3ZGsEy7hBZFHgv40X1
         d/U+h8qWiZImhDLuy6b/o4z6Qthr2ZWf+6RqfveFIhqwhPXVjnAbsz0yeK4pcPYlals2
         BLmRIAt1s2ngkyfEhgYo5qJHxmkIhL/y4ZrsLef9DiAbJqtFYPpyHFAtqFB5ZJaaw+NJ
         HbB7D2DzYGIKR0xgQ8Z4+R5+V1i2HMqJ9/jWJ0wOFmjGNf/cNNLKDwsVh003YdKaSpdg
         Z9NA==
X-Received: by 10.66.102.4 with SMTP id fk4mr28735621pab.59.1398728289520;
        Mon, 28 Apr 2014 16:38:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gg3sm37514848pbc.34.2014.04.28.16.38.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 16:38:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140428181506.GA20059@seldon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247496>

Marat Radchenko wrote:
> On Mon, Apr 28, 2014 at 12:37:42PM -0500, Felipe Contreras wrote:

>>> +CC = $(CROSS_COMPILE)cc
>>
>> Nice.
>
> Actually, not. You still have to override CC because it is
> $(CROSS_COMPILE)*g*cc. Any thoughts how to handle this?

One possibility would be something like

	ifdef CROSS_COMPILE
	CC = $(CROSS_COMPILE)gcc
	else
	CC = cc
	endif

Or as Felipe says, you can try to lobby your distro to install the
symlink.

Thanks,
Jonathan
