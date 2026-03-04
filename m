Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103613101A0
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609745; cv=none; b=OxarJRKr0cyRMMLTfP+1p0L2M3c2VjSsD/I95f4OcwtGdd1HRmWL8uCfqn1KXTAEJWmgF2WUx50Yu2qtcIJAjOmPSyfp1+0UbDOKotuDKHFVW3eO59xzr70jJEvhzMdq9O+rLk1xCZy071P60VjKWUipXyQELlKQ06vw+etcV/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609745; c=relaxed/simple;
	bh=a3FLxcXgsm2Yd+YF4GPl3oFoded3t/13lwVgcC/bgK0=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d43/Bd5xNqWmblV9edsISiiD8CSSRyVo0aV4Fs71PClEKfHKfVbvNX8huZNGysVXEFWSPOh+WCxP9U/oY8VWTAKgcAxQjrhVduUFqzGF/nMTvtkHkuz4Du3QDeDcM+Q057D9nv1MLtT9ydndZf84jk0dau5UplLimyR7nt4LtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k40PV0Vj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k40PV0Vj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-482f454be5bso68278805e9.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 23:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772609741; x=1773214541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XiP4smlCMr/bwktAh2Zt2lNZsH7mujC7PjE8BAquDpQ=;
        b=k40PV0VjLeQ3gFKQhhBf5lSPC9ZUDCYEJxuXSrUace44HvBxSPYnh4ASURbNTNdCPQ
         ysRfwi6MSgLx9ZfdYZbpW0nZC/93MRhZpcdLj1TjVppW6w+RDLlva47aBinS+ma8dQDW
         sqitgB8Tk0ChdoeOGnqn/hxOIt+b8pFlw4Y96oQO2js+YitPuT80iKdL9MObGkyL2d3k
         /a22lTWm9Lf6UoQk63xdryHDFq+B6Bj4KVx34+77Wsu7w5ZVouJudD7JXFz6OwnQ/zMM
         bhdyuQSkRvFAnjfeB9Uhp01hGmzUfqOu6rU2WaKo4eUl3faC28xcIPLEuCtgp3e04pRB
         MMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609741; x=1773214541;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiP4smlCMr/bwktAh2Zt2lNZsH7mujC7PjE8BAquDpQ=;
        b=wmf/MG2mvkzrEkT2NmgYnjDllSG6rZTK/B+IA0uVQkwWQTHJvtAwRlNieDyMOcNQ5A
         y/5Wv7KvnMhWrc4euG2wpq3VMkNxXJqve2t7visruI89wlgoWKbufkDrRzC9+1hGmZLa
         ar4heuGiLJ84dICTOEq42mRtBJGb2gIbKsE+kGedR1jgev3fupFY7qrBGvYlYh9rOlS2
         VKi3GqceCWwElu1IqtCFvRqTXh4DD4Ty7Aae6dYGLi23ZRvRkZl1nF7XQeWVO4It5iH3
         RApoKA/zNV7AN53vce/gQ1HGxPoalOTsCB7C13S3vt2SR7SHYREMS3C/Uf4I4n99N+i8
         b6Yw==
X-Gm-Message-State: AOJu0Yy7Ge3d0iG+jfCvt/Y6RpMxlABRy3904BmUJhc7D1lLMrRAdu2m
	HsQOLc11P2qyljQWQaT8AXw+yktwl0T6r5II5GWdwEDuWf5B9KY3RSYPKKIB/KN49gA=
X-Gm-Gg: ATEYQzy8HnnpCvM2UyODgsl4OUoEmGovPIZZKy7AV4yUv4UxV1q4PRV8OHt/m0dsgVg
	a3LrfOfHhaDo9VPFLI2kxjLryru1owIENo9aioC5rSpGcYr4221e7zy9qvBWoAX64hHhTulESGM
	F2F0+StxmnCxnZgy2uJ94h9pDcHihWLguDBTZ/4XMSsk3xjM+jg9nCBTBy01P8VWGk6/5pfUCkB
	YYZDmgFigoR2oJEg7cON6+3ifMFI2mZKOxulHTFGn4NRSvxASmxgghA6qSZGVDpusZDGG6mTAP/
	GDropdbQ4/zcHcXloGBBIIm6luoDboBxCfjq2ixyt5qzz7Pu8cHyQquDEg6sTi4RuG59W5gVujG
	066xrDFQfPkOwsgf9/xuyAmEF5GeS52TuwR1M1oGLIul6p6tedcQoU/1sj5iUaX/1l+6h7vPX1d
	yVja7kuryYbZCTKGXFFgKW9QbSuqc5Lbif9K9Iein0Jef8vxtngOQs/jY=
X-Received: by 2002:a05:600c:6386:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4851984ba56mr13083725e9.3.1772609740595;
        Tue, 03 Mar 2026 23:35:40 -0800 (PST)
Received: from localhost ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm29891517f8f.5.2026.03.03.23.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:35:40 -0800 (PST)
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
X-Google-Original-From: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>
Date: Wed, 4 Mar 2026 08:35:49 +0100
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [GSoC] [Proposal v2]: Implement promisor remote fetch ordering
Message-ID: <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local>

Hello,
This is the second iteration of my proposal for the project
"Implement promisor remote fetch ordering" for the 2026 GSoC programme.

Personal Bio:
=============
Full Name:  Abraham Samuel Adekunle
Email: abrahamadekunle50@gmail.com
GitHub: https://github.com/devdekunle
Pronouns: he/him

About Me:
=========
My name is Abraham Samuel Adekunle. I love to code, read and I am a
hard worker. In my free time I love to play games and listen to soothing
music and well, also shift into diffuse thinking to gain a new
perspective of whatever challenge I am trying to solve.

I am very curious so I really love to learn as it's a never ending
journey, and I believe in the power of "yet".
I can understand anything, it is only a matter of time and effort.
I love to figure out things and be part of a community
where we can share experiences and support each other in growth.

Past Experience with Git:
=========================
I first learnt about Git during my ALX Software Engineering days in
2022, it proved challenging at first understanding what was going on
and a git merge conflict was always a scary experience.
Now I feel elated actually contributing to this renowned project.

Contributions to the Git Community:
====================================
My first contribution to the Git community was during the contribution
phase of the December 2024 Outreachy contribution phase where I first
learned to send patches and had my first interactions with the Git code
base. I did not make it through then but it was an opportunity to try
again.

Contributions to other Communities:
===================================
I have contributed very sparingly to the Systemd project and also
the Linux Kernel.

Microproject:
=============
Link: https://lore.kernel.org/git/aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local/
Branch: aa/add-p-previous-decisions
Status: Merged to master
Commit ID: 8cafc305e22a59efb92472d4132616e24d3184c6
Description:  "git add -p" and friends notes what the current status
               of the hunk being shown is

Other Contributions:
====================
1.
Link: https://lore.kernel.org/git/cover.1771066252.git.abrahamadekunle50@gmail.com/
Branch: aa/add-p-no-auto-advance
Status: Will merge to master
Description: "git add -p" learned a new mode that allows the user to
              revisit a file that was already dealt with

2.
Link: https://lore.kernel.org/git/aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.local/
Status: Stalled
Description: the patch attempts to remove the use of the_repository
             global variable in some builtins

3.
Link: https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gmail.com/
Branch: sa/notes-edit
Status: Merged to master
Description: Teach 'git notes add' and 'git notes append' a new '-e' flag,
             instructing them to open the note in $GIT_EDITOR before saving.

4.
Link: https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget@gmail.com/
Branch: aa/t7300-modernize
Status: Merged to master
Description: use test_path_* helper functions for error logging

Project Overview and Objective:
===============================
I have always wondered what happens in the background when I see these
details on my screen in a "git fetch" process.

        remote: Enumerating objects: 57, done.
        remote: Counting objects: 100% (57/57), done.
        remote: Compressing objects: 100% (12/12), done.
        Receiving objects: 100% (57/57), 48.3 KiB | 512.00 KiB/s, done.
        Resolving deltas: 100% (21/21), done.
        remote: Total 57 (delta 21), reused 13 (delta 5), pack-reused 30
        From https://example.com/me/repo
        1a2b3c4..5d6e7f8  feature/xyz -> origin/feature/xyz

And when I saw this project from the list of projects listed,
I was endeared to it as it is an opportunity to work in an area of the
that Git code base that will satisfy my curiosity while also being
mentored by very best and most experienced Engineers there is.

When a Git repository is configured with multiple promisor remotes,
there is currently no other mechanism to specify or optimize the order in
which these remotes should be queried when fetching missing objects.
Different remotes may have different performance characteristics
such as characteristics, cost, or reliability which makes the
fetching order an important consideration.
Currently, the promisor remotes are queried in the order in which they
appear in the local .git/config.

The project aims to implement a fetch ordering mechanism for multiple
promisor remotes that allows a client to be able to specify a fetching order,
a server to advertise an order to the client to ensure performance
and cost management, and the client to decide to use the server advertised
order or not, and default to the current order if no order is specified.

Review of Previous Work:
========================
The project is part of the Large Object Promisor "LOP" effort
documented in Documentation/technical/large-object-promisors.adoc.

In a bid to better handle large objects, the promisor-remote
capability was added to the Git protocol v2, as documented in
the promisor-remote section of Documentation/gitprotocol-v2.adoc,
which enables a protocol negotiation so that the server can advertise
one or more promisor remotes and so that the client and server can
discuss if the client could directly use a promisor remote the server
is advertising and if an agreement is reached, the client would be
able to get the missing objects directly from the promisor remote without
the server acting as a relay between the client and the promisor remote when
fetching missing objects.

The ground work for adding this capability to the v2 protocol was
started by Christian Couder in [1], where if the "promisor.advertise"
config is set to true, the server can then propagate its promisor remote
configurations to the client over the v2 protocol during the negotiation
in the form

        "promisor-remote=name=prom1,url=url_encoded_value1;name=prom2,url=url_encoded_value2"

The client can then choose to accept some promisor remotes the server
is advertising using the "All", "None", "KnownName" or "KnownUrl"
configurations as values for the "promisor.acceptfromServer" config option.

In [2], Christian added the option for a server to advertise more
fields after the "name" and "url", such as "token" and
"partialCloneFilter" for the client to use this additional information
in deciding the remotes to use as its promisor remotes by comparing it
with its local config information.

This was implemented by adding the "promisor.sendFields" and
"promisor.checkFields" config values to the server and client respectively.
For example, if "promisor.sendFields" is set to "partialCloneFilter", and the
server has the remote configured like so:
[remote "foo"]
        url = https://pr.test
        partialCloneFilter = blob:none
        token = "fake"
then

	"name=foo,url=https://pr.test,partialCloneFilter=blob:none,token=fake"
will be advertised by the server to the client who can then decide,
using the "promisor.checkFields" setting, to check if the passed field
matches certain conditions before deciding to use it.

This work by Christian is very crucial to this project as I will take
advantage of this and enable the advertisement of a "priority" field
that the server can use to communicate with the client in deciding to
use the server recommended fetch order or not.

in [3] Christian also implemented the option "promisor.storeFields" which
allowed the value of the configuration to be saved in the client's
configuration file for use at a later time.
As above, this option will also prove important when the server advertises
the "priority" field as it will allow the client decided to store it in its
config settings for that promisor remote, for later use when fetching
the remaining blobs from the promisor remotes.

As documented in Documentation/technical/partial-clone.adoc, when using
multiple promisor remotes, currently, the promisor remotes are tried in the
order in which they appear in the config file with the promisor remote
configured with "extension.partialClone" being the last one tried.

As the goal of this project is to implement a fetch order when fetching
the missing objects, I would take advantage of the ground work
done by Christian by adding a "priority" field to the promisor-remote
capability when "priority" is added to the "promisor.sendFields" server
config option, which indicates that the server is recommending the client
to use the fetch order.

If the client chooses to use the server recommended fetch order, it can
add "priority" to the "promisor.storeFields" config option which will store
this values and query the promisor remotes in that order. If the client
choose to ignore this recommendation, it can simply choose not to store it and
instead use its own preferred order by setting the priority for some or all the
remotes to its preferred value and this will query the objects in that order.
Not using either of this order will query the promisor remotes in the current
default order.

High Level Approach to Project Execution:
=========================================

1. Introduce the `remote.<name>.priority` config option:
======================================================
As said above, when fetching missing objects, the order in which the remotes
are queried depends on the order in which they appear in the config file.
To make this flexible, I will introduce the `remote.<name>.priority` config option,
which will allow the client to set its preferred fetch order to each promisor remote
configuration, and then make it fetch based on this "priority" order.
The value of this option could be an integer between 1 and 65535, where the smallest
integer indicates highest priority.

This will allow a promisor remote be configured as follows

	[remote "prom1"]
		url = https://prom1.com
		priority = 10

Therefore when the client is configured with more than one promisor remote
and the prority is set for each promisor remote as follows,

	[remote "prom1"]
		url = https://prom1.com
		priority = 20
	[remote "prom2"]
		url = https://prom2.com
		priority = 10,

when fetching for the missing objects, the promisor remote "prom2" will be
queried first before "prom1".

2. Server Side Advertisement:
-----------------------------
After the `remote.<name>.priority` config option has been implemented and the
fetch order can be changed, I will then allow the server to advertise its
recommended fetch order in the promisor-remote capability.

As the server knows about the promisor remotes which hold the
missing objects, it could recommend the order in which these remotes
could be queried by the client using a "priority=<value>" field of the
promisor-remote capability in the Git v2 protocol, where <value> could
be an integer between 1 and 65535, and the smallest integer indicates
highest priority.

This will be an optional feature which will be enabled by the server
if it wants to recommend ordered fetching to the client via
the "promisor.sendFields=priority" config option.

Hence if the server advertises promisor remotes prom1 and prom2,
it could be of the form

        "promisor-remote=name=prom1,url=https://prom1.com,priority=10;name=prom2,url=https://prom2.com,priority=20",

if the server is configured as:

[remote "prom1"]
         url = https://prom1.com
         priority = 10
[remote "prom2"]
        url = https://prom2.com
        priority = 20

If the "promisor.sendFields" values does not include the "priority"
field in its comma or space separated options, the field will not be
advertised in the promisor-remote capability.

3. Client Side Parsing:
-----------------------
After the "priority" field has been advertised in the promisor-remote
capability, the client can choose to use this server recommended fetch
order or ignore it completely.
If the client wants to use the server recommended fetch order later when
fetching the missing objects from the accepted promisor remotes, the "priority"
field will be added to the "promisor.storeFields" config
options so that the passed value can be saved to the client config.
If the client does not enable this option in the config, the "priority"
field will not be saved in the local config and the fetching order will
be client specified order if set or the default local config order if not set.

The three different fetch order are;
1. the order advertised by the server, where the "priority" field
   will be added to "promisor.storeFields" and the value will be saved to the
   local config file for the selected promisor remotes. When fetching the missing
   objects, this order will be used.
2. the local "priority" config where the client can set the "priority"
   field using, priority=<value>, of some or all "remote.<name>" to indicate its preferred
   fetch order when fetching the missing objects.
   This order will be used if the "promisor.storeFields" does not include the
   "priority" field.
3. the default order, where the field will not be added to the config and hence
   the current default order will be used.

Proposed Project Execution Timeline:
====================================

1. Study code base to understand promisor-remote and fetch mechanism (May 1 - 14, 2026):
   -------------------------------------------------------------------------------------
- Study the code base to understand how the client and server
  communicate using the protocol when client contacts the server.
- Study how Git currently handles fetching from multiple remotes.
- Set up blog for posting once in two weeks

2. Community Bonding (May 1 - 14, 2026):
----------------------------------------
- Discuss design details with community and mentors
- Understand safety, security constraints and design considerations
  when implementing fetch ordering.
- Read indepth the Documentations for promisor-remote, gitprotocol-v2,
  and other necessary documentations.
- Post updates on my blog

3. Review Existing Patches and related code (May 15 - May 25, 2026):
-------------------------------
- Study code base to understand how a new config option is added.
- study code that handles the fetching of missing objects after a partial
  clone/fetch.
- Study Christian's patches in-depth to understand how a new field is
  added to the promisor remote of server, what conditions
  are used to ensure the data is of the right format, correctly passed from
  server to client, and correctly parsed and stored by client.
- Study how a client can store the new field it accepts to use from the
  advertised fields.
- Understand the tests to see how these new features are tested
- Post updates on my blog

4. Introduce the `remote.<name>.priority` config option: (May 25 - June 13, 2026):
-------------------------------------------------------
- Discuss with mentors on the suggested approach
- Allow the addition of the config option `remote.<name>.priority`
- Implement fetching based on this option when set by the client
  and if not set, default to the current order.
- Write tests to ensure proper implementation of the new config and
  fetch order
- Submit patches to mailing list and engage in reviews with Community members
- Post update on my blog

5. Allow a server to add the "priority" field to the promisor-remote capability (June 14 - June 21, 2026)
-------------------------------------------------------------------------------
- Discuss with mentors on the suggested approach
- Allow the server to add the field "priority" to the promisor-remote
  capability when it is enabled in "promisor.sendFields".
- Write tests to ensure proper implementation
- Update documentation in Documenantation/config/promisor.adoc
- Submit patch to mailing list for discussions and address reviews
- Post updates on my blog

6. Allow Client to decide to use the field (June 21 - 14, 2026):
-----------------------------------------------------------------
- Discuss strategy with mentors
- Allow the client to store the "priority" in its .git/config if it
  accepts the promisor remotes and it is included in "promisor.storeFields"
- Write unit tests to ensure proper implementations
- Update documentation in Documentation/config/promisor.adoc
- Submit patches to mailing list for reviews and address feedbacks
- Post updates on my blog

7. Implement fetching order based on setting: (July 15 - August 14, 2026):
------------------------------------------------------------------------
- Discuss with mentors on the approach and considerations for fetch order
- Implement fetching based on the client's accepted fetching order
- Write unittests to test implementation
- Update documentation in Documenantation/config/promisor.adoc
- Submit patches for review and address reviews
- Post updates on my blog

9. Final Report on Project (August 15 - 24, 2026):
--------------------------------------------------
- Document any final report in my blog with details of my experience
- Finalize any pending tasks

Availability:
=============
I will be able to give 30 hours a week to make the project a success

Post GSoC
=========

Though this is not my first contribution to Git, as I have contributed
very lightly to the codebase before, I am committed to
continuously contributing to Git and become a part of the next set
of contributors to champion the continuous development of Git.

Appreciation
============
To Junio C Hamano, Phillip Wood, and everyone who helped with my patches.
I really appreciate your guidance, patience and direction while
reviewing and my patches.

Thanks

References
===========
1. https://lore.kernel.org/git/20250218113204.2847463-1-christian.couder@gmail.com/
2. https://lore.kernel.org/git/20250908053056.956907-1-christian.couder@gmail.com/
3. https://lore.kernel.org/git/20260216132317.15894-1-christian.couder@gmail.com/
