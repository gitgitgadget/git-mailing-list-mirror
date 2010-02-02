From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: cat: .git/rebase-merge/head-name: No such file or directory
Date: Tue, 2 Feb 2010 20:25:05 +0100
Message-ID: <40aa078e1002021125l5de7dc4fv8eb5d89c9015f26a@mail.gmail.com>
References: <40aa078e1002021120u1a692301q1c4f6a952d4df5a3@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:25:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcON7-0005U6-A3
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173Ab0BBTZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:25:08 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:34837 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756963Ab0BBTZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:25:07 -0500
Received: by ey-out-2122.google.com with SMTP id d26so101897eyd.19
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=hM+GCj2b2Ob/FSSvF0T7BVy4aQxmnS9xdJ0dUshi42s=;
        b=imSR9uOafaVyPtMKSWnEmGq0CZP+Agt0w4Qdqyca0CUs2c2RdPTbDBPLOK/R9GotwH
         JqrCrs0Fn2+GwfsLWsPR313tGD01NtMRzo7EcaLoKtH8fQ0GCRnOd2Roq0lG2v11XWju
         +ir++1pEYk4l7GN3/fuU3IR2H/hYXTPaqXCBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        b=NMhuCAAeL+4tuKn/euXSjDBFxiAisaG4ZbtpbVbG94akNGH4Y1tSR/cCRf+m1AAgmW
         Jx/eFY3r7C0fIDLNdSHybOO78DWhX3U3Y3BBtc5ZTu4nkfS3BebSHydzRyH4ytFGW/KJ
         aacfa02XAxQ+i3J86TU6ALdGGqicwzbW7QrkM=
Received: by 10.216.88.136 with SMTP id a8mr4133261wef.77.1265138705623; Tue, 
	02 Feb 2010 11:25:05 -0800 (PST)
In-Reply-To: <40aa078e1002021120u1a692301q1c4f6a952d4df5a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138741>

On Tue, Feb 2, 2010 at 8:20 PM, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> I just applied an interactive rebase to one of my repos, and got a
> pretty confusing error message:
>
> $ git rebase -i HEAD~4
> <edit, rebasing ticked forward to the end>
> rm: cannot unlink `/c/Users/kusma/Documents/My
> Dropbox/src/gb-asm/.git/rebase-merge/done': Permission denied
> rm: cannot remove directory `/c/Users/kusma/Documents/My
> Dropbox/src/gb-asm/.git/rebase-merge': Directory not empty
> cat: .git/rebase-merge/head-name: No such file or directory
> $ git diff
> cat: .git/rebase-merge/head-name: No such file or directory
> $ git status
> # On branch asm-test
> nothing to commit (working directory clean)
> cat: .git/rebase-merge/head-name: No such file or directory
> $
>
> Now, I figure that rm failed due to my virus scanner kicking in, so
> that's no mystery. And there is a commit in msys AFAIK that makes
> unlink retry on failures. So I expect the issue to go away in future
> versions. However, I'm not entirely sure what to do to repair my repo,
> though.
>

OK, it turns out these "cat: .git/rebase-merge/head-name: No such file
or directory"-errors are caused by the bash-completion that I
foolishly removed in an attempt to reduce noise. "git show-branch"
shows the correct branch for me.

-- 
Erik "kusma" Faye-Lund
