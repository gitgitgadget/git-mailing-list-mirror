From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: gitk pays too much attention to file timestamps
Date: Tue, 6 Apr 2010 19:58:41 -0400
Message-ID: <u2r32541b131004061658r555f21dbgbe011960d9152d3c@mail.gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com> 
	<20100406233601.GA27533@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 01:59:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzIfo-0005Mz-MN
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 01:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab0DFX7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 19:59:05 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:39390 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab0DFX7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 19:59:03 -0400
Received: by yxe1 with SMTP id 1so17275yxe.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3K5+MPneFXPhtVU5yCAUnzUmm6I9WbJIyJ4ljvuiLmM=;
        b=ts8CVbWmzUDUHIoFnz8S9+MmpE2ouJbHgfi7sj1yetGJ8A7PKvrEvLHA5iRwXyVXcf
         3Vr4xtATT5SfO9cc7uXIcwPDBiteBY7Gp51Ce80uHF5wTU6k0q/99hrhtkyXDE29WUbI
         32VbgzUcjWTOQBtdJxtNGg75tiYhN3ygaDVGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OnlkdovDdQUrEua2FqyBzk/OTBMkgbMjKYUo2JfBJXYkHOIeLzivv92HCK6pDFytCf
         01O6B4KaCuDWghENmMMx+LnPrEHdj7Wbfs9hYUbaIh6ykX7+U4yRVXEtDnOzQUWRtyRd
         WtkIg1rP48PZl9K68yuVwu1RrtmL42KBbJzYQ=
Received: by 10.150.150.20 with HTTP; Tue, 6 Apr 2010 16:58:41 -0700 (PDT)
In-Reply-To: <20100406233601.GA27533@progeny.tock>
Received: by 10.150.128.4 with SMTP id a4mr8322004ybd.301.1270598341504; Tue, 
	06 Apr 2010 16:59:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144180>

On Tue, Apr 6, 2010 at 7:36 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> gitk is something of a passive observer of the index, which is
> actually something I like about it. =A0This keeps it relatively fast
> and can be useful when trying to understand other commands.
>
> I am not sure how other people use gitk, though. =A0Maybe this would
> be worth changing. =A0For a reference point, another command in a
> very similar situation is =91git diff=92: people who want the speedup
> from avoiding refreshing the index with that command use

Isn't it kind of weird, then, that it bothers to check the stat
information at all?  I'm not sure why I'd want to know accurately
whether or not my file matches the index, but then have gitk fail to
tell me about *what* doesn't match.  If it has to check the stat()
information anyway, isn't it already being slow?

Avery
