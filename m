From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Mon, 8 Dec 2008 19:51:00 +0700
Message-ID: <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
	 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
	 <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
	 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
	 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
	 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
	 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
	 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 13:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9fbH-0002oV-MP
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 13:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYLHMvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 07:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYLHMvF
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 07:51:05 -0500
Received: from ik-out-1112.google.com ([66.249.90.178]:16053 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYLHMvD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 07:51:03 -0500
Received: by ik-out-1112.google.com with SMTP id c29so866528ika.5
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 04:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RXvat/pBXCk7mSsiH/Vf99DzIZ02GyfD+310YjO4MSs=;
        b=qf3i3DnYxoC3VY1egigsRK/70c4t6r93Qeg1qC0/m19cz+hCyfHolOS5Am5Ut2s18w
         isRtk+8A2R7/e3l110R6cgZtzqOAkkg2+izVYDOBopvTgMYKTOdokoLIn7gLcY8uNfSa
         zJjMdZE78JIonMimJDIE08JgXAWI/1z5JvXJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oH0/lqXVEyIkiXzrCVkL6Pi5AfJ8CQr0HWUJZsVBLcmPA7BXE5wphri5FJXYwSvBLa
         Ye+zoEJJotPkA8Fbn119cErhjnvt3FB7BJ8j1AKAr4PBxjU2K3zbZ7WUmViTdKMrVesa
         BHMxRRzokPHrt/U/jvUl99/YQQctclTsyIenU=
Received: by 10.86.29.8 with SMTP id c8mr2595408fgc.67.1228740660838;
        Mon, 08 Dec 2008 04:51:00 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Mon, 8 Dec 2008 04:51:00 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102539>

On 12/8/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  > This was discussed since the beginning of this feature. I recall that
>  > the index reflects worktree, and because we mark CE_NO_CHECKOUT on
>  > file basis, it's best to save the information there, not separately.
>  > We do save high level information to form the checkout area (sparse
>  > patterns) in the last half, but basically you should be able to live
>  > without that.
>
>
> We need to mark in the index the information that reflects the worktree.
>
>  If, however, we take CE_VALID to be the flag for "ignore the worktree
>  entirely at this path; act as it if contains what the index contains" (and
>  use this to cause that aspect of no-checkout), and we then entirely ignore
>  the worktree, including not caring whether there are files there or not
>  (except, of course, that in the transition from caring to not caring for
>  no-checkout, we make the worktree empty, while in the case for
>  "stat-is-expensive", we bring it into agreement with the index), then
>  there is no additional information that needs to be conveyed in the index.

That's not enough. CE_VALID is "ignore the worktree files" while
CE_NO_CHECKOUT is stricter: "those files does (or should) not exist".
The difference is

 - for "git grep", we ignore path with CE_NO_CHECKOUT (while using
cache version for CE_VALID)
 - porcelain-level support to widen/narrow checkout area will need
CE_NO_CHECKOUT, not CE_VALID

>
>  > >  unless it's ever important to remember whether an entry is CE_VALID due to
>  > >  having been outside the checkout when the index was written, even though
>  > >  the checkout area now includes it. I don't have a good intuition as to
>  > >  what ought to happen if the user manually changes what's specified for
>  > >  checkout without actually updating the index and working tree.
>  >
>  > So if a user changes worktree without updating index, they will have
>  > the same results as they do now: files are shown as modified if they
>  > don't have CE_NO_CHECKOUT set. If those files do, they are considered
>  > 'orphaned' or staled and are recommended to be removed/updated to
>  > avoid unexpected consequences (not availble this this first half
>  > series because that belongs to "git status").
>
>
> I was actually thinking that there would be a file for "this is what the
>  user wants to have checked out" (as opposed to the index, which must
>  contain "this is what is checked out"), and the porcelain would instruct
>  the plumbing as to what to do with the worktree (that the plumbing with
>  then ignore, due to the index bit) based on this information.
>
>  The index obviously can't contain the user's full instructions for what
>  should be checked out, because the user will want to say "I don't care
>  about anything in Documentation/" and have this apply to
>  Documentation/some-file-not-in-the-index, so that if this file is in the
>  worktree, the user gets a warning.
>
>  I think you're doing this with core.defaultsparse, although you seem to
>  allow the index to diverge from this easily.

Yes they can.

>
>  The question, then, is what happens when the index and core.defaultsparse
>  disagree, either because the porcelain supports causing it or because the
>  user has simply editting the config file or used plumbing to modify the
>  index. That is, (1) we have index entries that say that the worktree is
>  ignored, and the rules don't say they're outside the sparse checkout; do
>  we care whether we expect the worktree to be empty or match the index?
>  And, (2) we have index entries that say we do care about them, but the
>  rules say they're outside the sparse checkout; what happens with these?

The rule is CE_NO_CHECKOUT is king. core.defaultsparse only helps
setting CE_NO_CHECKOUT on new entries when they enter the index.

So if core.defaultsparse does not match what is in index, that's fine.
You may get more files with "git merge", "git checkout".. but
already-removed files should stay removed.

If you are not happy with core.defaultsparse, you can replace it with
your own tools by manipulating directly CE_NO_CHECKOUT using "git
update-index" and "git ls-files". BTW  the implementation has not had
an easy way to replace core.defaultsparse. You have to modify
apply_narrow_spec(). But if someone really needs it, a hook can be
added.
-- 
Duy
