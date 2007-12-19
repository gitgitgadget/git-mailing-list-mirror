From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 11:44:57 +0100
Message-ID: <200712191144.59747.jnareb@gmail.com>
References: <20071214105238.18066.23281.stgit@krank> <m3hcigot3h.fsf@roke.D-201> <20071219093816.GB4361@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 11:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4wQs-00012z-95
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 11:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXLSKpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 05:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbXLSKpO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 05:45:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:13997 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbXLSKpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 05:45:12 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1523689nfb.21
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=a+a/nOLfTdh4GZRrom2jp+3RVNzaZmwyvS0Pt3U4G6s=;
        b=J8yToz4YBhhdbGBnMLSrcxWR+BZF9kIN9zno8JJZPxusJpmDyB73asMBdp32q5146HNT7s5UeWnTVcYybM/O56dS5Eu0mMY3yZgDySSRRTsxrZR09kRpoG0hmkcj6hM2xkEB+tdE2gPkpzWph+0xj826kgxAO0LeISlKThiOrls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PckayIr1UaccAtIh/692WitU0vPOncbmp5WfLDizsu39zx9DxZw18nHtrB4q01h+ht29ST8G6dN1i5bzaj3k04RUiQrL57wxcWoOcCNtGXWC1VEONDEn/lK6oNgldAMoAkRsk8O2mzjQ3rSvPOI+JKSeXA/XEYe5JXt9aPUMs0s=
Received: by 10.78.204.7 with SMTP id b7mr11211675hug.54.1198061110761;
        Wed, 19 Dec 2007 02:45:10 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.93])
        by mx.google.com with ESMTPS id k10sm19357934nfh.2007.12.19.02.45.08
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Dec 2007 02:45:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071219093816.GB4361@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68881>

On Wed, 19 Dec 2007, Karl Hasselstr=C3=B6m wrote:
> On 2007-12-18 08:39:52 -0800, Jakub Narebski wrote:
> > "Catalin Marinas" <catalin.marinas@gmail.com> writes:
> >
> > > On 18/12/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
> > >
> > > >       Remove "stg resolved"
> > >
> > > I'd like to keep this command. git-mergetool doesn't support the
> > > tool I use (emacs + ediff and more stgit-specific file extensions
> > > like current, patch etc.). I also don't find 'git add' to be
> > > meaningful for marking a conflict as solved.
> >
> > I also would like to have this command kept (and shown in 'stg
> > help'!). Contrary to 'git add' it can check and add to index /
> > update index only for files with conflict; we have -r
> > (ancestor|current|patched) to choose one side, and we could add
> > --check to check if there are no conflict markers with files (usefu=
l
> > with -a/--all).
>=20
> This too sounds like stuff that could profitably be added to "git
> add". Except for the ancestor/current/patched words, it is not
> specific to patch stacks, so the implementation should be in git and
> not in stg.

No it cannot, at least the '-r (ancestor|current|patched)' part for
resetting file to given version, even if we change the wording to
ancestor, ours and theirs. The git-add command is about adding contents=
,=20
which updates index, which almost as a intended side-effect clears=20
merge state, i.e. stages; and not about resetting to stage.

Besides with "stg resolved" you can update index _only_ for files
which were in the conflict, also for -a/--all, and not all the files
not only those which were in the conflict like "git add -u" does.

"stg resolved --check" could happily ignore things that only look
like conflict markers, but must have been intended, because they are
in files not in conflict.


Unless you are talking about adding "resolve"/"resolved" command
to git-core, as a porcelain wrapper around git-update-index, like
"git add"...


P.S. I have just noticed that 'git-checkout' [<tree-ish>] <paths>...
form of operation is not documented; you can derive what it do
only from examples.

--=20
Jakub Narebski
Poland
