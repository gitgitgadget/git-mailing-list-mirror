From: Austin English <austinenglish@gmail.com>
Subject: Re: [RFC/PATCH 0/2] Introduce "log.showSignature" config variable
Date: Thu, 26 May 2016 21:55:30 -0500
Message-ID: <CACC5Q1dLZ1qyQ-WDjMC=_-sEr5WZD3Kdv7n=Cd0vzzbsYYpx1A@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 04:56:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67wd-0005AZ-VT
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbcE0C4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:56:11 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34542 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcE0C4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:56:11 -0400
Received: by mail-io0-f196.google.com with SMTP id d197so3767323ioe.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 19:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Baj3yNepYfc/D59Q/x/YlAx9cdG3zU71rfQfd5z/L4=;
        b=ixAzlYztxwFNocv/VbW5VoQOp0XW5+1wBvOOSTnzzZUnCPkEYjhd1pJxv4iwYvihsh
         w7Jz6UDXGAbdj8P0NNTkwMoOWj4tyHODeHtjdmYjG7NQKRlRkdYb/k65sU6wXcarOWFS
         FJ3hJTVcF7BOB8SZQ89es7iLpdw0QQfAu96C2326YziltYMXqRcvX3yVzPwhjMi9sZsk
         dMLC55/1hZrw7DFY3Sgv+/Wq1VE2Siwjb6s6ytY3yUh7vN71S1nGG3aNzYmsE8WYs4DR
         7Y46DSsxB3N6rSycDHXbkKv+MlA+5eeEeHj61aFz0RKJOHN2X4AFpU97Omh3wkjwV5uf
         dH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Baj3yNepYfc/D59Q/x/YlAx9cdG3zU71rfQfd5z/L4=;
        b=D2+hmY13LOQmmvgN50cEsUA540jPl230i9/ToE2rKPhtvq3tEbsrkSUbfiFGk1Exz0
         ociMwOkjRC0CDVfnngzszQsusEnwBXp+OXeVW2JoOUIX6MaIT67kGA94TgznbhgcWxcH
         ASo50e7iKkLzH0NPiyMFZ7KzJquh4Y4pMF1WLvfGZ9ZnSz40mR+biQHusMilxvJbd95j
         XcTZFwEGh9UuwbezplBZkW3O2suep2lmJLQdqjaO2rPGUdWdCMtKE1x/TE3Kh4nBhTkB
         9cYp0M7ywIyIpNWnOFucs7xRr9h9SCU1N6PR2BrcdSOO1EHdDW2A5A7ZiTzVl7w2isW6
         VNng==
X-Gm-Message-State: ALyK8tIhnmhW0kBr0jCj+S+wfPNR88pg53PvsnM6B9/7S789WrRcE/1TxqoNcAP7o9vSUoM3J7QAOXG32iCpdA==
X-Received: by 10.107.17.68 with SMTP id z65mr11917667ioi.150.1464317769605;
 Thu, 26 May 2016 19:56:09 -0700 (PDT)
Received: by 10.79.114.83 with HTTP; Thu, 26 May 2016 19:55:30 -0700 (PDT)
In-Reply-To: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295719>

On Thu, May 26, 2016 at 8:06 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Add a new configuratation variable "log.showSignature" for git-log and
> git-show. "log.showSignature=true" will enable user to see GPG signature
> by default while using git-log and git-show.
>
> [Patch 1/2] introduce the config variable along with some tests.
> [Patch 2/2] tackles the problem: what if user wants to disable the
>             setting of "log.showSignature=true" using a command line
>             switch.
>
> Previous discussion on this: http://thread.gmane.org/gmane.comp.version-control.git/295405
>
> Mehul Jain (2):
>   log: add "log.showsignature" configuration variable
>   log: add "--no-show-signature" command line option
>
>  Documentation/git-log.txt |  4 ++++
>  builtin/log.c             |  6 ++++++
>  revision.c                |  2 ++
>  t/t4202-log.sh            | 26 ++++++++++++++++++++++++++
>  t/t7510-signed-commit.sh  |  7 +++++++
>  5 files changed, 45 insertions(+)
>
> --
> 2.9.0.rc0.dirty
>

Hi Mehul,

Thanks for working on this. With your patch and git config
log.showsignature = true, git log and git show now display signatures
for me:

austin@debian-laptop:~/src/winetricks$ ~/src/git/git config
log.showsignature true
austin@debian-laptop:~/src/winetricks$ ~/src/git/git log -n 1
commit 3399c38411259bf171fc32a3e145bc49fee2291e
gpg: Signature made Tue 10 May 2016 01:04:14 AM CDT using RSA key ID A041937B
gpg: Good signature from "Austin English (Austin English personal
gmail key) <austinenglish@gmail.com>"
Author: Austin English <austinenglish@gmail.com>
Date:   Tue May 10 01:04:14 2016 -0500

    release.sh: allow overridding version

austin@debian-laptop:~/src/winetricks$ ~/src/git/git show
commit 3399c38411259bf171fc32a3e145bc49fee2291e
gpg: Signature made Tue 10 May 2016 01:04:14 AM CDT using RSA key ID A041937B
gpg: Good signature from "Austin English (Austin English personal
gmail key) <austinenglish@gmail.com>"
Author: Austin English <austinenglish@gmail.com>
Date:   Tue May 10 01:04:14 2016 -0500

    release.sh: allow overridding version

diff --git a/src/release.sh b/src/release.sh
index 442df33..03a9462 100755
--- a/src/release.sh
+++ b/src/release.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # Trivial release helper for winetricks
 #
+# Usage: $0 optional_version_name
+#
 # Copyright (C) 2016 Austin English
 #
 # This software comes with ABSOLUTELY NO WARRANTY.
@@ -19,7 +21,7 @@ if [ ! -f Makefile ] ; then
     exit 1
 fi

-version="$(date +%Y%m%d)"
+version="${1:-$(date +%Y%m%d)}"

 if git tag | grep ${version} ; then
     echo "A tag for ${version} already exists!"


Please CC me on future patches if you'd like me to test them. Thanks
again for your help!

-- 
-Austin
