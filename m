Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C67820248
	for <e@80x24.org>; Thu, 14 Mar 2019 13:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCNNRq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 09:17:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:41201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfCNNRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 09:17:46 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHqj-1geTL51DYv-00iVbz; Thu, 14
 Mar 2019 14:17:34 +0100
Date:   Thu, 14 Mar 2019 14:17:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try
 harder
In-Reply-To: <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903141410360.41@tvgsbejvaqbjf.bet>
References: <pull.161.git.gitgitgadget@gmail.com> <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com> <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xm1Ci7Mg3bfyCarwXvif8pNCUgkMPiDEXD/WjQG/zly39R63QTd
 u/wZAflOLrAVJT2oWiuO06eDmneku20mc/Lqj+dNOyHdC505E30t/dRWonktEzgNYQ82Mb3
 B+z4FnQQX91QdEhUfYJh0BKntNpiguvkJvPMgh8+Ao/mMupcpBOUWNbKK9gjqTu29eSE8Xb
 cuFVYU9PC2Rbfr8x3iOfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5E7cF24JQDk=:TPIQdKInEQrZoMQ7AHfoUV
 9Zn0WxEVQS/6YfXFfKLS9n1vSBfoSbz1n+79EFUSYfK1sRowVPwtK2U0tw5HLk+et4KH27kyo
 Pf31+FNp8TbuRqnZR6l/mldevItF5wrZTewuoRQ3juEQJWCPcxD7+vB2Aian/9ks1FcSTFTy2
 v8b/SCUo7JS4nNJomJZTSwY9IipfZxthnpmgFxvoIIkcXd5JjSgPTGb3OdSRWgwarxjo5gDTd
 GdLA8X14c5xS1u5D+hHvaBo44TPiw6bhmORDGoKUTXZ0oGiVqiXgl36mm7HGTZGmItX7a4S4O
 5lI6bJvHhOj9ZghPLj/g60pPfFNuWBDMxCXFUGvyxb8nO1j47gVFGG8IfUhUyYFyRAy033i7s
 L7qpDaRQOdh0rKMcfsTC5XitlJgc83EnUK2RIHJ67eGqM32uWuAxaCZozl9Gt1h0zXIFqfxOA
 oXFUD4FAR1+QMV6p0y3w0MH9pdeKq404QIDkXaw+gurll2NxVUnPvcz4DUAupleDCkCxoFOnV
 o35tvJ40vGZBXlnEf0mcrm2yG5/8GxZixH8uyUB5dPM5t2lZcQqIpNJi7SQpr3TsNOfskaA+l
 xERFIgXuG90O46E1+6Q4dqsSL2yehidgr8x2ayWQqasTc0tiyioHinoPl2F1AGZf24wFF0LBX
 GAI6uzBQVEx8OcmBJeeOVdo/EZF0X+R1VyrVLXavOWIB19GEsa+cMxzF/TK+aBzXQO2mdQOZc
 E9A7sx/vdMVFVW4Qf2ooVM6LIENQhHZIaZej2uu/SzXKHvLCaiHB7S8IAjNAHvlrCm2nvAFch
 joeAwLfRVCMEGBS3LdUS5hXpDMcPXh2T63RFxy+heG5IW0/+r2IF2De8u5nu+izCfrijyMpyq
 +DmlsVN8PKt/pW5P41fOfWrj9tiy82UvJwjeGWODwVUcR/HUpeF//Y8yGIzptWJkGMaW4bhCc
 IHv2oDgHmuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Peff,

On Thu, 14 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > @@ -442,6 +442,18 @@ static enum get_oid_result get_short_oid(const char *name, int len,
> >  	find_short_packed_object(&ds);
> >  	status = finish_object_disambiguation(&ds, oid);
> >  
> > +	/*
> > +	 * If we didn't find it, do the usual reprepare() slow-path,
> > +	 * since the object may have recently been added to the repository
> > +	 * or migrated from loose to packed.
> > +	 */
> > +	if (status == MISSING_OBJECT) {
> > +		reprepare_packed_git(the_repository);
> > +		find_short_object_filename(&ds);
> > +		find_short_packed_object(&ds);
> > +		status = finish_object_disambiguation(&ds, oid);
> > +	}
> > +
> 
> This looks obviously correct, but two things that made me wonder
> briefly were:
> 
>  1. is reprepare_packed_git() a bit too heavy-weight, if the only
>     thing we are addressing is the loose-object cache going stale?
> 
>  2. is there a way to cleanly avoid the three-line duplicate?
> 
> My tentative answers are (1) even if it is, but get_short_oid() is
> already heavy-weight enough; it won't be worth restructuring the
> code to make it possible to clear only the loose-object cache, and
> (2) a loop that runs twice when the first result is MISSING_OBJECT
> and otherwise leaves after once would need an extra variable, its
> iniialization, check and increment, which is more than what we might
> save with such a restructuring, so it won't be worth pursuing.
> 
> But others may have better ideas, as always ;-)

Peff tried with a function, but I think that this would actually be a
really appropriate occasion for a well-placed `goto`:

-- snip --
diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df10..36a66026964a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -415,7 +415,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
 {
-	int status;
+	int status, attempts = 0;
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
@@ -438,10 +438,21 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	else
 		ds.fn = default_disambiguate_hint;
 
+try_again:
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
 	status = finish_object_disambiguation(&ds, oid);
 
+	/*
+	 * If we did not find it, do the usual reprepare() slow-path, since the
+	 * object may have recently been added to the repository or migrated
+	 * from loose to packed.
+	 */
+	if (status == MISSING_OBJECT && !attempts++) {
+		reprepare_packed_git(the_repository);
+		goto try_again;
+	}
+
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
 
-- snap --

Granted, it's 11 lines inserted and one changed as opposed to 12 lines
inserted, but it does make the code DRYer (and therefore slightly safer to
modify in the future). I pushed this to the GitGitGadget PR.

Thanks,
Dscho
