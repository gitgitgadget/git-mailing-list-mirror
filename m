Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D9C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C398020771
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="Q8sPaYi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGBSrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:47:51 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:40772 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGBSrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 14:47:51 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 062IlnUN018883
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Jul 2020 14:47:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 062IlnUN018883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1593715669; bh=hHDcuffW0Yv6yIGU2MsOHv73Y0HLekJkxfNTjJ8N7VU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Q8sPaYi6+wP/zMzZNrPw+qYD4fMwWuFRXTceszIAtMFOHb0mgHglpGhgTejonoEme
         /L4lrmbkvExrNBPkSzY/NMzGlRzmLG5lHZ72+xgy2JeafuFYbvIpRC+lHyCROPTK29
         qna4BFp0GtJYVgyJKXYHsGrYzR7vxf3sgdjSRa8nyzq+EAMQBTdy0s2gdd64YW9rz0
         gCStM72/0Yt8UmtroMrfBTFgZyWtHtrcY7u2UoaNCq9az6KJKDpDaLGDNc7JsIo0uG
         T51e+sPTxi2jYLd8r80I30llXzDfS+C4rxd/Rq9Wyuj2LGfQT0IICY1LaybjHcIm4W
         rG7mS/TpQQV6A==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Matthew Horowitz'" <mhorowitz@pdinc.us>,
        "'Jakub Trzebiatowski'" <cubuspl42.1@gmail.com>
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com> <0e9801d6508d$c1f55560$45e00020$@pdinc.us> <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com>
In-Reply-To: <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com>
Subject: RE: Is git compliant with GDPR?
Date:   Thu, 2 Jul 2020 14:47:59 -0400
Organization: PD Inc
Message-ID: <0f0001d650a1$4efc4280$ecf4c780$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI3a36ohrugQlw4W93V7edqWZTq6QHTAPwuAc3sm62oFV9McA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Jakub Trzebiatowski
> Sent: Thursday, July 2, 2020 1:06 PM
>=20
> czw., 2 lip 2020 o 18:27 Jason Pyeron napisa=C5=82(a):
> >
> > > -----Original Message-----
> > > From: Jakub Trzebiatowski
> > > Sent: Thursday, July 2, 2020 11:58 AM
> > >
> > > Hello,
> >
> > First: I am not a lawyer, and even if I were, I (nor anyone else on =
this list) would not be your
> lawyer - get a lawyer.
> I don't think I'm in need of a lawyer. I wanted to start a discussion
> on a topic that in my opinion deserves being discussed, because I'm a
> git user and I believe it's interesting.
> >
> > Second: This thread is likely borderline off topic because for Git =
and GPDR to meet, it would be in
> the context of SaaS or your internal organization. There is almost =
nothing pure Git about these
> issues, see below. Discussion for the sake of it follows.
>=20
> I do agree that that sounds reasonable. But could I ask you why do you
> assume that there needs to be a service (or Software as a Service) to
> make software fall under GDPR? The GDPR definitions don't seem to
> mention that.

You will need to read the whole GDPR, and understand it which is no =
small task. I feel it does, the GDPR says:

=E2=80=98controller=E2=80=99 means the natural or legal person, public =
authority, agency or other body which, alone or jointly with others, =
determines the purposes and means of the processing of personal data; =
where the purposes and means of such processing are determined by Union =
or Member State law, the controller or the specific criteria for its =
nomination may be provided for by Union or Member State law;

=E2=80=98processor=E2=80=99 means a natural or legal person, public =
authority, agency or other body which processes personal data on behalf =
of the controller;

Here your question seems to extend "legal person" from the organization, =
to its systems, and further to the software (e.g. Git) running on those =
systems.

Whereas a SaaS provider is a legal person subject to GDPR or is a "Third =
Party".

>=20
> > >
> > > I've been using git for years, but I've never before taken part in =
the
> > > discussion on the mailing list. I have a simple question, which
> > > probably isn't easy to answer.
> > >
> > > Is git compliant with GDPR, the EU data protection law?
> > >
> > > Before I'm able to commit with git, I'm asked for my first and =
last
> > > name. That is personal data.
> > >
> > > GDPR, Article 4, point (1):
> > > =E2=80=98personal data=E2=80=99 means any information relating to =
an identified or
> > > identifiable natural person (=E2=80=98data subject=E2=80=99); =
[...]
> > >
> > > That data is handled by the git utility. It's sent to other =
parties
> > > operating remote git servers (as a result of my commands, but as =
far
> > > as I know that's not relevant). It sounds like it's being =
processed.
> >
> > Git is like a hard drive or database in your organization. It does =
not do anything else than store
> the information.
>=20
> Storing is processing. I'm not saying that git is evil or wrong, I'm
> saying that it might be the case that it processes personal data (both
> understood as in GDPR).
>=20
> git is also a software created by people and used by people.

Again the relevance is on the organization.

>=20
> >
> > Exception 1: IF you configure it to do so.
>=20
> Sure, it doesn't change much. Processing data initiated by the user
> isn't any kind of distinguished processing, as far as I know.
>=20
> >
> > Exception 2: You are using a SaaS provider (e.g. github.com, =
gitlab.com, etc.)
> >
> > Note: this is no different than any other SCM (e.g. CVS, Subversion, =
file shares, etc.).
>=20
> I'm totally aware. I know how git works, including some of the
> internals, and I'm in general aware of standard solutions in the IT
> industry. Probably if git would be considered non-compliant, then so
> would be other SCMs.

I am referring to configurations that are following organization =
policies, which in themselves are causing the GDPR concerns. E.g. commit =
data is tweeted. Or as Randall S. Becker said on Thursday, July 2, 2020 =
12:41 PM:

> some practices from some of my customers who have this concern, the =
team members are directed to use
> tokenized names and email addresses that can be resolved by their =
security teams during an audit. Obviously=20
> the team members recognize the tokens so they know who is making what =
change. This means that externally,
> any names/emails that might get pushed upstream are non-identifying.

The organization explicitly added GDPR covered information (see European =
Parliament question E-007174/2017).

>=20
> >
> > >
> > > GDPR, Article 4, point (2):
> > > =E2=80=98processing=E2=80=99 means any operation or set of =
operations which is
> > > performed on personal data or on sets of personal data, whether or =
not
> > > by automated means, such as collection, recording, organisation,
> > > structuring, storage, adaptation or alteration, retrieval,
> > > consultation, use, disclosure by transmission, dissemination or
> > > otherwise making available, alignment or combination, restriction,
> > > erasure or destruction;
> > >
> > > This data is processed with a compatible computer owned by the end
> > > user for the purpose of identification of git commits. It's sent =
to
> > > other parties only when specific commands are given. All this was
> > > defined by git authors/contributors (from all around the world).
> > >
> >
> > Again, like any database, you can query it for its contents. What =
you put in it is what it has. If
> you put personal data in, then it is there.
>=20
> It's not a general purpose database, it's a structured database and a
> software that operates on that database. That database has a field for
> personal data, and that data is processed by the software.
>=20

I disagree, but see =
https://blog.sqlauthority.com/2018/01/19/sql-server-make-sql-server-gdpr-=
compliance/ . I think we can all agree if software could be =
complaint/noncompliant, then a SQL server is a perfect candidate. That =
article addresses the issues of how to configure it and the business =
procedures to align with GDPR obligations.=20

That (and only that) discussion I think is very on topic here.

> > Where can data reside in Git?
> >
> > 1. The blobs - e.g. your source code
> >
> > 2. The commit messages.
> >
> > #2 is your most likely candidate of GDPR related activities.
> >
> > Do you use the developers names and email addresses in the message? =
Almost certainly.
> >
> > Note: this is no different than any other SCM (e.g. CVS, Subversion, =
file shares, etc.).
> >
> > > GDPR, Article 4, point (7):
> > > =E2=80=98controller=E2=80=99 means the natural or legal person, =
public authority,
> > > agency or other body which, alone or jointly with others, =
determines
> > > the purposes and means of the processing of personal data; [...]
> > >
> > > Git authors can be considered joint controllers.
> > >
> >
> > The Git distributed model means that COPIES of all of the data are =
on each Git server and developer
> environment. You (and I mean your organization) must address this in =
your IT plans.
> >
> > Note: this is no different than many other SCMs although some others =
SCM technologies only have the
> most recent version locally..
> >
> > > If we'd assume the above interpretations, there would be many, =
many
> > > consequences.
> > >
> > > I'm not a lawyer, and I have no idea if this interpretation is
> > > reasonable. I don't even know if I'd like it to be. But here are =
some
> > > facts: GDPR does focus on protecting the end user. Possibly, it's =
the
> > > most strict data protection law in the world. It doesn't care how
> > > difficult it is to adjust the organisation for compliance and it
> > > doesn't care where the controller is located, as long as it =
processes
> > > personal data of EU citizens (if I understand it correctly).
> > >
> > > Are there any lawyers in the git community? Could The Linux =
Foundation
> > > help with legal support? It's a very non-trivial issue. It's non
> > > obvious how local software relates to GDPR, and it's even more
> > > difficult with Free/Open Source software with many, many authors. =
But
> > > if the aforementioned interpretation was assumed, the git authors
> > > could be held responsible for non-compliance.
> >
> >
> > I have copied our Policy SME, maybe he will have opinions.
> >
> > -Jason
> >
>=20
> In general, I totally agree with everything you said.
>=20
> But you said that git itself (as a software) doesn't fall under GDPR,
> and that's the only thing I'm not sure about. I was wondering if
> someone with a deeper understanding of GDPR would tell my _why_.
> Because when interpreting the law literally, it sounds like it does.
>=20
> Also, to clarify, I'm not seeking legal advice for myself or my =
organization.

-Jason


