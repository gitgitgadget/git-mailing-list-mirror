From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Symbolic refs and the git protocol?
Date: Sun, 25 Sep 2011 19:12:24 +0530
Message-ID: <CAMK1S_joYUKPXDKyomFdbDP4H0UhcwtNQbC89gvNZOTHowYrLw@mail.gmail.com>
References: <4E7F29EB.8000800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@gmail.com>
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 15:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7oyU-000211-PL
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 15:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1IYNm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 09:42:26 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38780 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab1IYNmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 09:42:25 -0400
Received: by vcbfk10 with SMTP id fk10so2227204vcb.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Lnkz8+SHe5QrS/CPP2ZvXdg/YWROBnhLZnaFyi1SYL8=;
        b=OatcU2Pb1dtULBjz2kMmkrTceXW+bcE5RdLnaoH/5kYRf/yLGaXlKlo4DR2g+yGlD9
         yNin6C4eR/TH9bdlYMNPYWyvKNhZTmX1z0TlPyosPTlxe3XUVx3YNZ02mWUjfVpVOSm/
         n85vyOUsxo9M6MpUl4Kt+SyLKrDvScPZMN9cs=
Received: by 10.52.70.180 with SMTP id n20mr5639140vdu.134.1316958144230; Sun,
 25 Sep 2011 06:42:24 -0700 (PDT)
Received: by 10.52.160.161 with HTTP; Sun, 25 Sep 2011 06:42:24 -0700 (PDT)
In-Reply-To: <4E7F29EB.8000800@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182072>

On Sun, Sep 25, 2011 at 6:47 PM, Avi Kivity <avi@redhat.com> wrote:
> With the old kernel.org setup, practically the only think I needed to=
 do on
> the server itself is the 'git symbolic-ref' command (used to point
> refs/heads/linux-next at the correct stream).
>
> Now it looks like kernel.org will no longer offer shell access. =C2=A0=
Is it
> possible to support symbolic-ref via 'git push'?

Can I assume you mean specifically for HEAD, as in 'git symbolic-ref
HEAD refs/heads/some-branch'?

Although gitolite disables shell access by design, it provides several
(optionally installed) features to allow specific shell commands to be
executed.  One such command is "set-head", which does exactly what you
ask.  You run it like 'ssh git@server set-head reponame.git
refs/heads/foo' and it ends up running 'git symbolic-ref HEAD
refs/heads/foo' in the repo.

I realise that does not answer "can it be done via git push" but I
thought it might help...
