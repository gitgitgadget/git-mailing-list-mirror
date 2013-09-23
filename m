From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Mon, 23 Sep 2013 11:26:01 -0700
Message-ID: <20130923182601.GC9464@google.com>
References: <1379875468-24952-1-git-send-email-benoit.person@gmail.fr>
 <vpqsiwwejxz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Person <benoit.person@gmail.com>, git@vger.kernel.org,
	Benoit Person <benoit.person@gmail.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOApo-00034w-EN
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab3IWS0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:26:07 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:60137 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3IWS0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:26:06 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so3540756pbc.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ttvHE20c9N08iK5OO2lUoqXOugvYQLXM6poOBziSLhk=;
        b=d/k5tVDI0G0aP5YDwKLkwNK8p05Am3LLhjgO6rJ1uV31Hc1OqO9WS582/YTY4F1Br6
         JRNN5hPyfp2vD/fs+2s611O4ahiWB87AnMF5bQg1k3VmPkz6wPYRzFzeqBAOpSnKmhHU
         AdJp6crf42XJNXEFpbIrMhjCMOsr8VCliUltVUz/LwGvZ2loAnjfCVbdDD7sFxJPTe/W
         AgadgRF3i9mACEdeHoAJgSfECdTgtNY5ljrGM8K+z/KFtWCWIsBWF0ZqdEe5dEzQfkiL
         iF2tAfGYL5vwW+OHHkB9Q+v0NQiYSNy3MsA86obolyvNL2KYMPTo0Jpngqz0+9ITF1c7
         3+kg==
X-Received: by 10.67.4.227 with SMTP id ch3mr26539303pad.74.1379960765150;
        Mon, 23 Sep 2013 11:26:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id l8sm35675023pbl.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 11:26:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqsiwwejxz.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235213>

Matthieu Moy wrote:
> Benoit Person <benoit.person@gmail.com> writes:

>> For now, if the tests suite is run without the fix, the new test
>> introduces an infinite loop. I am not sure if this should be handled ?
>> (a timeout of some kind maybe ?)
>
> If the patch fix this, then it's not a really big problem. The test
> failure is an infinite loop.

Yes, I think it's fine.

>                              That would be problematic if ran
> non-interactively, but I think it's Ok since we only run the testsuite
> manually.

Some distros (e.g., Debian) occasionally do run the testsuite
automatically, but it is still fine since they have a timeout that
varies by platform to detect if the test has stalled.  I suppose
ideally git's test harness could learn to do the same thing some day,
but for now it's easier one level above since an appropriate timeout
depends on the speed on the platform, what else is creating load on
the test machine, and other factors that are probably not easy for us
to guess.

(other tweaks snipped)

Thanks, both.
