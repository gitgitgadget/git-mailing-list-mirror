From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 14:19:15 -0600
Message-ID: <51419b2c0809091319j2f29b6e1n752cba305c7c1cf6@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <5d46db230809090937k44fc569ct7eda35b9ee86cb22@mail.gmail.com>
	 <e06498070809091029j1e450c43i276c5a69376da3ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <govind@sophiasuchtig.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:20:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd9he-0002kl-Km
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbYIIUTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYIIUTk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:19:40 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:27617 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYIIUTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:19:39 -0400
Received: by py-out-1112.google.com with SMTP id p76so1351432pyb.10
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JbsMzRCOoMKGfsw6NwUnFZEDBuZpIUxm9iGKw6/dxCk=;
        b=qavhTb/C5wVjX83obPYN0b/thTOJTLdkdTp/RDAFdkUCtSygPWles2R5bAK8m7eA7f
         GirPVU0ciCBL+jzNwCzSaG5pH8DRGSFbJNt3zATCPA+Yja2KR+ECiI+WXn+4Idyrl3KT
         L45RmJJUmE6rvaI+TsC0EoPw/u9nusaqdtkyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZKOb+sEYtRbUvH3ucZ5NMa/KK1Uh7/0Ly++v6QagSxLNEdMJBMt3VK7JFqQl2SZMcY
         NvTxk+UM7naIFj76DuJYAFxuHfLooiPx2vcJENq/HdhESkwkaR/WX457ivmSfivznNaf
         FYMTOD9le+YFd7Y6C89MOdzAMezT9T3LigV4Q=
Received: by 10.141.176.4 with SMTP id d4mr139772rvp.14.1220991577899;
        Tue, 09 Sep 2008 13:19:37 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Tue, 9 Sep 2008 13:19:15 -0700 (PDT)
In-Reply-To: <e06498070809091029j1e450c43i276c5a69376da3ab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95423>

On Tue, Sep 9, 2008 at 11:29 AM, Steven Walter <stevenrwalter@gmail.com> wrote:
>> Of course, this is where I would use a DWIM-ism.
>> "pyt revert -r commitish" would generate a reverse patch but
>> "pyt revert <paths>..." would checkout from HEAD.  "pyt revert" would
>> just "git reset --hard".
>
> In yap, "revert" is used to discard working copy changes.  "revert -a"
> reverts all changes; just "revert" replies "nothing to do."  Having
> "pyt revert" = "git reset --hard" makes me queasy; especially in
> Dvorak it's all too easy to hit Enter when reaching for '/'; seems
> like a catastrophe waiting to happen.

I agree with that, and a plain "eg revert" does nothing other than
provide a suggestion for the user as well.

> I tend to dislike "DWIM" in interfaces, because the computer cannot
> read your mind, and can therefore never know with certainty what I
> mean.  Especially in cases where the computer thinks I intend to
> perform an irreversible operation, I want the computer to ask first.
> Not only that, but I think having one command that does 10 different
> things is as confusing as 10 commands that each do one thing.  My

How are these things really different, though?  People occasionally
want to "revert changes".  Now, this may be the changes between 32 and
29 revisions ago, it might be all changes since the last commit, it
could be the changes since 3 commits ago, or it could be just one
specific commit.  The user may want to subset such reversions to just
specific files, but it all boils down to "reverting changes" in the
end.  Now, eg can't yet handle a range like between 32 and 29
revisions ago (because I wasn't sure what syntax I'd want to use for
it), but it's fairly straightforward to say any of:

  eg revert --since HEAD~3  # Undo all changes since HEAD~3
  eg revert --in HEAD~8     # much like git revert HEAD~8, but no
commit by default
  eg revert --since HEAD foo.py  # Undo changes to foo.py since last commit
  eg revert foo.py               # Same as above
  eg revert --in trial~7 bar.c baz.  # Undo changes made in trial~7 to bar.[ch]

What doesn't work is

  eg revert trial~7

since I don't know whether the user wants to revert changes in that
commit, or since that commit (so this is a minor backward
compatibility break I made with core git).  But eg provides a simple
warning with suggestions, which teaches the user the correct command
as well as potentially showing them some new functionality.

Are these kinds of "reverting data" really so different that there
should need to be different commands, or that some of these operations
shouldn't be supported by the simple revert command?  Sure, most users
most of the time will probably use the "eg revert FILE1 FILE2..."
form, but I didn't see the harm in supporting the extra capabilities.

Also...is there anything fundamental that would keep core git from
adopting such behavior?  It'd solve lots of user questions[1], but
would also have some potential backward compatibility issues for
scripts[2] (which may be reason enough to not adopt it, I know).


Elijah

[1] For example, "how do I revert all changes since commit x?", "how
do I revert the recent modification to a certain file?", and "what's
the difference between checkout, reset, and revert?"

[2] commits by default don't make sense for the generalized revert
command, and "git revert REVISION" would error out with instructions
(telling the user to add the --in flag).
