From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: pull.prompt or other way to slow/disable 'git pull'
Date: Sat, 03 May 2014 04:50:52 -0500
Message-ID: <5364bbfc8c0a0_ac68dd308ce@nysa.notmuch>
References: <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
 <53640bc1ee6eb_135215292ec95@nysa.notmuch>
 <20140502220107.GO28634@odin.tremily.us>
 <53641a1be8d24_1c7bdcd2f049@nysa.notmuch>
 <20140503000530.GP28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 12:01:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgWlF-00072r-8a
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 12:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbaECKBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 May 2014 06:01:34 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:34723 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaECKBc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 06:01:32 -0400
Received: by mail-oa0-f51.google.com with SMTP id l6so6408867oag.10
        for <git@vger.kernel.org>; Sat, 03 May 2014 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=gcdZt7hrMoXAnDbQMWRSMSyBJvv8qfyISQol7IokmLU=;
        b=aFRJVFcMBnrPbKrIPFwDdyB+/tTvdKCE4LcCbO02upWKNDOh7MdzorMP9vyxot1TOC
         wKZKXDRd70NGCHdI5sMI/g4jZlAyj2C5inOstWG6U4u5xK/eYmew3CYqTL3zyEJRAdvI
         7lMW2RcddkRrCqTAjtMajRvYp0rYLGwMwHj4O0hDCx1it8bo5NL35h7CeNq9jTYDUi24
         eECP7ZunGY0vD7mstvKpTPwiz3XGlPYzCV6L9AC1U3LxtjW4jOKde1CusCR2PjT1UF2i
         y/eOoC/wrHGCJSWcb4xFJndxw2o9J5H1ZbDB+9DEuo0NpA8WK/aqE57gukI/AuZ/w5TJ
         wS7g==
X-Received: by 10.60.34.65 with SMTP id x1mr21601311oei.6.1399111292332;
        Sat, 03 May 2014 03:01:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm4155630obm.2.2014.05.03.03.01.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 03:01:30 -0700 (PDT)
In-Reply-To: <20140503000530.GP28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248033>

W. Trevor King wrote:
> On Fri, May 02, 2014 at 05:20:11PM -0500, Felipe Contreras wrote:
> > W. Trevor King wrote:
> > > > > The 'git pull' (with 'none' mode) explainer just helps retrai=
n folks
> > > > > that are already using the current 'git pull' incorrectly.
> > > >=20
> > > > If you are going to train them to use a configuration, it shoul=
d be:
> > > >=20
> > > > % git config --global pull.ff false
> > >=20
> > > I don't want all pulls to be --no-ff, only pulls from topic branc=
hes.
> >=20
> > Pulling some branch to a topic branch, or pulling a topic branch to
> > another branch?
>=20
> The latter.  Here's a more detailed list:
>=20
> 1. HEAD: an integration branch (master, maint, =E2=80=A6)
>    target: @{upstream}, branch.*.pushremote, and other mirrors
>    my preferred integration mode: ff-only merge the target

`git pull` would do that by default.

> 2. HEAD: an integration branch
>    target: a *different* branch (e.g. maint or feature-x, but not
>      origin/master or jdoe/master, if HEAD is master)
>    my preferred integration mode: no-ff merge the target into HEAD.

That makes sense, but other people would be OK with a ff merge.

> 3. HEAD: a topic branch (e.g. feature-x)
>    target: a collaborating topic branch (jdoe/feature-x)
>    my preferred integration mode: ff-only merge the target

I don't see why. It will alomst always be non-fast-fowrward, so you
should already be prepared for a merge (or rebase).

> 4. HEAD: a topic branch (e.g. feature-x)
>    target: a related topic branch (e.g. jdoe/feature-y) or integratio=
n
>      branch updates used by my feature-x
>    my preferred integration mode: rebase feature-x onto the target

Nah. Most people would prefer a merge. And actually, quite many would
want jdoe/feature-y to be rebased on top of feature-x.

Either way it would be impossible for Git to figre out what you want to
do.

> Cases 1 and 2 can usually be distinguished by comparing the
> checked-out branch with the branch portion of the remote-tracking
> reference), but for folks developing in master, jdoe/master may be a
> feature branch (case 2) not a mirror of the maintenance branch (case
> 1).

I'd say they can be distinguished by what the user typed.
=20
> Cases 1 and 3 are the same idea, with any feature branch running long
> enough to get collaborators being indistinguishable from an
> integration branch except that the latter will eventually be merged
> (or dropped) and deleted.

Ineed, so why would you want so drastically different behavior?
=20
> In the event of non-trivial merge conflicts in case 2, I sometimes
> rebase the target onto HEAD and no-ff merge the resulting target'.  O=
n
> the other hand, sometimes rebasing is not an option.  For example, if
> I want to merge the target into both master and maint, but master
> contains a conflicting commit A:
>=20
>   -o---o---A---o---B  master
>    |\
>    | o---o---C  maint
>     \
>      o---D  target
>=20
> Rebasing would drag A into maint at F:
>=20
>   -o---o---A---o---B---E  master
>     \       \         /
>      \       o---D'---  target'
>       \           \
>        o---o---C---F  maint
>=20
> And I don't want both the pre- and post-rebase versions in my history
> at G:
>=20
>   -o---o---A---o---B---E---G  master
>    |\       \         /   /
>    | \       o---D'---   /  target'
>    |  \                 /
>    |   o---o---C---F----  maint
>     \             /
>      o---D--------  target
>=20
> So I'd just deal with a complicated merge at E:
>=20
>   -o---o---A---o---B---E---G  master
>    |\                 /   /
>    | o---D------------   /  target
>     \           \       /
>      o---o---C---F------  maint
>=20
> Case 4 has similar caveats, since you don't want to rebase feature-x
> on top of jdoe/feature-y if there are already other branches based on
> the current feature-x that can't (or won't) be rebased.

What I do in those cases is do both a merge and a rebase. If I resolved
the conflicts correctly in the rebase the result of the merge should be
exactly the same. It's not hard because rerere stores the conflict
resolutions of the rebase and the merge becomes much simpler. After I'm
certain the merge is correct, I remove the temporary rebased branch.

Anyway I don't see how is this possibly relevant to the topic at hand.

> > Either way, since I think these two are different modes:
> >=20
> >   1) git pull
> >   2) git pull origin topic
> >=20
> > Maybe it would actually make sense to have a configuration specific=
 to
> > 2): pull.topicmode.
>=20
> I think it makes more sense to just use merge/rebase explicitly,

=46ine, if you want the user to be explicit, he can be explicit with
`git pull --no-ff origin topic`. Problem solved.

--=20
=46elipe Contreras