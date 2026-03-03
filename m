Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783A33F5A8
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539740; cv=pass; b=iWun2lGHbunkj4Qbn8V8s1tSC83UzLBEE1AvBUzmKlWCk/xIQKEjafR/jedDkPr9kFr9Py8JIPMHZKcdM4hJ4r0sZp7Bqm0blCjyjugl9QiOCkcKwvS6O72qUR8bfz8TBA2ITVGLVFuQFYmQq5TaQyHyTOju9KcvkLGAl+TgeZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539740; c=relaxed/simple;
	bh=dq/pSc2ER8h/4ItYxfgOWP1cpBH2HlZH120qcz8jFME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfYEBLhEZNp9Ambilz+02vNaSZZ8AzhmuGv1em3lvGTSw/SuSnmBA9sBbIvSBOP3EHB3bDE21sXyP0tJxIkzzwNPC7DsL7tzOcIVYDa+I85Rw05jwhGu08/GHcRndv3E0wD/xHIcQIvW5d2hxqfcOL62m9YBryXeP5hcaFkpbsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVkd57Qt; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVkd57Qt"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a987683baso5528756e0c.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 04:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772539737; cv=none;
        d=google.com; s=arc-20240605;
        b=SyM2MDcUXil1+SMQoSAA0k1e2rC+gwiygUASsUa0HTG9CN7Fiz4vurC21nwBFszHm4
         lua6lhOvkDHSRa1jpNYZ4Uro23zGQYogX2vBkEOMMmBz/IyJdozWGOagspKP0dkjdJwB
         hQWoECmaSgEwb3/C4hCkdM0Ms+2hMcglSmfNLzlMOiJQsXSjfThFwjRqw+FLC+tIojEh
         E8ovnzlQ+nPg8TUipXP+redNTRqRmUPZN6M9K9mNqDts25UXZm7B9H4iHtnCgX/7v2IS
         sTBi7UNkdk3WGalT21potfOrtf6bQjB7YttC9H1GUa6A9g8Jg7MLHUhfULsqOMfvu7ol
         j/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=54mVHzTzRO8uyb1Ol3ubWNXbwtC2rojtCO8CHpAw/Hc=;
        fh=/gGcX06DeFgoFEwRIaFTrJCIQtIJsBTv+VxT9QcwE7I=;
        b=fsd7w6ekWn7Sq/+OIxOVlcpeL2mVdmoT3/RW1mJW5+A/QGaRGyvnDubBZwrCBkVVdC
         6YNSKiMn0e4KhIkdD0jC1Z2HsMWrhnFIS999KUY02hasp1H9K9V/ItmaPm5I2dZUEKW3
         9DKWoxvVR8qAugbXMoFr1eJYOX4YMEyG+ESRr5Yy3znAhhNjerNlPkNHZbjqRgnghiJP
         UOJ7YGUKOvtZhRUz7a2v5DRdVauOl2KCFSlwA+pEavgzyoGfpWpDT8LgX2qdClAV9Jpf
         4VWvFtTdmsbl3Vcx2Ul2XL8LhEXsWcasa0lDvhAlTk37MtqLek4bZfSWxPfATqWHytHU
         NhHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772539737; x=1773144537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54mVHzTzRO8uyb1Ol3ubWNXbwtC2rojtCO8CHpAw/Hc=;
        b=gVkd57QtUYU+o1datML79RjjkOM8QM72eDtmQnLg4F5rrjjbqmxETP/XBoAUglqFJA
         HyHhOBY78qdzO7QrXu6tnW6z+BQj1Km8WgkpayDQDYzJpQH4QgUqu+cf+TByKvTadDvn
         Cjr2kGIwt1CGUlHcyiY5tOX9EDlHHT1AXvz9kCsGaf1pbV0c/L/ADxIzmUmOh1XbCOXi
         LRl0tkUfaQ09UVZLxCDbEjCCbp2O5Hoyx6NTlXdkStusMHAPLGEMaIaJEhPN+AJDmUSk
         npJriWYdhpYYnsTkjY8k7jyWskK5nJK2OxJtfr2uIXHBla1Z4dr+58av0NmEPojdvXIS
         oDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772539737; x=1773144537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54mVHzTzRO8uyb1Ol3ubWNXbwtC2rojtCO8CHpAw/Hc=;
        b=du1xUSh9LaCnwFYKhqzOITdFTje4wZNHca7wwybd1bL42K+mxsQybxre8cZn6anNhr
         Xs7EcnK5tBCvuPlze6b+eS8GguboBQKzoSllEzGwQS2FMd2aUfoqP86XNWn8La1ybvb1
         haQTTclAHIbT4At3OaYWCL/uWRnvunYTFZBMu+BQ7W43UXVJiSCVtsLmAfY2TRLoVbNS
         HqaRI2prBTUraCRc+q9eQ6aokvzlIRZGBCYBqcafiFHryC8kaVOsvoeUQTYh568oe7iE
         YD1vFRSWxnSjDan4vZUabKMtwVYS+UyCdNaXdYs6tijmZgtVT30jDpwaBmLaZ8juxiKK
         AccQ==
X-Gm-Message-State: AOJu0YzC3isg5z02AlmZFZHtYYpHbTpZBpfqNfiOnqVYsG13sur5NMbc
	9238fLI0KvSiNULOPH1Q+1NMPa6xhO+EHSHL8sfoVzmK6SNpo1xT8GnATZKD/w7YlsB0FCoCw96
	jk+Zdx41XESieiZ1Elr3QNktU0m8olC4=
X-Gm-Gg: ATEYQzzCwc4HWL4/jxC6PICTO/3+eU9MBnstDEpwyC53SQMAHfpgGfOMweqAgmAfnv0
	dCSUxrgwvZ+PDU53R7RuU6MrKk/qyveG8SQ4eM1g5aBQ5teo6QxS4o+Pk9R8lZj318czvDZDtlb
	cYEjzolJywi/W7CvwcHnyIn3mCOMjXbkTonObsrCdVBOlC0sOzuzod1qNZBndJ+G6aEBde4XFJ+
	mIhH2f1z/LxKPWJS18JFWNULT9RkksNFRPYpkdKrWnengRMnboSEzfekXpjolsFRzV2wp1Gse8p
	aHji
X-Received: by 2002:a05:6122:4d11:b0:567:5750:c438 with SMTP id
 71dfb90a1353d-56aa09d3083mr7712389e0c.3.1772539737078; Tue, 03 Mar 2026
 04:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local> <CAP8UFD1kzuP8sYKzTJkvf08OazrMzESQ+qZNW8=Qss3DDw=OeA@mail.gmail.com>
In-Reply-To: <CAP8UFD1kzuP8sYKzTJkvf08OazrMzESQ+qZNW8=Qss3DDw=OeA@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 3 Mar 2026 13:08:57 +0100
X-Gm-Features: AaiRm50SKMzQX3F-1lL1HMWXcsB8dDOjxJAp-UmobO20GoiCIi-9QeBzqqJz5K0
Message-ID: <CADYq+fYf0+CYSs8j54WhhrE_=k+dtvznwWTcpX24f6wt4nL0ow@mail.gmail.com>
Subject: Re: [GSoC] [Proposal]: Implement promisor remote fetch ordering
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:27=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Sun, Mar 1, 2026 at 12:27=E2=80=AFAM Abraham Samuel Adekunle
> <abrahamadekunle50@gmail.com> wrote:
> >
> > Hello,
> > This is my proposal for the project
> > "Implement promisor remote fetch ordering" for the 2026 GSoC programme.
>
> Thanks for being interested in Git and this project in particular.

Thank you.

>
> > Personal Bio:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Full Name:  Abraham Samuel Adekunle
> > Email: abrahamadekunle50@gmail.com
> > GitHub: https://github.com/devdekunle
> > Pronouns: he/him
> >
> > About Me:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > My name is Abraham Samuel Adekunle. I love to code, read and I am a
> > harworker. In my free time I love to play games and listen to soothing
>
> I guess: s/harworker/hardworker/

Okay I will fix it

>
> > music and well, also shifting into diffuse thinking to gain a new
> > perspective of whatever challenge I am trying to solve.
>
> [...]
>
> > Contributions to the Git Community:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > My first contribution to the Git community was during the contribution
> > phase of the December 2024 Outreachy contribution phase where I first
> > learned to send patches and had my first interactions with the Git code
> > base. I did not make it through then but it was an opportunity to try
> > again.
>
> Nice that you are trying again.

Thank you :)

>
> > Contributions to other Communities:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I have contributed very sparingly to the Systemd project and also
> > the Linux Kernel.
> >
> > Microproject:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Link: https://lore.kernel.org/git/aV_IGCld5T_dBxTs@Adekunles-MacBook-Ai=
r.local/
> > Branch: aa/add-p-previous-decisions
> > Status: Merged to master
> > Commit ID: 8cafc305e22a59efb92472d4132616e24d3184c6
> > Description:  "git add -p" and friends notes what the current status
> >                of the hunk being shown is
> >
> > Other Contributions:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1.
> > Link: https://lore.kernel.org/git/cover.1771066252.git.abrahamadekunle5=
0@gmail.com/
> > Branch: aa/add-p-no-auto-advance
> > Status: Merged to next
> > Description: "git add -p" learned a new mode that allows the user to
> >               revisit a file that was already dealt with
> >
> > 2.
> > Link: https://lore.kernel.org/git/aWZkEYHhcIhdAjkh@Adekunles-MacBook-Ai=
r.local/
> > Status: Stalled
> > Description: the patch attempts to remove the use of the_repository
> >              global variable in some builtins
>
> It looks like you also have 2 contributions merged from October 2024
> (when you applied for Outreachy). You can mention them too.

Okay I will do that.

>
> > Project Overview and Objective:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > I have always wondered what happens in the background when I see these
> > details on my screen in a "git fetch" process.
> >
> >         remote: Enumerating objects: 57, done.
> >         remote: Counting objects: 100% (57/57), done.
> >         remote: Compressing objects: 100% (12/12), done.
> >         Receiving objects: 100% (57/57), 48.3 KiB | 512.00 KiB/s, done.
> >         Resolving deltas: 100% (21/21), done.
> >         remote: Total 57 (delta 21), reused 13 (delta 5), pack-reused 3=
0
> >         From https://example.com/me/repo
> >         1a2b3c4..5d6e7f8  feature/xyz -> origin/feature/xyz
> >
> > And when I saw this project from the list of projects listed,
> > I was endeared to it as it is an opportunity to work in an area of the
> > that Git code base that will satisfy my curiousity while also being
>
> s/curiousity/curiosity/

Thanks

>
> > mentored by very best and most experienced Engineers there is.
> >
> > When a Git repository is configured with multiple promisor remotes,
> > there is currently no mechanism to specify or optimize the order in
> > which these remotes should be queried when fetching missing objects.
> > Different remotes may have different performance characteristics
> > such as characteristics, cost, or reliability which makes the
> > fetching order an important consideration.
>
> In which order are they currently queried?

In the order they appear in the config file, with promisor remote
configured with the
extensions.partialClone (most likely "origin") bring the last one tried.

>
> > The project aims to implement a fetch ordering mechanism for multiple
> > promisor remotes by designing a flexible system that allows a server
> > to dictate their preferred order to the client to ensure performance
> > and cost management.
>
> A part of the whole system that allows servers to advertise
> information already exists and should be reused.
>
> We use "advertise" instead of "dictate" because the client should be
> able to decide.

I will reword it. Thanks

>
> > Review of Previous Work:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > The project is part of the Large Object Promisor "LOP" effort
> > documented in Documentatio/technical/large-object-promisor.adoc.
>
> s/Documentatio/Documentation/
> s/large-object-promisor/large-object-promisors/

Thank you

>
> > In a bid to better handle large objects, the promisor-remote
> > capability was added to the Git protocol v2, as documented in
> > the promisor-remote section of Documentation/gitprotocol-v2.adoc,
> > which enables a protocol negotiation so that the server can advertise
> > one or more promisor remotes and so that the client and server can
> > discuss if the client could directly use a promisor remote the server
> > is advertising and if an agreement is reached, the client would be
> > able to get the large blobs directly from the promisor remote without
> > the server acting as a relay between the client and the promisor remote=
 when
> > fetching missing large blobs.
> >
> > The ground work for adding this capability to the v2 protocol was
> > started by Christian Couder in [1], where if the "promisor.advertise"
> > config is set to true, the server can then propagate its promisor remot=
e
> > configurations to the client over the v2 protocol during the negotiatio=
n
> > in the form
> >
> >         "promisor-remote=3Dname=3Dprom1,url=3Durl_encoded_value1;name=
=3Dprom2,url=3Durl_encoded_value2"
> >
> > The client can then choose to accept some promisor remotes the server
> > is advertising using the "All", "None", "KnownName" or "KnownUrl"
> > configurations as values for the "promisor.acceptfromServer" config opt=
ion.
> >
> > In [2], Christian added the option for a server to advertise more
> > fields after the "name" and "url", such as "token" and
> > "partialCloneFilter" for the client to use this additional information
> > in deciding the remotes to use as its promisor remotes by comparing it
> > with its local config information.
> >
> > This was implemented by adding the "promisor.sendFields" and "promisor.=
checkFields"
> > config values to the server and client respectively.
> > For example, if "promisor.sendFields" is set to "partialCloneFilter", a=
nd the
> > server has the remote configured like so:
> > [remote "foo"]
> >         url =3D https://pr.test
> >         partialCloneFilter =3D blob:none
> >         token =3D "fake"
> > then
> > "name=3Dfoo,url=3Dhttps://pr.test,partialCloneFilter=3Dblob:none,token=
=3Dfake"
> > will be advertised by the server to the client who can then decide,
> > using the "promisor.checkFields" setting, to check if the passed field
> > matches certain conditions before deciding to use it.
> >
> > This work by Christian is very crucial to this project as I will take
> > advantage of this and enable the advertisement of a "priority" field
> > that the server can use to communicate with the client in deciding to
> > use the server recommended fetch order or not.
> >
> > in [3] Christian also implemented the option "promisor.storeFields" whi=
ch
> > allowed the value of the configuration to be saved in the client's
> > configuration file for use at a later time.
> > As above, this option will also prove important when the server adverti=
ses
> > the "priority" field as it will allow the client decided to store it in=
 its
> > config settings for that promisor remote, for later use when fetching
> > the remaining blobs from the promisor remotes.
>
> Yeah, this is about allowing the server to advertise priority
> information, and the client to accept it or not, but this doesn't talk
> much about how this information will be used to actually change the
> fetch order.
>
> It would be nice if this could talk about which order is currently
> used. You might want to take a look at
> Documentation/technical/partial-clone.adoc, especially the "Using many
> promisor remotes" section.

Okay thank you. I will add that to the v2.

>
> > High Level Approach to Project Execution:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Server Side Advertisement:
> > -----------------------------
> > As the server knows about the promisor remotes which hold the
> > large object blobs,
>
> First I would say "large blob objects" or just "large blobs" instead
> of "large object blobs" if I wanted to talk about them.

Okay thank you

>
> Then it's true that the "promisor-remote" capability in protocol v2
> was developed especially to help with large blobs and the LOP effort,
> but this GSoC project could be useful for any partial clone that uses
> multiple promisor remotes. So you could talk about "objects", not just
> "large blobs".

Okay Noted

>
> > it could recommend the order in which these remotes
> > could be queried by the client using a "priority=3D<value>" field of th=
e
> > promisor-remote capability in the Git v2 protocol, where <value> could
> > be an integer between 1 and 65535, where the smallest integer indicates
> > highest priority.
> >
> > This will be an optional feature which will be enabled by the server
> > if it wants to recommend ordered fetching to the client via
> > the "promisor.sendFields=3Dpriority" config option.
> >
> > Hence if the server advertises promisor remotes prom1 and prom2,
> > it could be of the form
> >         "promisor-remote=3Dname=3Dprom1,url=3Dhttps://prom1.com,priorit=
y=3D10;name=3Dprom2,url=3Dhttps://prom2.com,priority=3D20",
> > if the server is configured as:
> > [remote "prom1"]
> >          url =3D https://prom1.com
> >          priority =3D 10
> > [remote "prom2"]
> >         url =3D https://prom2.com
> >         priority =3D 20
> >
> > If the "promisor.sendFields" values does not include the "priority"
> > field in its comma or space separated options, the field will not be
> > advertised in the promisor-remote capability.
>
> The issue is that right now "priority =3D 10" or "priority =3D 20" if the=
y
> were configured would change nothing in the order used to fetch from
> promisor remotes. So the first thing to do (before having the server
> send that and the client use it or not) is to actually introduce the
> `remote.<name>.priority` config option and make it change the fetch
> order. When that works, it makes sense to allow the server to
> advertise it, and the client to accept it or not from the server.

Yes thank you.
I will fix this in the v2

>
> > 2. Client Side Parsing:
> > -----------------------
> > The client can already use the "promisor.acceptFromServer" option to
> > decide which promisor remotes it will accept, so this new field
> > "priority" might not be significant at all in the deciding phase but wh=
en
> > fetching missing blobs from the accepted promisor remotes.
>
> If that's what you mean, I agree that the priority advertised by a
> server for a promisor remote is not likely to be a (good) criteria on
> the client side to help decide if the client accepts to use the
> promisor remote or not. You might want to reword the above paragraph
> though as it's not easy to understand.

Okay

>
> > Instead, if the client wants to use the server recommended "priority"
> > later when fetching the missing blob from the accepted promisor remotes=
,
> > the "priority" field will be added to the "promisor.storeFields" config
> > options so that the passed value can be saved to the client config.
>
> Yeah, that's the most likely way the client would use it.
>
> > If the client does not enable this option in the config, the "priority"
> > field will not be saved in the local config and the fetching order will
> > default to the local config order.
>
> Right.
>
> > A new config "promisor.honorServerFetchOrder" will be implemented
> > on the client side to determine if the client will use the recommended
> > server advertised promisor remote fetching order or not.
>
> I don't think this is necessary. If the client doesn't want to use the
> priority advertised by the server, it just needs to not add "priority"
> to the "promisor.storeFields" config variable.

Okay thank you

>
> > This config can only be enabled if "promsior.acceptFromServer" is not
> > "None".
> >
> > The options for this config value will be [true|false|local-first] wher=
e
> > "false" (default) ignores server priority and will rely on the current
> > config order.
> > "true" sorts candidate advertised remotes by priority in ascending
> > order (smallest tried first).
> > "local-first" will try remotes in local .git/config first in the order
> > the promisors are placed in the config file  and then
> > server advertised ones ordered by priority, if the object has not been
> > found by now. This last values makes me feel somehow as all objects
>
> s/values/value/
>
> > could have been fetched already but I am just stating my thought proces=
s.
>
> I think we will likely not need something like this. The 3 different
> possibilities could be configured this way:
>
> - to rely on the order advertised by the server: just add "priority"
> to "promisor.storeFields"
> - to rely on local "priority" config: just add "priority =3D XXX" to
> some/all "remote.<name>"
> - to rely on the default order: add nothing

Thank you for the guidance. I will fix all the changes in the v2

>
> > Proposed Project Execution Timeline:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This needs to take into account that the first step should be to
> actually introduce the `remote.<name>.priority` config option and make
> it change the fetch order.

Yes
Thank you for the review.

Abraham
