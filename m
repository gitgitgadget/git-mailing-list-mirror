Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2D41FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932736AbcLHX6k (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 18:58:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58871 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932567AbcLHX6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 18:58:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A310854A21;
        Thu,  8 Dec 2016 18:58:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wdeCRaAP3KOjPg+YbTfHD6cAnXQ=; b=kJjezT
        tfP+lDuCVTHt524vCYFPgFqYMMxLPOHj1LCa1jOHhKvqeshzLAw1T1lEIat3q8eq
        9ktCXcwEaFZZigSazMqwzhBSVCEHZyZKDprV1PVcXOUdhKykGnwEReiBkczJ9LS8
        vmNx7XILlS3wmyvj5ojOE9JregUXMA/VAl0Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YLYS4EWDgDmJGRdOACJ80X1IY21vjmTj
        ugyd7frWtM3ovkESARWpzmMrSXGQL+4fpa7EOgDcLstmoaqhu2PpSKMpxK2AbTFF
        TbRw8cXePqtPAu2CybGVPiDoW/CKm55p7VJkTON66FiJSVJJPGFzL+q29RvAUe/5
        qVIq3o+oh9g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9829654A20;
        Thu,  8 Dec 2016 18:58:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BAC954A1F;
        Thu,  8 Dec 2016 18:58:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Date:   Thu, 08 Dec 2016 15:58:36 -0800
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com> (Karthik Nayak's
        message of "Wed, 7 Dec 2016 21:06:08 +0530")
Message-ID: <xmqqpol2rn0z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CA707E0-BDA2-11E6-90D4-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  

Will replace, with the attached stylistic fixes squashed in for
minor issues that were spotted by my mechanical pre-acceptance
filter.

 ref-filter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git b/ref-filter.c a/ref-filter.c
index a68ed7b147..a9d2c6a89d 100644
--- b/ref-filter.c
+++ a/ref-filter.c
@@ -76,7 +76,7 @@ static struct used_atom {
 		struct {
 			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
 			struct refname_atom refname;
-			unsigned int nobracket: 1;
+			unsigned int nobracket : 1;
 		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
@@ -559,7 +559,7 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 	if (if_then_else->cmp_status == COMPARE_EQUAL) {
 		if (!strcmp(if_then_else->str, cur->output.buf))
 			if_then_else->condition_satisfied = 1;
-	} else 	if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
+	} else if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
 		if (strcmp(if_then_else->str, cur->output.buf))
 			if_then_else->condition_satisfied = 1;
 	} else if (cur->output.len && !is_empty(cur->output.buf))
@@ -1106,7 +1106,8 @@ static const char *lstrip_ref_components(const char *refname, int len)
 		const char *p = refname;
 
 		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++);
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
+			;
 		/*
 		 * The number of components we need to strip is now
 		 * the total minus the components to be left (Plus one
@@ -1140,7 +1141,8 @@ static const char *rstrip_ref_components(const char *refname, int len)
 		const char *p = refname;
 
 		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++);
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
+			;
 		/*
 		 * The number of components we need to strip is now
 		 * the total minus the components to be left (Plus one
