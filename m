From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
 available repositories
Date: Mon, 26 Jul 2010 19:50:55 -0500
Message-ID: <20100727005055.GA3882@burratino>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
 <AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
 <AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
 <20100726232855.GA3157@burratino>
 <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	j.sixt@viscovery.net, gitster@pobox.com, git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 27 02:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdYP2-0006LI-C4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 02:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab0G0AwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 20:52:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48862 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab0G0AwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 20:52:09 -0400
Received: by yxg6 with SMTP id 6so301047yxg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jgam5UTxXeb/6RK9iZ5KGDbcnu5RlSado72ErDxds6Q=;
        b=BPNJnrewHjvGDE3movF7b5K/T/3ILCa0U2PI9AJzU6JsyhZN7YwVTQ/k9BsYJM+iCq
         hdMp7eof3bJulXrKFssER5gnuM5UuUWDd+zirUiAEgSJTYz/uwbHuJgfZTxAKS11iXRi
         h0BA/QxpDqqGCnsjaPg3yMLmNQ+pkH23TQJjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BMo/bb9zh6nKyxqm7T6JaOMidQ0HfjUHzr+fViX9ZWlimQ0o6sNzJi5I8Lr8XLB7iv
         q+7niS8NI+wdMiEMI2Z6ynQ3rhK1Q3mHkMtcD0w1WlK+quyokcDmm1skMalMzuQ1CaiB
         Mq80Ie7pVWKYuSeNM0aR5NrNyStDA7udIoQOg=
Received: by 10.101.201.8 with SMTP id d8mr8547160anq.124.1280191926404;
        Mon, 26 Jul 2010 17:52:06 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h5sm7501564anb.28.2010.07.26.17.52.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 17:52:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151907>

Greg Brockman wrote:

> Haha, ok.  Any rules of thumb for how long to wait until resending
> everything is appropriate?

Not that I know of.  Just imagine yourself on the receiving end:
will the resent patches be a welcome relief from the work of
digging up the old ones, or will it be adding to a daunting torrent of
incoming mail?

However:

 - When patches have changed greatly since the previous round,
   there is no easy alternative for continuing discussion beyond
   sending the re-rolled series.

 - When the patches are finally in good enough shape to be pulled,
   there is no way to have an on-list copy of the version merged
   available except to resend.

So in those circumstances, one tends to resend without hesitation.

>> Patch 1 still uses execv(), which is not available on Windows.
>
> It seems to me that the existing git-shell calls execv_git_cmd, which
> uses execvp internally.  I know ~nothing about exec on Windows, but
> presumably it doesn't have just one of execv or execvp.

See compat/mingw.h.

> If it does,
> it would be easy enough to switch the execv to execvp, as the commands
> that are being run are already guaranteed to have a slash.

Yes.

> Not yet.  My $project has deployed an earlier prototype of the patches
> in our dev environment, but we haven't moved it to prod yet.  We'll
> probably do that next week.

Thanks for the update.

Hope that helps,
Jonathan
