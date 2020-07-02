Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE85C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FA020720
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="j5bJ5jJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGBQ1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:27:54 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:54130 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgGBQ1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 12:27:54 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 062GRqUi002078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Jul 2020 12:27:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 062GRqUi002078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1593707272; bh=5O+D8pzL17wJ476QaSGhNpbMfbOybc/3rxItcBeFPOk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=j5bJ5jJveYsGVWSTXteGiKEpzHTY68hCz9wMpuK6KUYa3Uuz8gQ0fzHTT2UC55Otn
         v6xnkX7FNkN4yGNGqUJ4jDuN9P2s5RC1LD/QYDRNpzH5f6CvtqIVXb2rhVTrEYIQBS
         5O9HddsWCMrEtT5Lokgr7i8PmQqbH6q5qOT43opO64hg55BzTpxw8V9Z+KV8V+wMo4
         eIoF0ciFgtnCnez43N4uv4V09bQf/x2b3z+arnxJBl45XnaslPh9SBH2L7dDnBzKl+
         bXvnwSRXOLfpNw7aD2+9j8lDdkqnI0ud/VOBHq/0/z7Gx/1cJo9Mc4yK3G8ebClZK6
         kyfQ71faG87rg==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "Matthew Horowitz" <mhorowitz@pdinc.us>,
        "'Jakub Trzebiatowski'" <cubuspl42.1@gmail.com>
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
In-Reply-To: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
Subject: RE: Is git compliant with GDPR?
Date:   Thu, 2 Jul 2020 12:28:02 -0400
Organization: PD Inc
Message-ID: <0e9801d6508d$c1f55560$45e00020$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI3a36ohrugQlw4W93V7edqWZTq6agyQPZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Jakub Trzebiatowski
> Sent: Thursday, July 2, 2020 11:58 AM
>=20
> Hello,

First: I am not a lawyer, and even if I were, I (nor anyone else on this =
list) would not be your lawyer - get a lawyer.

Second: This thread is likely borderline off topic because for Git and =
GPDR to meet, it would be in the context of SaaS or your internal =
organization. There is almost nothing pure Git about these issues, see =
below. Discussion for the sake of it follows.

>=20
> I've been using git for years, but I've never before taken part in the
> discussion on the mailing list. I have a simple question, which
> probably isn't easy to answer.
>=20
> Is git compliant with GDPR, the EU data protection law?
>=20
> Before I'm able to commit with git, I'm asked for my first and last
> name. That is personal data.
>=20
> GDPR, Article 4, point (1):
> =E2=80=98personal data=E2=80=99 means any information relating to an =
identified or
> identifiable natural person (=E2=80=98data subject=E2=80=99); [...]
>=20
> That data is handled by the git utility. It's sent to other parties
> operating remote git servers (as a result of my commands, but as far
> as I know that's not relevant). It sounds like it's being processed.

Git is like a hard drive or database in your organization. It does not =
do anything else than store the information.

Exception 1: IF you configure it to do so.

Exception 2: You are using a SaaS provider (e.g. github.com, gitlab.com, =
etc.)

Note: this is no different than any other SCM (e.g. CVS, Subversion, =
file shares, etc.).

>=20
> GDPR, Article 4, point (2):
> =E2=80=98processing=E2=80=99 means any operation or set of operations =
which is
> performed on personal data or on sets of personal data, whether or not
> by automated means, such as collection, recording, organisation,
> structuring, storage, adaptation or alteration, retrieval,
> consultation, use, disclosure by transmission, dissemination or
> otherwise making available, alignment or combination, restriction,
> erasure or destruction;
>=20
> This data is processed with a compatible computer owned by the end
> user for the purpose of identification of git commits. It's sent to
> other parties only when specific commands are given. All this was
> defined by git authors/contributors (from all around the world).
>=20

Again, like any database, you can query it for its contents. What you =
put in it is what it has. If you put personal data in, then it is there.

Where can data reside in Git?

1. The blobs - e.g. your source code

2. The commit messages.

#2 is your most likely candidate of GDPR related activities.

Do you use the developers names and email addresses in the message? =
Almost certainly.

Note: this is no different than any other SCM (e.g. CVS, Subversion, =
file shares, etc.).

> GDPR, Article 4, point (7):
> =E2=80=98controller=E2=80=99 means the natural or legal person, public =
authority,
> agency or other body which, alone or jointly with others, determines
> the purposes and means of the processing of personal data; [...]
>=20
> Git authors can be considered joint controllers.
>=20

The Git distributed model means that COPIES of all of the data are on =
each Git server and developer environment. You (and I mean your =
organization) must address this in your IT plans.

Note: this is no different than many other SCMs although some others SCM =
technologies only have the most recent version locally..

> If we'd assume the above interpretations, there would be many, many
> consequences.
>=20
> I'm not a lawyer, and I have no idea if this interpretation is
> reasonable. I don't even know if I'd like it to be. But here are some
> facts: GDPR does focus on protecting the end user. Possibly, it's the
> most strict data protection law in the world. It doesn't care how
> difficult it is to adjust the organisation for compliance and it
> doesn't care where the controller is located, as long as it processes
> personal data of EU citizens (if I understand it correctly).
>=20
> Are there any lawyers in the git community? Could The Linux Foundation
> help with legal support? It's a very non-trivial issue. It's non
> obvious how local software relates to GDPR, and it's even more
> difficult with Free/Open Source software with many, many authors. But
> if the aforementioned interpretation was assumed, the git authors
> could be held responsible for non-compliance.


I have copied our Policy SME, maybe he will have opinions.

-Jason

