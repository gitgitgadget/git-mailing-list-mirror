Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F771F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 22:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfJGWfU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 18:35:20 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48483 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfJGWfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 18:35:20 -0400
Received: by mail-vk1-f201.google.com with SMTP id h145so7413062vke.15
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=FOs8wy7XU3nQtFgaKyVI0/U5V4h1wXj6GVyKllH1jcs=;
        b=VxrKkjxLImTgL2ZeQ0ic9teYAEOUcJfwMMRc8hFCRGLH7pLiHCyEQZk2d2G/HTEni4
         4sjTwHn8ONeUs4so5Kv85SEHOp1Layuy9dxQHxnuxH7dQ8zoQQc2UMFfZGP5qtYSEosd
         Qrblh6fi56nnL3oYzXs5i7Ewl7z03qMzero5XOrTByRNtq48qOQ/o0M7gSHtlIyCw5HV
         msn+4uhBldduHltBhDpjnnmWKlkNajzloCz9O1u2OwvkvmL9DKCUmU/nAxcOOwZqlYiM
         9WJJE4ivA4TmOojYCw3A/v62o3VGbsWeOCvF24DkNv/DzVnbHcvRs7lSkVVD20GiUmrW
         ILnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=FOs8wy7XU3nQtFgaKyVI0/U5V4h1wXj6GVyKllH1jcs=;
        b=mT5Cbxsj1VlvnHQtkwagY2sG2jnxxc1scEHE8wQ6qJwZNW6fRheEzKyYQ8Sp+yw+2q
         /bnsaxiWV6Qp/EqFLo3nh3cOOEWJ34BrAYvBazCrwUVNHQ7ZtlDlrunx/LGXcRKfjJCe
         NtgiXAndcYP2MzCY3FsFGB44sIG6CRLmJuhpgfXEfwbeqFr2prHFhlYMsSTWaxTPoxBU
         cQJgdm9qEVFmutCh5nZpwralyUA9InB50bolWfl0NeTmxgVbgaecnlkZ1oyCytTW1wGK
         7j2zwneGLCdcnPsdgRxcefvA50TSCAWMw2vB8y1LXw89uxuFjLD+YoW+jcsNHMyK67S8
         cTQg==
X-Gm-Message-State: APjAAAVZ3c+RbbweZ+eNMk4aLXQaCtsI4oqi+VBtkblXRXt+5KlJ/upw
        +ZuoGciGdMYnvs+NFZz8ExwhoQWJNFfNlkZSD1Pd9I7vob44ngE3l8ZYWQUBFjHBq91AD3iHxVL
        P6lamAnsVqNT9WC1xBcXZKiQM32Z7EZ2QiLduuMkoYVK+2pUiOESje6FuOpLln18=
X-Google-Smtp-Source: APXvYqyOFe0/bsyevCcjKGmLyT7e/gyDGOuayYfHwVt2jEhlo/ajgvvHP2FQkLXwosWDWjnMp+xEAuEWVKdcEw==
X-Received: by 2002:a67:e953:: with SMTP id p19mr8116328vso.79.1570487719167;
 Mon, 07 Oct 2019 15:35:19 -0700 (PDT)
Date:   Mon,  7 Oct 2019 15:35:14 -0700
In-Reply-To: <cover.1570059953.git.steadmon@google.com>
Message-Id: <cover.1570487473.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1570059953.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2 0/2] add trace2 regions to fetch & push
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to collect better statistics about where the time is spent in
fetches and pushes so that we can hopefully identify some areas for
future optimization. So let's add some trace2 regions around some of the
fetch/push phases so we can break down their timing.

Changes since V1:
* Use the repository struct argument in transport_push(), rather than
  the global the_repository.

Josh Steadmon (2):
  fetch: add trace2 instrumentation
  push: add trace2 instrumentation

 builtin/fetch.c | 22 +++++++++++++++-------
 builtin/push.c  |  2 ++
 fetch-pack.c    | 13 ++++++++++++-
 transport.c     | 14 ++++++++++++--
 4 files changed, 41 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  054936f40b ! 1:  fe6108b6f9 push: add trace2 instrumentation
    @@ transport.c: int transport_push(struct repository *r,
      
      		refspec_ref_prefixes(rs, &ref_prefixes);
      
    -+		trace2_region_enter("transport_push", "get_refs_list", the_repository);
    ++		trace2_region_enter("transport_push", "get_refs_list", r);
      		remote_refs = transport->vtable->get_refs_list(transport, 1,
      							       &ref_prefixes);
    -+		trace2_region_leave("transport_push", "get_refs_list", the_repository);
    ++		trace2_region_leave("transport_push", "get_refs_list", r);
      
      		argv_array_clear(&ref_prefixes);
      
    @@ transport.c: int transport_push(struct repository *r,
      			struct ref *ref = remote_refs;
      			struct oid_array commits = OID_ARRAY_INIT;
      
    -+			trace2_region_enter("transport_push", "push_submodules", the_repository);
    ++			trace2_region_enter("transport_push", "push_submodules", r);
      			for (; ref; ref = ref->next)
      				if (!is_null_oid(&ref->new_oid))
      					oid_array_append(&commits,
    @@ transport.c: int transport_push(struct repository *r,
      						      transport->push_options,
      						      pretend)) {
      				oid_array_clear(&commits);
    -+				trace2_region_leave("transport_push", "push_submodules", the_repository);
    ++				trace2_region_leave("transport_push", "push_submodules", r);
      				die(_("failed to push all needed submodules"));
      			}
      			oid_array_clear(&commits);
    -+			trace2_region_leave("transport_push", "push_submodules", the_repository);
    ++			trace2_region_leave("transport_push", "push_submodules", r);
      		}
      
      		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
    @@ transport.c: int transport_push(struct repository *r,
      			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
      			struct oid_array commits = OID_ARRAY_INIT;
      
    -+			trace2_region_enter("transport_push", "check_submodules", the_repository);
    ++			trace2_region_enter("transport_push", "check_submodules", r);
      			for (; ref; ref = ref->next)
      				if (!is_null_oid(&ref->new_oid))
      					oid_array_append(&commits,
    @@ transport.c: int transport_push(struct repository *r,
      						     transport->remote->name,
      						     &needs_pushing)) {
      				oid_array_clear(&commits);
    -+				trace2_region_leave("transport_push", "check_submodules", the_repository);
    ++				trace2_region_leave("transport_push", "check_submodules", r);
      				die_with_unpushed_submodules(&needs_pushing);
      			}
      			string_list_clear(&needs_pushing, 0);
      			oid_array_clear(&commits);
    -+			trace2_region_leave("transport_push", "check_submodules", the_repository);
    ++			trace2_region_leave("transport_push", "check_submodules", r);
      		}
      
     -		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY))
     +		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
    -+			trace2_region_enter("transport_push", "push_refs", the_repository);
    ++			trace2_region_enter("transport_push", "push_refs", r);
      			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
     -		else
    -+			trace2_region_leave("transport_push", "push_refs", the_repository);
    ++			trace2_region_leave("transport_push", "push_refs", r);
     +		} else
      			push_ret = 0;
      		err = push_had_errors(remote_refs);
-- 
2.23.0.581.g78d2f28ef7-goog

