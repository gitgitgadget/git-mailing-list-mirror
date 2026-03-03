Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E32382F04
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530066; cv=pass; b=apnE3kusdoMC9yPHa+/vTcRoN0K7+IU4pVhKJ479qVfCKAcAQDQ7AbWR9dBvHzPrLVPzDQeuan2H4kx5O85VfK0jv4qDpJ4CSynZAE13pey2EIqx3Ny5999Yb0odOnHoT8BzCN2Y83rE57ePFbVLbeQT0R8kULHVOJRn/yqtToo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530066; c=relaxed/simple;
	bh=49aKvi92eB55spXT46dDcos/FQVK5wMZo+f3XKJuwVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwnUHGltiVoMBz4dDlOFbGCVdRHqgPkMy0G0ma+yuUqGyLbE4slWinIxGGam5MeHHeJKc6/eX9QPenzrxNhfOZdfV2KoFO5S23BbR5+lUv2AJ1P3bvePSacD60YzmafaUZQBxHeydoyTH1YhbsnNypHP4JDHyc/IMrH87eIj3tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcetcQak; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcetcQak"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732e6a123so1401743c88.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 01:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772530064; cv=none;
        d=google.com; s=arc-20240605;
        b=jF/8iEQycosFRuC8fkNI9zqamsxXn9kRrvRiOuP+GBGOcI1Yxhxcse2npA1CVo1yuW
         Z4/et26/BB6A2fLBcy3uIWprLKnM4Zwd+A+4hHmS98qp6twcRDRf9k5x2gx7W/o/Y0yu
         QWKSo8jJYIERCso1l4JyqnUpQTaOFo1d04cuXW/ivA5tx3fIEYvWT3MZM2lpPEUxP3Lv
         Qe1Yww5Ymudz9vL2vT0ycX5TgMp62fNgS9xP218ODMcFFUVD0JgWgrTNhxRbFuJ78moK
         O96KwfTmr5jQi/GUHO6dB9IaeDA6DZm0A6htI13NoSBsP8q7Sk9YylYcvnx2reYJ27fh
         e4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGtcF77/o/+97FWQNK81Omd+OSid67Wk5AXTakENa7U=;
        fh=lTfQVUOxvx+BtGC8eiUlK74R0gQvsfN538dEofM7fAc=;
        b=KSoD8dnJi+8dHQA9ofsTZ1MKAf71EiRe8ZErZ4Mx+FK6FaKsFM2IOQmwYREoRBAnGJ
         LtZEnM3xAqJ00poX+NN2tpFGryca6iFM6FdkLojkMhg/zt1nLrv7gKww7TNMFr/pVxzB
         S2KacmWY7VF08cI3MREHHIHq5/oR0PJiB6VbfVlw/Zc9q0iu1tnD40fMBnk3BKJN2w8Y
         /x4Ouun+rvbRUhn5PN3pfOpIizoO0HATxjIngrp1JCm1ft+MBu2ybITh9P2/vAMC/kQ/
         19e8bq8x0eDx2mcjl5TiX8XmMoqGZzcKQmouyP4+u97LuhkIxIvu8gQ1t7v4lP7PRo86
         5d/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772530064; x=1773134864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGtcF77/o/+97FWQNK81Omd+OSid67Wk5AXTakENa7U=;
        b=XcetcQak89CEVGcv3jVkgpLhn97BsuN94Hpy5gMHoBuPuUs5jdWQyA3wE+yvUH56yv
         c0zHfRCcfyoqrNUKS6VlAA8qEGGWMo59fNiJ4fKZAOP1TQ6/6fGBh70eHMIhzcNBDQCp
         F/y7ahS3DeOFrVyj5C8aoGTsRMiJ4r15BWKSZi5Z0621MHxlK4RNEtoizE90QEQ4pdVj
         L+QyawLfa5YcSfea/JENU0YflzIAmpvSgF5NdIImKAq1raUbVok2Km45NfGcNkXJ879u
         vFoMgXQE3BvBF+9UY4YAyMQyyUXHrVeJLYXvE9aKwFB7YQ9CE1BTKwi+gG3L2tOQmogd
         Uayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530064; x=1773134864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGtcF77/o/+97FWQNK81Omd+OSid67Wk5AXTakENa7U=;
        b=l0oeS0nXRxUq1TIxN8pqlHDIsOjOTXiYs9XKJJOX6KGIk81f2UmLBx6v2MmTZn61Kx
         /rZ0BnUZJvw6FCqimS6DbHsD3IfUmfjD1HAPxy90xXdv0/LtS8VPYvV5fxXJ1AiCojCh
         7gsDFOnTw1S0fRAJ9XU/1m0JftJBxvuyfNFaq9Btwv8GKqjw/2BF4a6FYZxc1y8ulQit
         Sb8/Kg/5/2kn0pt1mTdgd6gjEVb++FvdHHEjF6TRXd/8mtRmv53w49XxQPfn7jrK9acF
         7NUftXrP8sW7l88O7MzQs+dY/LO002Mbn6wlfrvbJFS0yvCrO4dQ4YwFUM7y9vcjSiIG
         qOPQ==
X-Gm-Message-State: AOJu0YwDNcnQKdXg5E/bV/igkgXCHfGZ4dXRkRepBAbEDQaeTrGbyrHm
	DM7HIanryTgvohUpW2aOkY04GQ5qxhYh/m1omT9ih6m2ZVu68NHA1RtdtJkR3CMkkZeJVGWXWKj
	VxWMnS0Zuqh/t2oOnnpS/1cXdp7kTftw=
X-Gm-Gg: ATEYQzzJLEsmUFPa4mmmJrVWBEghQ9k7v+lkk9/Q77vZzN6qhlOe0KkzNGdAdy7PBYA
	NgsMsCGQaNaOwvsEs7QgAsSb7na/yHETdCe1zflV6qcjOpUicYn8nsDsYqgrAoYqVr7ARRDdwZF
	sFG3j0aAr+jeFvJ93TGDlDqqpiOekN6mMovVTJ8FAqktwhN2z3KRyNH250zjSbRmV5x4+pYs4rI
	oyC71NmIFx1Fx/hrsvwjc4vVBf+vJdfdax3BE6ODjuxo11RAuI2dSXLWMNmAP5dNttLeIl37KBc
	LYOlrlPHSjJbYwGYFuf4DPoJNuv7Sw5K7FdnwkupMclVxc0kmNmbHZme+JMQj/N9N1wy
X-Received: by 2002:a05:7022:6296:b0:123:348d:8576 with SMTP id
 a92af1059eb24-1278fc99590mr7807643c88.6.1772530064026; Tue, 03 Mar 2026
 01:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local>
In-Reply-To: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Mar 2026 10:27:32 +0100
X-Gm-Features: AaiRm50u4CUoILM3I75w18hJvUIvNBh537gSFweDa-V26OomtKqGx-JxKq83sos
Message-ID: <CAP8UFD1kzuP8sYKzTJkvf08OazrMzESQ+qZNW8=Qss3DDw=OeA@mail.gmail.com>
Subject: Re: [GSoC] [Proposal]: Implement promisor remote fetch ordering
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 1, 2026 at 12:27=E2=80=AFAM Abraham Samuel Adekunle
<abrahamadekunle50@gmail.com> wrote:
>
> Hello,
> This is my proposal for the project
> "Implement promisor remote fetch ordering" for the 2026 GSoC programme.

Thanks for being interested in Git and this project in particular.

> Personal Bio:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Full Name:  Abraham Samuel Adekunle
> Email: abrahamadekunle50@gmail.com
> GitHub: https://github.com/devdekunle
> Pronouns: he/him
>
> About Me:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> My name is Abraham Samuel Adekunle. I love to code, read and I am a
> harworker. In my free time I love to play games and listen to soothing

I guess: s/harworker/hardworker/

> music and well, also shifting into diffuse thinking to gain a new
> perspective of whatever challenge I am trying to solve.

[...]

> Contributions to the Git Community:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> My first contribution to the Git community was during the contribution
> phase of the December 2024 Outreachy contribution phase where I first
> learned to send patches and had my first interactions with the Git code
> base. I did not make it through then but it was an opportunity to try
> again.

Nice that you are trying again.

> Contributions to other Communities:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I have contributed very sparingly to the Systemd project and also
> the Linux Kernel.
>
> Microproject:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Link: https://lore.kernel.org/git/aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.=
local/
> Branch: aa/add-p-previous-decisions
> Status: Merged to master
> Commit ID: 8cafc305e22a59efb92472d4132616e24d3184c6
> Description:  "git add -p" and friends notes what the current status
>                of the hunk being shown is
>
> Other Contributions:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1.
> Link: https://lore.kernel.org/git/cover.1771066252.git.abrahamadekunle50@=
gmail.com/
> Branch: aa/add-p-no-auto-advance
> Status: Merged to next
> Description: "git add -p" learned a new mode that allows the user to
>               revisit a file that was already dealt with
>
> 2.
> Link: https://lore.kernel.org/git/aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.=
local/
> Status: Stalled
> Description: the patch attempts to remove the use of the_repository
>              global variable in some builtins

It looks like you also have 2 contributions merged from October 2024
(when you applied for Outreachy). You can mention them too.

> Project Overview and Objective:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> I have always wondered what happens in the background when I see these
> details on my screen in a "git fetch" process.
>
>         remote: Enumerating objects: 57, done.
>         remote: Counting objects: 100% (57/57), done.
>         remote: Compressing objects: 100% (12/12), done.
>         Receiving objects: 100% (57/57), 48.3 KiB | 512.00 KiB/s, done.
>         Resolving deltas: 100% (21/21), done.
>         remote: Total 57 (delta 21), reused 13 (delta 5), pack-reused 30
>         From https://example.com/me/repo
>         1a2b3c4..5d6e7f8  feature/xyz -> origin/feature/xyz
>
> And when I saw this project from the list of projects listed,
> I was endeared to it as it is an opportunity to work in an area of the
> that Git code base that will satisfy my curiousity while also being

s/curiousity/curiosity/

> mentored by very best and most experienced Engineers there is.
>
> When a Git repository is configured with multiple promisor remotes,
> there is currently no mechanism to specify or optimize the order in
> which these remotes should be queried when fetching missing objects.
> Different remotes may have different performance characteristics
> such as characteristics, cost, or reliability which makes the
> fetching order an important consideration.

In which order are they currently queried?

> The project aims to implement a fetch ordering mechanism for multiple
> promisor remotes by designing a flexible system that allows a server
> to dictate their preferred order to the client to ensure performance
> and cost management.

A part of the whole system that allows servers to advertise
information already exists and should be reused.

We use "advertise" instead of "dictate" because the client should be
able to decide.

> Review of Previous Work:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The project is part of the Large Object Promisor "LOP" effort
> documented in Documentatio/technical/large-object-promisor.adoc.

s/Documentatio/Documentation/
s/large-object-promisor/large-object-promisors/

> In a bid to better handle large objects, the promisor-remote
> capability was added to the Git protocol v2, as documented in
> the promisor-remote section of Documentation/gitprotocol-v2.adoc,
> which enables a protocol negotiation so that the server can advertise
> one or more promisor remotes and so that the client and server can
> discuss if the client could directly use a promisor remote the server
> is advertising and if an agreement is reached, the client would be
> able to get the large blobs directly from the promisor remote without
> the server acting as a relay between the client and the promisor remote w=
hen
> fetching missing large blobs.
>
> The ground work for adding this capability to the v2 protocol was
> started by Christian Couder in [1], where if the "promisor.advertise"
> config is set to true, the server can then propagate its promisor remote
> configurations to the client over the v2 protocol during the negotiation
> in the form
>
>         "promisor-remote=3Dname=3Dprom1,url=3Durl_encoded_value1;name=3Dp=
rom2,url=3Durl_encoded_value2"
>
> The client can then choose to accept some promisor remotes the server
> is advertising using the "All", "None", "KnownName" or "KnownUrl"
> configurations as values for the "promisor.acceptfromServer" config optio=
n.
>
> In [2], Christian added the option for a server to advertise more
> fields after the "name" and "url", such as "token" and
> "partialCloneFilter" for the client to use this additional information
> in deciding the remotes to use as its promisor remotes by comparing it
> with its local config information.
>
> This was implemented by adding the "promisor.sendFields" and "promisor.ch=
eckFields"
> config values to the server and client respectively.
> For example, if "promisor.sendFields" is set to "partialCloneFilter", and=
 the
> server has the remote configured like so:
> [remote "foo"]
>         url =3D https://pr.test
>         partialCloneFilter =3D blob:none
>         token =3D "fake"
> then
> "name=3Dfoo,url=3Dhttps://pr.test,partialCloneFilter=3Dblob:none,token=3D=
fake"
> will be advertised by the server to the client who can then decide,
> using the "promisor.checkFields" setting, to check if the passed field
> matches certain conditions before deciding to use it.
>
> This work by Christian is very crucial to this project as I will take
> advantage of this and enable the advertisement of a "priority" field
> that the server can use to communicate with the client in deciding to
> use the server recommended fetch order or not.
>
> in [3] Christian also implemented the option "promisor.storeFields" which
> allowed the value of the configuration to be saved in the client's
> configuration file for use at a later time.
> As above, this option will also prove important when the server advertise=
s
> the "priority" field as it will allow the client decided to store it in i=
ts
> config settings for that promisor remote, for later use when fetching
> the remaining blobs from the promisor remotes.

Yeah, this is about allowing the server to advertise priority
information, and the client to accept it or not, but this doesn't talk
much about how this information will be used to actually change the
fetch order.

It would be nice if this could talk about which order is currently
used. You might want to take a look at
Documentation/technical/partial-clone.adoc, especially the "Using many
promisor remotes" section.

> High Level Approach to Project Execution:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Server Side Advertisement:
> -----------------------------
> As the server knows about the promisor remotes which hold the
> large object blobs,

First I would say "large blob objects" or just "large blobs" instead
of "large object blobs" if I wanted to talk about them.

Then it's true that the "promisor-remote" capability in protocol v2
was developed especially to help with large blobs and the LOP effort,
but this GSoC project could be useful for any partial clone that uses
multiple promisor remotes. So you could talk about "objects", not just
"large blobs".

> it could recommend the order in which these remotes
> could be queried by the client using a "priority=3D<value>" field of the
> promisor-remote capability in the Git v2 protocol, where <value> could
> be an integer between 1 and 65535, where the smallest integer indicates
> highest priority.
>
> This will be an optional feature which will be enabled by the server
> if it wants to recommend ordered fetching to the client via
> the "promisor.sendFields=3Dpriority" config option.
>
> Hence if the server advertises promisor remotes prom1 and prom2,
> it could be of the form
>         "promisor-remote=3Dname=3Dprom1,url=3Dhttps://prom1.com,priority=
=3D10;name=3Dprom2,url=3Dhttps://prom2.com,priority=3D20",
> if the server is configured as:
> [remote "prom1"]
>          url =3D https://prom1.com
>          priority =3D 10
> [remote "prom2"]
>         url =3D https://prom2.com
>         priority =3D 20
>
> If the "promisor.sendFields" values does not include the "priority"
> field in its comma or space separated options, the field will not be
> advertised in the promisor-remote capability.

The issue is that right now "priority =3D 10" or "priority =3D 20" if they
were configured would change nothing in the order used to fetch from
promisor remotes. So the first thing to do (before having the server
send that and the client use it or not) is to actually introduce the
`remote.<name>.priority` config option and make it change the fetch
order. When that works, it makes sense to allow the server to
advertise it, and the client to accept it or not from the server.

> 2. Client Side Parsing:
> -----------------------
> The client can already use the "promisor.acceptFromServer" option to
> decide which promisor remotes it will accept, so this new field
> "priority" might not be significant at all in the deciding phase but when
> fetching missing blobs from the accepted promisor remotes.

If that's what you mean, I agree that the priority advertised by a
server for a promisor remote is not likely to be a (good) criteria on
the client side to help decide if the client accepts to use the
promisor remote or not. You might want to reword the above paragraph
though as it's not easy to understand.

> Instead, if the client wants to use the server recommended "priority"
> later when fetching the missing blob from the accepted promisor remotes,
> the "priority" field will be added to the "promisor.storeFields" config
> options so that the passed value can be saved to the client config.

Yeah, that's the most likely way the client would use it.

> If the client does not enable this option in the config, the "priority"
> field will not be saved in the local config and the fetching order will
> default to the local config order.

Right.

> A new config "promisor.honorServerFetchOrder" will be implemented
> on the client side to determine if the client will use the recommended
> server advertised promisor remote fetching order or not.

I don't think this is necessary. If the client doesn't want to use the
priority advertised by the server, it just needs to not add "priority"
to the "promisor.storeFields" config variable.

> This config can only be enabled if "promsior.acceptFromServer" is not
> "None".
>
> The options for this config value will be [true|false|local-first] where
> "false" (default) ignores server priority and will rely on the current
> config order.
> "true" sorts candidate advertised remotes by priority in ascending
> order (smallest tried first).
> "local-first" will try remotes in local .git/config first in the order
> the promisors are placed in the config file  and then
> server advertised ones ordered by priority, if the object has not been
> found by now. This last values makes me feel somehow as all objects

s/values/value/

> could have been fetched already but I am just stating my thought process.

I think we will likely not need something like this. The 3 different
possibilities could be configured this way:

- to rely on the order advertised by the server: just add "priority"
to "promisor.storeFields"
- to rely on local "priority" config: just add "priority =3D XXX" to
some/all "remote.<name>"
- to rely on the default order: add nothing

> Proposed Project Execution Timeline:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This needs to take into account that the first step should be to
actually introduce the `remote.<name>.priority` config option and make
it change the fetch order.

Thanks.
