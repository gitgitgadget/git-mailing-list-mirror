From: Thomas Moulard <thomas.moulard@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Tue, 21 Sep 2010 16:59:12 +0200
Message-ID: <AANLkTimm=x37EiyGObfJ_gdU6OtGbdCCOEw0XjVDH_oQ@mail.gmail.com>
References: <1285080133451-5555023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 16:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy4JY-000172-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 16:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab0IUO7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 10:59:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58222 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab0IUO7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 10:59:14 -0400
Received: by wyf22 with SMTP id 22so5476825wyf.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=y3S3oMenBLVmoE00sXRzaJIuGhmwfRd+qT/gws9C/fs=;
        b=jzBxehBt0cqs1fs8TEXpACXM0phWyLWZqz5FqwHXknyX70nRcQoEtPP6ymkAkBnRMs
         GFRHr9Dm51AU/pICgcw0+d+IdlnOcuFy+hZhMf1efU5TU5ZtcYnUl9I3T8oSW6XNgTqf
         hhTvdFIRIPpaMSMsd6eu+9KTqJqPMwGJMFkzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rWk/wmaHwge+fDA/WLyMXd+lDz2zk3Z3K4HMV7QikfeXtaFj0UdjILVHXwfik1NTvQ
         NDzIK7HnFhJzTp21d2wTs4PFaNgDqm22Ei7vIKzHy32krhijojN0ZYlnIu2vpUAC1IfH
         CYSBiCNobX1ctQgNerkz+xev0ZUyTrvK3Nwvk=
Received: by 10.227.157.13 with SMTP id z13mr3411251wbw.184.1285081153006;
 Tue, 21 Sep 2010 07:59:13 -0700 (PDT)
Received: by 10.216.135.229 with HTTP; Tue, 21 Sep 2010 07:59:12 -0700 (PDT)
In-Reply-To: <1285080133451-5555023.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156728>

Hi!

On Tue, Sep 21, 2010 at 4:42 PM, FernandoBasso
<FernandoBasso.br@gmail.com> wrote:
>
> I am really a beginner in. Bear with me please.
>
> Why do we merge, say a testing branch into the master branch ? What is the
> use of it ?

Ususally, one develops a feature on a separate branch to avoid polluting
the "master" branch with non working or fragile commits and prevent other people
from working.

You always merge a branch into the branch you *are* in.
For instance:
# Switch to master branch.
$ git checkout master

# List the available branches.
$ git branch
* master
  my-new-feature

# Merge the topic branch into master.
$ git merge my-new-feature

Here what I call a topic branch is what you call a "testing" branch.

>
> When there is a conflict when merging branches (merging the testing into the
> current branch), should I edit the 'current' branch or the 'testing' branch
> ?

If there is a conflict, in theory it means that *both* sides have
change a same location
in a tracked file.
Usually, it means that you have to take *both* contents and depending
on the context
write manually the result.

For instance, one can fork master to create a topic branch, then
changes are made
in the topic branch and in master. When you merge back your topic
branch you want
to integrate your changes but also preserving the changes that have
been made to master
between the time the topic branch has been created and now.

> Should both branches have exactly the same code so that they can be merged
> without conflicts ?

In general, yes.
Please note that git can work around whitespace problems (whitespace
versus tab and \n versus \r\n).

You may also want to google "git workflow" to get a rough idea about
how to manage a project
with git and how to do more advanced stuff with topic branches.

I hope it helps,
-- 
Thomas Moulard
