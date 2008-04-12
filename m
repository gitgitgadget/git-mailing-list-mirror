From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC] git status oddity
Date: Sat, 12 Apr 2008 23:39:25 +0200
Message-ID: <bd6139dc0804121439u3a29f004o8cb6583c5cd5bfa1@mail.gmail.com>
References: <bd6139dc0804120843m2dd2ec3k69a3ba2809f1e955@mail.gmail.com>
	 <7vabjyhiys.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 23:40:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JknSN-0007mQ-JO
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 23:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbYDLVja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 17:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYDLVja
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 17:39:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:62094 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYDLVjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 17:39:25 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1005488wff.4
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GDtZdOVHw9RV5mnvn8+0P+qpfi2NSdi7QTSN0ngTsCU=;
        b=kPLaQVa8BsfDmgPkYiitJcN3l6bnZO2V2/ztVPIsAjPM7F4UwE5yQjRrHBcrs/COmMtbjczhiXzebmzUZUq+ngQDVQZcwPlVp+qvjRamevi8xCngMKHKMEdyCByYcObid3zvrL6oOEx8e3nt9T692gyPUKSqKT2JdyuJpqMBNaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CDTZBeRfirOpkcfSItiHaiAZnR8JuvLvXO09S6Wo8iYypqoinlYSDValjZEtBRw9GfMbHcRHWDSlvWXBVVlLaIabezigo+uLSuiz7E0jTgX+SInL1Bdrz+bRavG08S576Hbpv8OBXLvSNEdpqc/MX8MR+6bvcIFu9KWotQrvJJc=
Received: by 10.142.131.18 with SMTP id e18mr1270573wfd.36.1208036365308;
        Sat, 12 Apr 2008 14:39:25 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sat, 12 Apr 2008 14:39:25 -0700 (PDT)
In-Reply-To: <7vabjyhiys.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79384>

[Apologies for sending it twice, I keep forgetting to hit 'reply to
all' instead of 'reply']

On Sat, Apr 12, 2008 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Sverre Rabbelier" <alturin@gmail.com> writes:
>
>  > ... when I change files in the same directory I commit all
>
> > those in one go. As such I am a great fan of 'git diff .' and 'git
>  > commit .'
>
>  The command in such a work flow for "What has been changed here" is not
>  "git status", but is "git diff <diff args> HEAD .", if "git commit ." is
>  how you make your commits.  --name-status, --name-only or --stat may be
>  a good option to give in that command line.

That is nice indeed, I didn't use 'git diff' for that as it gave me
_too much_ information (the diff, whereas I'm only interested in
one-liners like those in '--name-status' (even --stat is too much).

>  As "git status" is a Porcelain just like "git commit" is, its output
>  format is not holy.  It is not meant to be parsed by scripts and we are
>  free to change its behaviour for human users typing at it and reading from
>  it, provided if the change is worth making.  However, for this particular
>  case, I doubt changing the existing "git status" that is a preview of the
>  next commit is necessary nor has much merit.

Ah, I didn't realize this but it does make sense now that you
explained it, thank you.

>  Not because I think your workflow is minority (I don't), but simply
>  because "git status" is not what you need in this case (you may think it
>  is what you "want", but notice that I said what you "need").

That is of course a possibility, it was more that since it's task is
"Show the working tree status" I thought it was what I need. I don't
mind using another command for what I need, although 'git diff
--name-status .' for example is a lot longer to type than 'git status
.'.

>  This is because "git status <paths>" these days is much less useful than
>  it was originally, after we made --only the default mode for "git commit".
>
>  It used to be that the default for "git commit" was --include.  If you say
>  "git commit foo" when you have some changes already staged, the commit
>  will include what has already been staged plus the latest contents you
>  have in "foo".  With such a system, "git status foo" _was_ a very useful
>  way to remind yourself what changes _other than_ you are naming from the
>  command line are going to be committed.  It still is the default when you
>  are recording a merge commit, as the typical use case is that most of the
>  paths have already been resolved, you fixed up the conflicted ones in your
>  work tree, and you say "git commit <these I fixed up>".  You do not want
>  to record a new commit that ignores what is staged in this case.

I didn't know about this previous behavior, the current situation
makes more sense after this little bit of history, sweet.

>  These days, --only is the default mode of operation.  "git commit foo"
>  commits _only_ the changes made to what you named from the command line,
>  disregarding what you have already staged in the index so far.  Because
>  you are already naming what you want to commit, the value in reminding
>  what others will also be committed, as there is none, has diminished
>  greatly, compared to the days when --include was the default.  It still
>  has value that reminds you what you meant by the dot in "git commit ."
>  (which is essentially what "git diff --name-only HEAD ." is).  It also
>  has value that reminds you what you may need/want to commit after making
>  this commit in this directory.  But it has less information than the old
>  days, because you already know "what will be committed" will not include
>  what you did not name from the command line (in your _particular_ use
>  case, "the current directory"), and "what could be committed" will only
>  consists of the rest (in your _particular_ use case, "outside the current
>  directory").

I would agree, except that (after trying out just now), I noticed that
"git diff --name-only HEAD ." does not list new files. In my workflow
I am definitely interested in new files, is there a way to have 'git
diff --some-switch-here HEAD .' show those too?

>  We could special case and make it not report anything that will be left in
>  the work tree that is different from the resulting commit when --only is
>  in effect, which is what you seem to "want".  But even that should not be
>  the default but be an option, as that mode is robbing from users (other
>  than yourself) the information "what other changes I may still need to
>  commit after this".  But if you are going to give that option and say
>  "git status --commit-only ." there is already existing tool to ask the
>  question you are asking in a more direct way.

Well, it's not just 'git status .' that I would be interested in,
pretty much anything that reduces the size of 'git status' would be
useful indeed. Being able to limit the output of 'git status' (or 'git
diff --names-only', with whatever switch needed to make it show new
files) with an arbitrary filter is pretty much what I want. I
understand better now what other people use 'git status' for now, and
I agree that changing it's behavior in the way I described would mean
robbing them of information. Even so, I still think it makes more
sense to have that information in "git commit -d" but I guess that's
more personal preference than anything (plus I'm biased).

Thank you for your explanation,

Sverre
