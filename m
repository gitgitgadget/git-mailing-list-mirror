Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC933A010
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331364; cv=pass; b=QgqY43KzGyz09axS8h0mDLOfFITkaDKqSOY+8zmqJFse4y2W37HMqarzK2thfZ+6eXVnV0fu6CCSXwGgteh9R2eCi3f+B/tse3hM1oZgYSDzZ4hWbZk8d3mxyjLPBrYv/M5c3tTt+Flp8azHARhrpea8QQsrpHHuvUdss3ymtvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331364; c=relaxed/simple;
	bh=niOFhbz5gBGs5PWEMD0AyavgDCS2JZ/SlXgckEpHptU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gAct1j5Lin0kj0YMJdx0Tu17RJrLbe/5ol1LHkVxXLvq/69oHGHUN5xM0ahizkI+xW/4z7yVGM5k6zvNMUJiBvZMx5st2gRM2GXbxgozfiw+uhrQ+EuMTONL663nHzYoy9rSvrtFG7a88RH3DjDdjs1LfCL9PUEOXpC+ZTRivpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
ARC-Seal: i=1; a=rsa-sha256; t=1771331358; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AYIJYzXh63K2dT+62foYIe1Gp58j6UAmMHxckX7n13ERhwO0FQOj2/6GMfL4TPzgG6CPX/S+WrqnczJecNk7X8hqfMhYk83dszeqi46Ne5jVP4FIjzkRsPGk3cs+X6gyMELEZq69amGjjHOEilBG0Gtd/D+zw99hFBFbZeKNNUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771331358; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NydeNsOJa0bmxIqQLZ5ujspC+AxiRtRu4wzhxZLEAeA=; 
	b=DVNjWQuZ0i0yaUmLXF+xjtPbZBO2FWMoePdx6wEcMYb/15z8p/6qJN4MxyAzM0RhjMSDloNKK2smMuhMLPiVO/c7veSDmZ4Uwe4efd/yWKj8pmGX77MoghI/ReTW4ZwFHzSaQQtXsaFvI2YSEyCSwcYjlIlpXQhMz3evSfXELfU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1771331357392248.266012243555; Tue, 17 Feb 2026 04:29:17 -0800 (PST)
Date: Tue, 17 Feb 2026 07:29:17 -0500
From: Matthew Pellerito <rito@ritovision.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>,
	"git" <git@vger.kernel.org>
Message-ID: <19c6b938a9a.dac9ed8487680.8990157022586832057@ritovision.com>
In-Reply-To: <CAPig+cSb=zzDJCoo91detBgfAi9p4a3R8sVc6iTXfzpbNxsNrg@mail.gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com> <7b785b6064966aefe6883ce3c45e80bb74fe79f4.1770679038.git.gitgitgadget@gmail.com> <CAPig+cSb=zzDJCoo91detBgfAi9p4a3R8sVc6iTXfzpbNxsNrg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gitweb: fix mobile page overflow across
 log/commit/blob/diff views
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Good catch. I just rerolled a cleaner sequencing.


From: Eric Sunshine <sunshine@sunshineco.com>
To: "Rito Rhymes via GitGitGadget"<gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>, "Rito Rhymes"<rito@ritovision.com>
Date: Sun, 15 Feb 2026 18:20:56 -0500
Subject: Re: [PATCH 3/5] gitweb: fix mobile page overflow across log/commit=
/blob/diff views

 > On Mon, Feb 9, 2026 at 6:17=E2=80=AFPM Rito Rhymes via GitGitGadget
 > <gitgitgadget@gmail.com> wrote:
 > > On mobile-sized viewports, gitweb pages in log/commit/blob/diff views =
can
 > > overflow horizontally due to desktop-oriented paddings and fixed-width
 > > preformatted content.
 > >
 > > Add a shared mobile media query to rebalance those layouts: reduce or =
clear
 > > paddings in log/commit sections, keep header/search content within the
 > > viewport, and allow horizontal scrolling for preformatted blob/diff co=
ntent
 > > instead of forcing page-wide overflow.
 > >
 > > Signed-off-by: Rito Rhymes <rito@ritovision.com>
 > > ---
 > > diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
 > > @@ -537,13 +538,6 @@ div.search {
 > >  div.projsearch {
 > >         text-align: center;
 > >         margin: 20px 0px;
 > > -       padding: 0 8px;
 > > -       box-sizing: border-box;
 > > -}
 > > -
 > > -div.projsearch input[type=3D"text"] {
 > > -       max-width: 100%;
 > > -       box-sizing: border-box;
 > >  }
 >=20
 > These lines were all added by patch [2/5], applying to all viewport
 > sizes, but here in patch [3/5]...
 >=20
 > > @@ -691,3 +685,66 @@ div.remote {
 > > +@media (max-width: 768px) {
 > > +       div.projsearch {
 > > +               padding: 0 8px;
 > > +               box-sizing: border-box;
 > > +       }
 > > +
 > > +       div.projsearch input[type=3D"text"] {
 > > +               max-width: 100%;
 > > +               box-sizing: border-box;
 > > +       }
 >=20
 > ...they are relocated to this @media query. It seems a bit odd to add
 > the lines in one patch and then immediately relocate them in the next
 > patch, and it's not clear why the series is constructed this way. I
 > could, perhaps, understand having separate patches like this if the
 > idea is to specially call out the existing "broken" behavior, but
 > considering that the commit message of both patches talk about
 > restricting the width of the input field to fit the viewport, I'm
 > having trouble understanding why the patches are separate.
 >=20
 >=20

