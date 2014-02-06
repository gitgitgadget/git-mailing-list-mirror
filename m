From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t0003: do not chdir the whole test process
Date: Thu, 6 Feb 2014 11:45:21 -0800
Message-ID: <20140206194521.GU30398@google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
 <1391712033-9443-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUt8-0005tN-28
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbaBFTpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 14:45:25 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55633 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbaBFTpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:45:25 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so2141132pab.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jjPz9NitA6uCjZ9UY5A7Me7tiuP4m8uNN2e8Zrw7OCA=;
        b=TI41DHKizUa+azyr1Xk2KEplhd+bkbFkbkLBqtuFto+MU8t5FhH2/tFhL+BiW/XNOS
         iqrvSXloX4WQDhVijXEjsgpTIq5JAppO7yCNwkbx41IKCY6hMcFx2K6tQH3AjnD5hjVQ
         DfB3UTqwnCG9SE+4xx1V0jE2/Bzpjb38wobUeXEWgaX2wX4OrSOSVIMC/UcHrdlrIYsb
         WTutKyalehem7SM0nZRiHGu8BeV9LSnyu/H3yA4y4TXcyQpnsm+TmkKbBMCBHTUc+ql+
         llPCNe4qy1EVeVllaadRh3nghHryOCeBNU/GAf8BtMZlsaGzDgXx/g3KZZcNtD3g/zfI
         Uqow==
X-Received: by 10.68.239.70 with SMTP id vq6mr14250700pbc.152.1391715924773;
        Thu, 06 Feb 2014 11:45:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id x5sm6163071pbw.26.2014.02.06.11.45.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 11:45:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391712033-9443-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241720>

Junio C Hamano wrote:

> Moving to some other directory and letting the remainder of the test
> pieces to expect that they start there is a bad practice.

I agree with the above, and I like the patch...

>                                                            The test
> that contains chdir itself may fail (or by mistake skipped via the
> GIT_SKIP_TESTS mechanism) in which case the remainder may operate on
> files in unexpected places.

... but this logic seems wrong.  I don't think we've ever supported
setup tests failing or being skipped in the past.

Thanks,
Jonathan
