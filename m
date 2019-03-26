Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604DC20248
	for <e@80x24.org>; Tue, 26 Mar 2019 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfCZRxb (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 13:53:31 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48744 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZRxb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 13:53:31 -0400
Received: by mail-qt1-f201.google.com with SMTP id 54so14315390qtn.15
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EWVcAk9ZcywWp2/R0FgTPKGlKiVecdxNdHGtWAo+s8Q=;
        b=BVBnaK9gz1Qw8XE5adUtQH+BsSwuCMVhsoKS/KBACC91bNc9gsdbPL14CmjW2+cm+R
         J/jgBdLRjF6pHsJof1VnTqt6YCcZ+GgvpYLC8BwWbabEdyhV3HHPQ0uyBUyTm/I+Jaou
         uTf6Pdp6BItiDuFThQqiJpx2/1Wwh+wT++hhaj/lfowvDFOWyTc7wN9hgTpeNxxZcuMz
         dJilcemiRAfYarTMU0diQSOFqYXmdfFaGSMPmaqWeTQfJXiHnq1YuS3Y0dUE2Ywb+MAG
         09d0P0ouKGaIfmogBjE0Kv9gaud7Rak4YneIlvRg2LfTmx69P8m4MwlH1typagICJnDv
         a+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EWVcAk9ZcywWp2/R0FgTPKGlKiVecdxNdHGtWAo+s8Q=;
        b=uC7zbixaIP3GcyVvRJMPdGIHtdPQRvIw2aGFnVU0Ypb+ekkPJry8ZcXL6zvDj12QOR
         OEBA3uL15bVBBQ4EXRtvNJ5lPiYu76E1lHwOPokTKmjWsTcjIpazcFzhBAygvqLi3k/F
         Pq2rRZgBa48WhBrnRkyLc8yCczSVkTi1ObLyqIKjhs9+L8HJnb8bfEtWBXiQZGm1R63s
         MTbTlGOh7Rf3N72Yj/OBh3dcx0ZG4Mt3pgoXRsZxvsP9L/wFOEdu3TnJUp6ieS77AaCd
         NWbkIdfy3VzQUCPWLg7G6vd0XeCa8xtEF4HNLDMnSEoHX1VNNPR48NE2lLOfcSRl4oGP
         ej3g==
X-Gm-Message-State: APjAAAX83Zy9RcEgOteyC9ukjlMkwdtG7Hl3YxGlbmWBxj9mBzPz44p2
        uzEpmBXOgwmdQ5T7qsF2yac2yHMTkld7riR8OyxFlMDTj7YKBFv26mQK47Ih8gO/qY7E0uOAFI5
        8HCWOXfXb+ouHCfWWs+M83zWjX0v7zAFlmsFDIU92vjWXBJFPJSl0T7QXig5yOwILfp/ayyhnJe
        WX
X-Google-Smtp-Source: APXvYqy21yAJVEdGEFuXCuvPIyy1HKoaI/+Xd8ceFJRcOqej247wZ8bwTesfIzAlIK34R5aiAheMgs3NdBkcM8D0xvMc
X-Received: by 2002:ac8:234e:: with SMTP id b14mr26783342qtb.271.1553622810314;
 Tue, 26 Mar 2019 10:53:30 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:53:24 -0700
In-Reply-To: <cover.1553546216.git.jonathantanmy@google.com>
Message-Id: <cover.1553622678.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v2 0/2] Last big GIT_TEST_PROTOCOL_VERSION=2 fix, hopefully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated to remove the unnecessary NULL check and memory leak that Peff
noticed [1].

(Only commit 2/2 is changed, so the range-diff only shows 1 commit.)

[1] https://public-inbox.org/git/20190326052011.GB1933@sigill.intra.peff.net/

Jonathan Tan (2):
  fetch-pack: call prepare_shallow_info only if v0
  fetch-pack: respect --no-update-shallow in v2

 commit.h     |  4 ++++
 fetch-pack.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  c4d2f409e2 ! 1:  943b1cbc61 fetch-pack: respect --no-update-shallow in v2
    @@ -33,13 +33,11 @@
      static void receive_shallow_info(struct fetch_pack_args *args,
     -				 struct packet_reader *reader)
     +				 struct packet_reader *reader,
    ++				 struct oid_array *shallows,
     +				 struct shallow_info *si)
      {
     -	int line_received = 0;
    -+	struct oid_array *shallows;
     +	int unshallow_received = 0;
    -+
    -+	shallows = xcalloc(1, sizeof(*shallows));
      
      	process_section_header(reader, "shallow-info", 0);
      	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
    @@ -77,8 +75,6 @@
     +
     +		for (i = 0; i < shallows->nr; i++)
     +			register_shallow(the_repository, &shallows->oid[i]);
    -+		oid_array_clear(shallows);
    -+		free(shallows);
      		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
      					NULL);
      		args->deepen = 1;
    @@ -95,14 +91,13 @@
     +		else
     +			alternate_shallow_file = NULL;
      	} else {
    -+		free(shallows);
      		alternate_shallow_file = NULL;
      	}
    - }
     @@
      				    int fd[2],
      				    const struct ref *orig_ref,
      				    struct ref **sought, int nr_sought,
    ++				    struct oid_array *shallows,
     +				    struct shallow_info *si,
      				    char **pack_lockfile)
      {
    @@ -112,16 +107,36 @@
      			/* Check for shallow-info section */
      			if (process_section_header(&reader, "shallow-info", 1))
     -				receive_shallow_info(args, &reader);
    -+				receive_shallow_info(args, &reader, si);
    ++				receive_shallow_info(args, &reader, shallows, si);
      
      			if (process_section_header(&reader, "wanted-refs", 1))
      				receive_wanted_refs(&reader, sought, nr_sought);
     @@
    + {
    + 	struct ref *ref_cpy;
    + 	struct shallow_info si;
    ++	struct oid_array shallows_scratch = OID_ARRAY_INIT;
    + 
    + 	fetch_pack_setup();
    + 	if (nr_sought)
    +@@
    + 		die(_("no matching remote head"));
    + 	}
    + 	if (version == protocol_v2) {
    +-		if (shallow && shallow->nr)
    ++		if (shallow->nr)
      			BUG("Protocol V2 does not provide shallows at this point in the fetch");
      		memset(&si, 0, sizeof(si));
      		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
    --					   pack_lockfile);
    -+					   &si, pack_lockfile);
    ++					   &shallows_scratch, &si,
    + 					   pack_lockfile);
      	} else {
      		prepare_shallow_info(&si, shallow);
    - 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
    +@@
    + 	update_shallow(args, sought, nr_sought, &si);
    + cleanup:
    + 	clear_shallow_info(&si);
    ++	oid_array_clear(&shallows_scratch);
    + 	return ref_cpy;
    + }
    + 
-- 
2.21.0.155.ge902e9bcae.dirty

