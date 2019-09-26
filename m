Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FD41F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfIZIkM (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:40:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:53753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfIZIkM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569487199;
        bh=j0T+TEHUa0T8empYzs6CExaWs9qZvxXwCyYJ65vxwRw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KsdkVJoc9jizhHy72caWBISsynPJSnznIknVhJL8qc5olMPomptXKid0A9JXxSTWd
         zmFjE0lYYMVYyUuHkcXcfemWJeaCCC9suUO13Q/Fg4XlW8+3D3QvWQxcjWgNnk0yBo
         8Zg8FfGkPmpR/qhjusHtVO01hMue9ozR/UOjR/ds=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1iUfRw0CL1-00JbNq; Thu, 26
 Sep 2019 10:39:59 +0200
Date:   Thu, 26 Sep 2019 10:39:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/19] hashmap bug/safety/ease-of-use fixes
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
Message-ID: <nycvar.QRO.7.76.6.1909261032520.15067@tvgsbejvaqbjf.bet>
References:  <20190924010324.22619-1-e@80x24.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7wYKfbnjXl+TJUnRAc42aTWeb92f1G6eESDhSBmvqhIuE8VPJoC
 DCjdQG4LQppHeOgePgtQTuSnEEsYTFQnXY7E8+fTdWnvt/sNG7Uk4ppVtXZHdGosj9/ycM+
 t96VnN5hmqOzG3AZugm+FFur/8YYkVzSTJyEMsBvnH3CAV0EpnUSPHVHUILSOOs9MtuZ+UV
 o0a3kMlzegdp3tlvU0QyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:33OJYOT3JBw=:IzwKE4/FrVoc03mvTTCp3m
 0JgBfUeIlkFmLsI3O3gF0/XJzG7+3PTljWNTD3gRQf9cO7mNjjgaxMrZ7Xw8aGYHEyoXNRS1y
 O4GAvYp25lx/F0fmikrS3GabeXyUdLRrr6dq+MoFyMDbPuKkrQcN0h7+FPj16Ml9CTnbQVaf0
 rJ9GGQ8AidFUWbtdANW2xj0We6tRCcnGu86TqUkhRhlcx52saJrGhJH2jlFgF8GvWsappfts1
 r/dAlih1maqpG3QT4nTJdzPhDybtW406L5wrxD05nGyobWg89cdWNMRVb2NHqNYZ7kroR6aoX
 zK/1vLb5Cwz23qyiRTDgzbEzb0X/xX/O/1dgd5sPZMDYsJoKJMMwexZi27cROkk2ob+Fc7UET
 TnhITjdfXoYwrnQUbPD/A0gQo43GdhQz4Oc8OvS73mgonCSyJe25ZguY4XWNlMEC1zdxFvTB0
 pUbZb5rrnWxwQohrK2d/BmsbYXdh9d2xZBDeJ1PBPV0Oeesc0gu2D/Odpgsf2D893JRq3vhc5
 apBTT8AmEmQccCRq65fjNOw7gaREUlb4YOCshqMGj8gYDgfIt+vRDi1I6PrRaOwWZmlIoreX/
 ie0j/GXTYMpnGXTzxP75/it/5TwTAbd+afcdenWDNqWRNy4cCqE5vuzJUl8zvkCEJJbfD18pD
 RVa0EbtyfnslngwpnY15sH7cHHNT8mDbbo+9NYfYv24Ls1r+c8x1KeEEg5USwOvZeEbmqfxs/
 DJwuek1nGUMJbjXzfrFojj9PI9+vChqi8gZTmw5H+UDpx7ddKgtkXbULpMZ/M2vOKRE7ZemgF
 oB5AjD7dZRkELaPu58Y/+0FfxkuH5nR94awrVEOaUwtTzWZEucVQ5urYU8cbTXIs0mfCPaJFV
 RHx9YEheBvAR4IpWys8T82LTauqCAcp72F2D0UQAdvz7m8IqgQlmG149XJDEjOWX+Un8qbHy3
 817q05SZBGFVdz0qKb82cbNqzocJ+CkDkOWv+r0NC+aqBACVdHgSl/CkzUFyyX9ngyc4YnZ3A
 rZGxeqXoSgwHn7ZPYmUXrHWBKu79i4t6x5Fes6fgG6V6aAEGZIBoMCVVg/6iCfCmIpeIsEMmc
 4VgbsJwgDttDAVOfQFlMNk0j7ip0n6aGbEQKGHff9Hg89ddjSO6oc66ClB9L76CIInyeoNioz
 6EfF9sB+aQvl5NpWXEJQdtqvLhCmEMIgMufEBREgGOSy8m3VGMaWjmJdX/FEuxHDRyoQiGJUC
 bLnz0AdaGuLKW8sXMclb45k5sCKXsmag8iMwL0/YCYRgUtIwdvtG2SewwlK8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 24 Sep 2019, Eric Wong wrote:

> Patches 1-11 are largely unchanged from the original series with the
> exception of 2, which is new and posted at:
>
> 	https://public-inbox.org/git/20190908074953.kux7zz4y7iolqko4@whir/
>
> 12-17 take further steps to get us away from hashmap_entry being
> the first element, but they're also a bit ugly because __typeof__
> isn't portable
>
> 18-19 finally brings me to the APIs I want to expose without
> relying on __typeof :)

I won't have time to review this patch series, but I wanted to throw out
the idea of storing the offset in `struct hashmap`, i.e. the offset of
the `struct hashmap_entry` in the actual entry struct?

Example:

	struct erics_entry {
		const char *i_want_this_to_be_the_first_field;
		struct hashmap_entry e;
		[...]
	};

	[...]

	struct erics_entry *dummy =3D NULL;
	size_t offset =3D ((char *)dummy->e) - ((char *)dummy);
	[... store that offset in the hashmap and subtract it from the
	stored pointers before returning an entry...]

IOW rather than assuming that it is the first field, we could allow an
offset other than 0. I'm just not sure how to implement this elegantly,
but it should be much easier to do this portably than the `typeof()`
approach.

Ciao,
Dscho

>
> Apologies for the delays, been busy with other stuff...
>
> Previous discussion starts at:
>
> 	https://public-inbox.org/git/20190826024332.3403-1-e@80x24.org/
>
> The following changes since commit 745f6812895b31c02b29bdfe4ae8e5498f776=
c26:
>
>   First batch after Git 2.23 (2019-08-22 12:41:04 -0700)
>
> are available in the Git repository at:
>
>   https://80x24.org/git-svn.git hashmap-wip-v2
>
> for you to fetch changes up to 212a596edd99169b284912b7b70b6280e2fb90e6:
>
>   hashmap: remove type arg from hashmap_{get,put,remove}_entry (2019-09-=
24 00:42:22 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (19):
>       diff: use hashmap_entry_init on moved_entry.ent
>       coccicheck: detect hashmap_entry.hash assignment
>       packfile: use hashmap_entry in delta_base_cache_entry
>       hashmap_entry_init takes "struct hashmap_entry *"
>       hashmap_get_next takes "const struct hashmap_entry *"
>       hashmap_add takes "struct hashmap_entry *"
>       hashmap_get takes "const struct hashmap_entry *"
>       hashmap_remove takes "const struct hashmap_entry *"
>       hashmap_put takes "struct hashmap_entry *"
>       introduce container_of macro
>       hashmap_get_next returns "struct hashmap_entry *"
>       hashmap: use *_entry APIs to wrap container_of
>       hashmap_get{,_from_hash} return "struct hashmap_entry *"
>       hashmap_cmp_fn takes hashmap_entry params
>       hashmap: use *_entry APIs for iteration
>       hashmap: hashmap_{put,remove} return hashmap_entry *
>       hashmap: introduce hashmap_free_entries
>       OFFSETOF_VAR macro to simplify hashmap iterators
>       hashmap: remove type arg from hashmap_{get,put,remove}_entry
>
>  attr.c                              |  22 ++---
>  blame.c                             |  25 +++---
>  builtin/describe.c                  |  21 +++--
>  builtin/difftool.c                  |  56 ++++++------
>  builtin/fast-export.c               |  15 ++--
>  builtin/fetch.c                     |  30 ++++---
>  config.c                            |  24 +++---
>  contrib/coccinelle/hashmap.cocci    |  16 ++++
>  diff.c                              |  31 ++++---
>  diffcore-rename.c                   |  15 ++--
>  git-compat-util.h                   |  33 ++++++++
>  hashmap.c                           |  58 ++++++++-----
>  hashmap.h                           | 164 +++++++++++++++++++++++++++++=
=2D------
>  merge-recursive.c                   |  87 ++++++++++---------
>  name-hash.c                         |  57 +++++++------
>  oidmap.c                            |  20 +++--
>  oidmap.h                            |   6 +-
>  packfile.c                          |  22 +++--
>  patch-ids.c                         |  18 ++--
>  range-diff.c                        |  10 +--
>  ref-filter.c                        |  31 ++++---
>  refs.c                              |  23 +++--
>  remote.c                            |  21 +++--
>  revision.c                          |  28 +++---
>  sequencer.c                         |  44 ++++++----
>  sub-process.c                       |  20 +++--
>  sub-process.h                       |   4 +-
>  submodule-config.c                  |  52 +++++++-----
>  t/helper/test-hashmap.c             |  49 ++++++-----
>  t/helper/test-lazy-init-name-hash.c |  12 +--
>  30 files changed, 647 insertions(+), 367 deletions(-)
>  create mode 100644 contrib/coccinelle/hashmap.cocci
>
> Eric Wong (19):
>   diff: use hashmap_entry_init on moved_entry.ent
>   coccicheck: detect hashmap_entry.hash assignment
>   packfile: use hashmap_entry in delta_base_cache_entry
>   hashmap_entry_init takes "struct hashmap_entry *"
>   hashmap_get_next takes "const struct hashmap_entry *"
>   hashmap_add takes "struct hashmap_entry *"
>   hashmap_get takes "const struct hashmap_entry *"
>   hashmap_remove takes "const struct hashmap_entry *"
>   hashmap_put takes "struct hashmap_entry *"
>   introduce container_of macro
>   hashmap_get_next returns "struct hashmap_entry *"
>   hashmap: use *_entry APIs to wrap container_of
>   hashmap_get{,_from_hash} return "struct hashmap_entry *"
>   hashmap_cmp_fn takes hashmap_entry params
>   hashmap: use *_entry APIs for iteration
>   hashmap: hashmap_{put,remove} return hashmap_entry *
>   hashmap: introduce hashmap_free_entries
>   OFFSETOF_VAR macro to simplify hashmap iterators
>   hashmap: remove type arg from hashmap_{get,put,remove}_entry
>
>  attr.c                              |  22 ++--
>  blame.c                             |  25 +++--
>  builtin/describe.c                  |  21 ++--
>  builtin/difftool.c                  |  56 ++++++----
>  builtin/fast-export.c               |  15 ++-
>  builtin/fetch.c                     |  30 ++---
>  config.c                            |  24 ++--
>  contrib/coccinelle/hashmap.cocci    |  16 +++
>  diff.c                              |  31 +++---
>  diffcore-rename.c                   |  15 ++-
>  git-compat-util.h                   |  33 ++++++
>  hashmap.c                           |  58 ++++++----
>  hashmap.h                           | 164 +++++++++++++++++++++++-----
>  merge-recursive.c                   |  87 ++++++++-------
>  name-hash.c                         |  57 +++++-----
>  oidmap.c                            |  20 ++--
>  oidmap.h                            |   6 +-
>  packfile.c                          |  22 ++--
>  patch-ids.c                         |  18 +--
>  range-diff.c                        |  10 +-
>  ref-filter.c                        |  31 ++++--
>  refs.c                              |  23 +++-
>  remote.c                            |  21 ++--
>  revision.c                          |  28 +++--
>  sequencer.c                         |  44 +++++---
>  sub-process.c                       |  20 ++--
>  sub-process.h                       |   4 +-
>  submodule-config.c                  |  52 +++++----
>  t/helper/test-hashmap.c             |  49 +++++----
>  t/helper/test-lazy-init-name-hash.c |  12 +-
>  30 files changed, 647 insertions(+), 367 deletions(-)
>  create mode 100644 contrib/coccinelle/hashmap.cocci
>
>
> base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
>
