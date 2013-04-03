From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Wed, 3 Apr 2013 23:25:36 +0100
Organization: OPDS
Message-ID: <50CA4F4141DD484D97CA8BA571529F65@PhilipOakley>
References: <1364994441-15961-1-git-send-email-cmn@elego.de> <7v4nfn7j5i.fsf@alter.siamese.dyndns.org> <7vtxnn4c02.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 00:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNW7z-0006tz-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 00:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759153Ab3DCWZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 18:25:31 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:11169 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757332Ab3DCWZa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 18:25:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkYLABKsXFFOl3a6/2dsb2JhbABDgweDWoU/t3ABAwGBCxd0ghoFAQEEAQgBARkPAQUeAQEPBQ0FBgIDBQIBAxUBBAIFIQICFAEEGgYHFwYBEggCAQIDAYd9Cq4bkkOBI4xfLWqCNDJhA44zmUODDDs
X-IronPort-AV: E=Sophos;i="4.87,403,1363132800"; 
   d="scan'208";a="405503032"
Received: from host-78-151-118-186.as13285.net (HELO PhilipOakley) ([78.151.118.186])
  by out1.ip04ir2.opaltelecom.net with SMTP; 03 Apr 2013 23:25:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219975>

Sent: Wednesday, April 03, 2013 9:04 PM
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Yes, and since then we gained --no-edit option and such, so "editor
>> starts off" also needs to be rethought, no?  The original wording
>> with "seeded" may have a better chance of survival, I suspect, but
>> still needs some adjustment.
>
> So here is my attempt.  We still need a sign-off from you even if we
> decide to use this version.  Relative to your original patch:
>
> * Using "amend" to explain what "--amend" does felt a bit
>   tautological; I moved the "replaces it" to the opening.
>
> * We do not necessarily launch the editor, and if you give the
>   message in some other way we do not even reuse the original log
>   message.
>
> * Mention --reset-author at the same time mentioning that by
>   default the authorship is carried forward.
>
> * "The commit is prepared as usual" was meant to describe how the
>   content to be recorded (i.e. the tree object contained in the
>   resulting commit) is shaped, but I felt it a bit too unclear
>   without saying either content or tree (it could be some other
>   aspects of the commit like the log message and authorship, etc.)
>   I tentatively replaced it with "The recorded tree is prepared",
>   but there may be a better phrasing.
>
> -- >8 --
> From: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>
> The explanation for 'git commit --amend' talks about preparing a tree
> object, which shouldn't be how user-facing documentation talks about
> commit.
>
> Reword it to say it works as usual, but replaces the current commit.
>
> ---
> Documentation/git-commit.txt | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-commit.txt=20
> b/Documentation/git-commit.txt
> index 19cbb90..bc919ac 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -190,14 +190,15 @@ OPTIONS
>  without changing its commit message.
>
> --amend::
> - Used to amend the tip of the current branch. Prepare the tree
> - object you would want to replace the latest commit as usual
> - (this includes the usual -i/-o and explicit paths), and the
> - commit log editor is seeded with the commit message from the
> - tip of the current branch. The commit you create replaces the
> - current tip -- if it was a merge, it will have the parents of
> - the current tip as parents -- so the current top commit is
> - discarded.
> + Create a new commit and replace the tip of the current
> + branch.

I don't think we should say "Create New" at the start of the sentence,
which may confuse some, rather we should start with the key
'Replace' verb, essentially swapping the parts to say:

 + Replace the tip of the current branch with a fresh commit.
[or updated commit, or new commit, or ...]

>                  The recorded tree is prepared as usual (including
> + the effect of the `-i` and `-o` options and explicit
> + pathspec), and the message from the original commit is used
> + as the starting point, instead of an empty message, when no
> + other message is specified from the command line via options
> + such as `-m`, `-F`, `-c`, etc.  The new commit has the same
> + parents and author as the current one (the `--reset-author`
> + option can countermand this).
> +
> --
> It is a rough equivalent for:
>
> --
Philip=20
