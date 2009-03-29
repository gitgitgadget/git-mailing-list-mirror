From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git svn fails to work
Date: Sun, 29 Mar 2009 07:38:59 +0300
Message-ID: <37fcd2780903282138y2b2a7c68lc9b9f9803206f63d@mail.gmail.com>
References: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP>
	 <37fcd2780903281351w6f77a647kd44a9afe4d2ee953@mail.gmail.com>
	 <7D416C4D4B0B43FB9E0A04FA641CCEE5@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 06:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnmpA-0002nX-DN
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 06:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbZC2EjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 00:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbZC2EjE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 00:39:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:23859 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbZC2EjC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 00:39:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so153237fgg.17
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 21:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZuErM12KxmGgEm5iSlwhgSrombWVRWEM0Z5J8IGvG2Y=;
        b=vBquL5a10NQRgekXAOwhmj7jq2xUafFO02VdMzd8mywSvMf92BswdQiiGj0POj8ffe
         WCdTL3ydrLv5XebiQVwMTDvAPILLDKp7JKSGWUayvMYuURuh3UKIl6b6XnQePEb2sBcg
         4+GXW5CHwzc5PQKenudBnYBu91D+09K+odyxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u9gCHGstIWQJE6YDg52STBdWZ4j0aH8j3wCdxUfRzMdDjOMj3FZYm8Tb/dmJwvWln6
         F+o3BgLkEyfYjIQvtyWb7xdyQ4L4duJX9ND/aYzpmpjyuflQsYKw41U/AFlO3Bu91O8K
         WS4BUgaP5VNO8vK1rYGTg3VI37rXI0j8auI4Y=
Received: by 10.86.82.16 with SMTP id f16mr3296179fgb.32.1238301539267; Sat, 
	28 Mar 2009 21:38:59 -0700 (PDT)
In-Reply-To: <7D416C4D4B0B43FB9E0A04FA641CCEE5@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114997>

On Sun, Mar 29, 2009 at 12:42 AM, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
>
> The commands
>
> =A0 git svn clone http://llvm.org/svn/llvm-project/llvm/trunk
>
> when connection fails I do a :-
>
> =A0 git svn fetch
>
> gitweb is not updating at all to show any change in the repository.

"git svn fetch" only updates the remote branch. In the same way as
"git fetch" only fetches changes from the remote repo and updates
the remote branch. You can see only local branches with gitweb.

So, you may want to run "git svn rebase" instead. (Note: the command
is "git svn rebase" and not "git clone rebase" as you wrote earlier).

"git svn rebase" fetches all changes as "git svn fetch" does but then i=
t
rebases your local commits on the current branch on top of the svn
remote branch. If you do not have any local commits then it just
updates the top of the current branch to be the same.
Note:  Running "git svn rebase" requires that your working tree is
clean (no uncommitted changes).

You can always see all branches and what changes they have by
 running:
   gitk --all &

Dmitry
