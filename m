From: Peter Weseloh <peter.weseloh@googlemail.com>
Subject: Fwd: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 18:45:34 +0100
Message-ID: <4db3b0200911290945r34a73346w148ee42e59868876@mail.gmail.com>
References: <loom.20091129T164518-669@post.gmane.org>
	 <20091129164748.GB7921@atjola.homenet>
	 <4db3b0200911290941j42c5a0aaq2c6a9836b38066b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 18:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEnq8-0002yy-Jc
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 18:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbZK2Rp3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 12:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZK2Rp3
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 12:45:29 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:44517 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbZK2Rp2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 12:45:28 -0500
Received: by gxk4 with SMTP id 4so1212033gxk.8
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/lk/TxqqPMOWjcfqQCJz8M0GMpn7BgfMO0fdiwW6I+E=;
        b=UDOoHDKfbOkQAH0nqcysebJ4Y5BNoLYGsvkAgsApUoNJ5UI5xThEs+ZH+hA7L7XqzM
         iTcv0re78UZ+I1SusdLbryVYhSYQUNIa7ySAW46WWlHm2H2p8jXkO9O7dLBlvH762RcF
         3o2CN4xliHtfIym+MC2FXxx/7amS+cLGJzlmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=CS2445FouDE6c5EPdVqdI71n1+0f5QgU7kc7ZhsYVUb2hyMPJQhnJKEvAGIYgG5kn2
         ZyDy9FdCYoYwUri56S9sl0LL6pV+YnWEQGDa2LoPw1uzmCUm2/JP06Wr+BGdeUFtNu0Z
         WpPbGHD+1x3y7ErO0uDtKfmton3JTqogtmOTA=
Received: by 10.101.177.13 with SMTP id e13mr1236166anp.95.1259516734685; Sun, 
	29 Nov 2009 09:45:34 -0800 (PST)
In-Reply-To: <4db3b0200911290941j42c5a0aaq2c6a9836b38066b2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134027>

Hi Bj=F6rn,

=46irst of all thank you very much for your quick reply (actually my
thanks go to all that have replied so far).
Note that at the moment it is just a brain exercise. We are currently
using CVS (yes, I know) and want to switch to something else and I'm
trying to push for git. During our discussions this scenario came up
and I could not give a simple answer. That's why I thought I'd better
ask the experts.


> What's unusual there is that you merged from Mainline to Feature_A.
> Usually, the history would look like this:
>
> =A0 o--o--o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Release_1.0
> =A0/ =A0 =A0\ =A0\
> =A0o-o-o--o--o-o-o-o-o-o---o--o Mainline
> =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /
> =A0 =A0 =A0 F1-----F2------F3 =A0 =A0 =A0Feature_A
>
> And then you could easily use rebase to get the job done.

But on the other hand the intermediate merges from the Mainline make
for much simpler merges, right?.
If merging is done only when Feature_A is ready it might become a real
pain. It might take several month to complete it and the mainline
might have changed a lot.

>
> Had you known beforehand that Feature_A is a candidate for backportin=
g,
> you would have even branch from an older commit like this:
>
> =A0 o--o--o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Release_1.0
> =A0/ =A0 =A0\ =A0\
> =A0o-o-o--o--o-o-o-o-o-o---o--o Mainline
> =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /
> =A0 F1--------F2-------F3 =A0 =A0 =A0Feature_A
>
>
> Then you could easily merge Feature_A to Release_1.0 as well, without
> merging anything unrelated.
>
> But that's just for the future...
>

Yes, sure. If I would know the future already today I would not need
to do any coding anymore :-) But seriously our policy is clear:
Bugfixes (and small enhancements) go to the release branch to end up
in the next minor release. The release branch gets merged with the
mainline so that it is always a superset. Big new features are
developed in seperated branches and are finaly merged to the mainline
to end up in the next major release. But every now and then the
managment is so excited about such a new feature that they want it in
the next minor release. That's life.

>
> Given you current history, you could use format-patch + am like this:
>
> git format-patch --stdout --first-parent Mainline..Feature_A > fa.mbo=
x
> git checkout Release_1.0
> git am -3 fa.mbox
>
> The --first-parent options make it follow the first parent of the mer=
ge
> commits only, so the whole stuff on the Mainline branch is ignored. A=
nd
> you just get F1, F2 and F3 in fa.mbox, which you then apply using am.
>

Ah, great! I played with format-patch + am but missed the
'--first-parent' option. I will give it a try. Thanks a lot!

>
> A long time ago, I hacked the --first-parent thing into rebase, but (=
of
> course) the first iteration of the patch wasn't quite perfect and as
> I've not been scratching my own itch there, I never got around to
> actually polish the patch so it could get into git.git. Maybe you wan=
t
> to pick it up?
>
> http://thread.gmane.org/gmane.comp.version-control.git/62782

In case we go for git this might very well be the case.
>
> Bj=F6rn

Peter
