From: Etienne Girard <etienne.g.girard@gmail.com>
Subject: Re: ancestor and descendant ~ clarification needed
Date: Thu, 22 Oct 2015 14:58:44 +0200
Message-ID: <CAJA=mv4AdGmEOBNugEMemYNvhCqFqpoa0_qs1gpWRXvMJaSg_g@mail.gmail.com>
References: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 14:58:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFSD-0005Lk-QO
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 14:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbbJVM6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 08:58:46 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38847 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbJVM6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 08:58:45 -0400
Received: by igbdj2 with SMTP id dj2so58807306igb.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iidaVucBlpeGWVg0xxYpuZFM8W6wr1kiP9QtApvJ6sg=;
        b=N/y//32RSsAKAlELV//ywysffv9MXQG0ySTfQBhLqHo4L42i+x4OATUWqEu8AMzRtG
         swTCmFJU22ffP49etE/uHmQy3D6vonldIh0e4AzLEVl+AXktd7jSrihiPiDUgupwQ6dN
         //cp3R1e5C0ZLbDRr5qGJBcTkkyseR7+bTrmILsI5kBEIoaYFtrYhkwYpQCM+P9gIrbZ
         +HjlCpHajDqA0nDKrXyre60JyflYmlap4NbEEBWLegT8buczaSMKXkRUCe/I1f8uXRks
         6XQGlMzrlSlJ02v0gQg0QXd/D7nR+UwwGtbZoI3EvQsXkeSl6yFhz3LYFBzkjIZFusQO
         MYyw==
X-Received: by 10.50.50.137 with SMTP id c9mr35480121igo.23.1445518724836;
 Thu, 22 Oct 2015 05:58:44 -0700 (PDT)
Received: by 10.64.87.170 with HTTP; Thu, 22 Oct 2015 05:58:44 -0700 (PDT)
In-Reply-To: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280050>

Hello,

I think you're right, branch A is a descendant of master. We could
change the misleading sentence to "However, if the current branch is a
descendant of the other - if its head is a descendant of the other's
head - [...]", to link back to the definition of descendant for
commits.

2015-10-22 11:06 GMT+02:00 Xue Fuqiao <xfq.free@gmail.com>:
> Hi,
>
> In Documentation/user-manual.txt:
>
>    In the following, we say that commit X is "reachable" from commit Y
>    if commit X is an ancestor of commit Y.  Equivalently, you could say
>    that Y is a descendant of X, or that there is a chain of parents
>    leading from commit Y to commit X.
> [...]
>    However, if the current branch is a descendant of the other--so every
>    commit present in the one is already contained in the other--then Git
>    just performs a "fast-forward"; the head of the current branch is
>    moved forward to point at the head of the merged-in branch, without
>    any new commits being created.
>
> I'm a Git newbie.  According to my understanding, the "descendant" in
> the second paragraph above should be "ancestor".  I attempt to represent
> my understanding using the following diagram (please see it in a
> monospaced font):
>
> ................................................
>
>          o--o--o <-- Branch A
>         /
>  o--o--o <-- master
>
> ................................................
>
> "master" is the current branch, and (as I understand it) it is an
> ancestor of "Branch A", because there is a chain of parents leading from
> "Branch A" to master.  So "Branch A" (i.e., "the other" branch, or the
> "merged-in" branch) is a descendant of master.  I even set up a test
> repository and attempted to test the above diagram with "git merge-base
> --is-ancestor" (and "echo $?"), but it seems to me that the master
> branch is *not* a descendant of "Branch A".
>
> I hope you can understand my words here (English is not my native
> language).  Can anyone point me in the right direction (what am I
> missing)?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
