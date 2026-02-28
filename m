Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322463AEF55
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772321257; cv=none; b=HcjQPL7FCRzuO38i9ODmp5R13Da56fRV/+CDR5nCjBeV7s7q7gKXjHbNoOxspgsxOb5cb5/momIAoHtNhI9+IQH2fclfXJzUwLZvGYhT2hG/hai1VHtiI97SFcTwaPRrpNdXUDKcNTq7ZfvB6Xtimgj37gfjAhyuCMncRFF5PFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772321257; c=relaxed/simple;
	bh=Lvq8/h5CXLJa8SL9ZjTJcKkoRoigYPDc6Zukd106D20=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cf4ZE7QDRdx7XGwNZ51bcFaZ9iBd4uu2zDdzrUw5nASD26vlrbAIYC9oOJHDVVxUwio0S7PnPz0o+k1AbGe64NQ95FbF64V8RXXtNF4QdET/AjTgAXENWHgaOY2a26AWDkubhL7VFykHszwFWtgNFOXkIh9KeXRohcDBLIs3CZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiWi9u9E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiWi9u9E"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so38401415e9.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 15:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772321253; x=1772926053; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDTNtcG0zUpsiXhcmHhnhn+VYtPHN09lkCBnVV46djM=;
        b=FiWi9u9EpvafBCQy1vfbYZKnNm/s/kcBYBXmTW6U7FL6BvdbuJHP7Y2qh6dsDIJB9H
         bPC3dM2Rob9SLz2Q9rNTcMSOdFcXqczqj14LPRiUEWAZrGlG5zWCLNb5QnW9Ll/x6PGm
         9JTK2OxEHqWICd5Qk0la/NmVRRDkZpNOCZcRKpTa5aDmJVNLV3KNt3j8f51PKMUwkro8
         y1GhX9rZinFG4i6PDXt1/LnCDLQHpQuAtbSNUSQ+9Q1fgvTedaxH8tQrLXdwxpF1W6gD
         sjAU70OCN4t2RrQKRx5Iscvxce5YSRUChWhJM2eVUqinb57H2mRskdYfG45trsSda7oC
         GAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772321253; x=1772926053;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDTNtcG0zUpsiXhcmHhnhn+VYtPHN09lkCBnVV46djM=;
        b=i670MobmwxO4Jo1EqG+0BZ6NVxUt6Kood+59We0/meyUPaCKsXtpkffT1cpjuO1gWw
         FWF/ptbZYSskcTfYQ1m5yr65nBuAP/Y9ftLUpa80jY7VykxwNE7GL5hJFOd207c+PMUy
         i1Rdv9trbg7PBvc6DeIMWKrXCQ2J1k7Fi/58ynMuZ9yks17nc3QTR+yVGK+ioq4CKTQJ
         IQht4o8LLJ1d7Y08YORdh57ZfS7JX7h9VbtntgjQymlBt6s1LjkXZIH4VMlNTdRerJpL
         YqwcXegkQ+8aqNCflWxaSItbhtQyhXG6XRkp+NxTG/kmzsYmZlRguRQQt39MECL/VDqj
         hwtw==
X-Gm-Message-State: AOJu0YyHa6EmElBl4t06RR48FOua7U7FS67nU++X8v8yRTjdWenECIPt
	9oqq4eUEHwjbZIw6VbMESm16pJ+lIXlcjzyrY7bgMMQhh+CUxDrbG4+eKvIX86/drN4=
X-Gm-Gg: ATEYQzyuBPdkoLng0MPp10w61b7fAUKlch1FAEMjIMEuTNPZ7aC1aBDSjEN99IAb7pQ
	xWSCCl1JJ7OvycXVAr/T07fBCIUSYFb8MUiiKHx5wRX5HeQC3Rlx4OWJm2lBZqyR+Igoun+MIh+
	jiE3/RtISH86svBWmlxqgtlmoCJ1qOcDdHCd5Y2kqK5BQRrpkS0Lbk0ZcMN/KBFVOog8h28LcHD
	rmie9iwivhNufZRkM8RzlPK0xRylyX6UKQvuJZqtEEC83XepJ/K6NyML9+zOdOXgl3N5BXU0r8G
	niWfJazLc1K03FqaUUh5uo2LMRPiaVM8MnBl6BOGa3btUVW7rQqUeUhzsV+r2cKH9BxIyEe2enA
	isBJy36U7FQLWtDPZJO0r9LhsSUhRRn8xOgcuWVDBrKb/GmSU+uGtTURJ4jrfsSY01cpEuPsfff
	ZGT9kxhkhyuq0OTLwVRim4zxuM3fXOSVNTb0+MoSQalS/Z558VXM7QCp29Eoc=
X-Received: by 2002:a05:600c:468f:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-483c9bca601mr131122685e9.15.1772321252721;
        Sat, 28 Feb 2026 15:27:32 -0800 (PST)
Received: from localhost ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776b0sm98073235e9.1.2026.02.28.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:27:32 -0800 (PST)
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
X-Google-Original-From: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>
Date: Sun, 1 Mar 2026 00:27:38 +0100
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [GSoC] [Proposal]: Implement promisor remote fetch ordering
Message-ID: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
This is my proposal for the project
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
harworker. In my free time I love to play games and listen to soothing
music and well, also shifting into diffuse thinking to gain a new
perspective of whatever challenge I am trying to solve.

I am very curious so I really love to learn as its a never ending
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
Status: Merged to next
Description: "git add -p" learned a new mode that allows the user to
	      revisit a file that was already dealt with

2.
Link: https://lore.kernel.org/git/aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.local/
Status: Stalled
Description: the patch attempts to remove the use of the_repository
	     global variable in some builtins

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
that Git code base that will satisfy my curiousity while also being
mentored by very best and most experienced Engineers there is.

When a Git repository is configured with multiple promisor remotes,
there is currently no mechanism to specify or optimize the order in
which these remotes should be queried when fetching missing objects.
Different remotes may have different performance characteristics
such as characteristics, cost, or reliability which makes the
fetching order an important consideration.

The project aims to implement a fetch ordering mechanism for multiple
promisor remotes by designing a flexible system that allows a server
to dictate their preferred order to the client to ensure performance
and cost management.

Review of Previous Work:
========================
The project is part of the Large Object Promisor "LOP" effort
documented in Documentatio/technical/large-object-promisor.adoc.

In a bid to better handle large objects, the promisor-remote
capability was added to the Git protocol v2, as documented in
the promisor-remote section of Documentation/gitprotocol-v2.adoc,
which enables a protocol negotiation so that the server can advertise
one or more promisor remotes and so that the client and server can
discuss if the client could directly use a promisor remote the server
is advertising and if an agreement is reached, the client would be
able to get the large blobs directly from the promisor remote without
the server acting as a relay between the client and the promisor remote when
fetching missing large blobs.

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

This was implemented by adding the "promisor.sendFields" and "promisor.checkFields"
config values to the server and client respectively.
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

High Level Approach to Project Execution:
=========================================
1. Server Side Advertisement:
-----------------------------
As the server knows about the promisor remotes which hold the
large object blobs, it could recommend the order in which these remotes
could be queried by the client using a "priority=<value>" field of the
promisor-remote capability in the Git v2 protocol, where <value> could
be an integer between 1 and 65535, where the smallest integer indicates
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

2. Client Side Parsing:
-----------------------
The client can already use the "promisor.acceptFromServer" option to
decide which promisor remotes it will accept, so this new field
"priority" might not be significant at all in the deciding phase but when
fetching missing blobs from the accepted promisor remotes.

Instead, if the client wants to use the server recommended "priority"
later when fetching the missing blob from the accepted promisor remotes,
the "priority" field will be added to the "promisor.storeFields" config
options so that the passed value can be saved to the client config.
If the client does not enable this option in the config, the "priority"
field will not be saved in the local config and the fetching order will
default to the local config order.

A new config "promisor.honorServerFetchOrder" will be implemented
on the client side to determine if the client will use the recommended
server advertised promisor remote fetching order or not.
This config can only be enabled if "promsior.acceptFromServer" is not
"None".

The options for this config value will be [true|false|local-first] where
"false" (default) ignores server priority and will rely on the current
config order.
"true" sorts candidate advertised remotes by priority in ascending
order (smallest tried first).
"local-first" will try remotes in local .git/config first in the order
the promisors are placed in the config file and then
server advertised ones ordered by priority, if the object has not been
found by now. This last values makes me feel somehow as all objects
could have been fetched already but I am just stating my thought process.

Proposed Project Execution Timeline:
====================================

1. Study code base to understand promisor-remote and fetch mechanism (May 1 - 14, 2026):
   -------------------------------------------------------------------------------------
- Study the code base to understand how the client and server
  communicate using the protocol when client contacts the server.
- Study how Git currently handles fetching from multiple remotes.
- Set up blog for posting once a week

2. Community Bonding (May 1 - 24, 2026):
----------------------------------------
- Discuss design details with community and mentors
- Understand safety, security constraints and design considerations.
  when implementing fetch ordering.
- Read indepth the Documentations for promisor-remote, gitprotocol-v2,
  and other necessary documentations.
- Post updates on my blog

3. Review Existing Patches (May 25 - June 14, 2026):
-------------------------------
- Study Christian's patches in-depth to understand how a new field is
  added to the promisor remote of server, what conditions
  are used to ensure the data is of the right format, correctly passed from
  server to client, and correctly parsed and stored by client.
- Understand the tests to see how these new features are tested
- Post updates on my blog

4. Allow a server to add the "priority" field to the promisor-remote capability (June 14 - June 21, 2026)
-------------------------------------------------------------------------------
- Discuss with mentors on the suggested approach
- Allow the server to add the field "priority" to the promisor-remote
  capability when it is enabled in "promisor.sendFields".
- Write tests to ensure proper implementation
- Update documentation in Documenantation/config/promisor.adoc
- Submit patch to mailing list for discussions and address reviews
- Post updates on my blog

5. Allow Client to Decide to use the field (June 21 - 31, 2026):
-----------------------------------------------------------------
- Discuss strategy with mentors
- Allow the server to store the "priority" in its .git/config if it
  accepts the promisor remotes and it is included in "promisor.storeFields"
- Write unit tests to ensure proper implementations
- Update documentation in Documenantation/config/promisor.adoc
- Submit patches to mailing list for reviews and address feedbacks
- Post updates on my blog

6. Implement setting to decide fetching order: (July 1 - July 14, 2026):
------------------------------------------------------------------------
- Discuss with mentors on the approach and considerations for fetch order
- Implement option "promisor.honorServerOrder" which will decide the
  order of fetching missing objects from the remote
- Write unittests to test implementation
- Update documentation in Documenantation/config/promisor.adoc
- Submit patches for review and address reviews
- Post updates on my blog

7. Implement fetching based on the selected order (July 15 - August 15, 2026):
------------------------------------------------------------------------------
- Implement the ordered fetching for missing objects based on the cient's
  configuration in 6 above.
- Write unit tests to ensure the order was properly followed
- Submit to mailing list and be involved in the review process
- Post updates on my blog

8. Final Report on Project (August 15 - 24, 2026):
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
