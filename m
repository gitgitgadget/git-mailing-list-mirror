From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Announce: git-number
Date: Thu, 24 Mar 2011 12:51:48 +0800
Message-ID: <AANLkTinJTy5OkcU+L=nFVwGMNBepuYgAr-+Jk=OVmG6P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 05:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2cWa-00083A-Bb
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 05:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933581Ab1CXEvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 00:51:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60256 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845Ab1CXEvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 00:51:50 -0400
Received: by fxm17 with SMTP id 17so8008012fxm.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=qtyjIPnQsmIiA5Ypgkj1zHgRMmCLWSHafUuMizsmNc8=;
        b=UQ0zykcpXj5n1pDyFz9lJFnQBV4Kuz8EVlHcGZMR2c3fyhMh5BULsLudQqfE6HJyoD
         qa7GAXrFsrD9wsvuTBa4eKGyVHtQNUX63wfA7Pbp19bUjF+Q44REF0A94ZfEitrwc200
         xHL7FpZt12XA7pAwfmW5JesOkpbwuhzh1hZ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=F1dDuFDDFrpaOmpdjyH2bjZLi5gsoDbRb8cIR/1MhXEaABTFvlu7gMBhFHnmwxSl6r
         A/Q2LZerQnl6kjHHlc5uUBQGBwBKaQnWuHsRmstmGLMevkWFpHjjH7X6Kfd9jyrYbmBj
         LI1nmRUFK4EIrV0wVH06Q4Q4rDf6zeclCkF78=
Received: by 10.223.94.129 with SMTP id z1mr515083fam.144.1300942308280; Wed,
 23 Mar 2011 21:51:48 -0700 (PDT)
Received: by 10.223.81.80 with HTTP; Wed, 23 Mar 2011 21:51:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169890>

Hi,

I'd like to announce a little tool that I have been using for the past
few years whenever I use git: git-number.

git-number allows you to use numbers in place of filenames whenever
you need to provide them to any git command.

When run without argument it will run git-status and prepend a number
for each file name that git-status shows, starting from 1:

	$ git number
	# On branch master
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#1      foo/bar/baz/frobnit.fu
	nothing added to commit but untracked files present (use "git add" to track)

The output is exactly the same as git status (with color), but with
numbers associated with each file that is shown.

Now, instead of writing:

	$ git add foo/bar/baz/frobnit.fu

You can just do

	$ git number add 1

Still that's bit too long for my taste so I have this alias:

	$ alias gn='git number'

So that now I can do

	$ gn add 1

or

	$ gn reset 15

Even that is a bit too long for my taste, so I have this alias too:

	$ alias ga='git number add'

So that I can do this instead:

	$ ga 1

Which is equivalent to writing

	$ git add foo/bar/baz/frobnit.fu

It also know ranges:

	$ ga 5-9 11


Like it? Get it here: https://github.com/holygeek/git-number

Caveats:
- It depends on the ouput of git-status, which is porcelain. Caveat emptor.
- I does not work for renames (#42	renamed:    a.txt -> b.txt)

Thanks.

nazri

P.S. I tried adding it to git wiki but had problem verifying my email, the page
said "Invalid confirmation code. The code may have expired.", even on my
second attempt at reconfirming my email.
