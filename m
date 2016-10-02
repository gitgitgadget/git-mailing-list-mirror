Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133A2207EC
	for <e@80x24.org>; Sun,  2 Oct 2016 09:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbcJBJIH (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 05:08:07 -0400
Received: from mout.web.de ([212.227.15.14]:56922 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbcJBJIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 05:08:05 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Mf0W1-1bX2aU0DCz-00OThB; Sun, 02 Oct 2016 11:07:43
 +0200
Subject: Re: [PATCH 2/6] sha1_file: always allow relative paths to alternates
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193604.hqspizasfpqa6bez@sigill.intra.peff.net>
Cc:     David Turner <dturner@twosigma.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de>
Date:   Sun, 2 Oct 2016 11:07:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160930193604.hqspizasfpqa6bez@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Wg32ZHPJ7X0UFoLOf9wtyZwZymAODKpbWTc+f+31vueALx45YOO
 83klm2usdfH4xGTt0/y78MTsFRmqrkupbKXRMOYJ1q0Mptt/zIMVdpN/nd+fPmGK/zMoASV
 jJ7hymbvgke/oDvRZTyMfPsk03UnUsFJO2oKp7qOtE9sYv0n5PHd0N1hwfm5FbCnh1GrAkY
 uFIYF+T9GVag3D1FTMVmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GJmhYFydSoM=:9ISh8jK1c5l6pzk+C0PfKh
 ZYvTMlUI6uWtHe1yDmrArPYdvZgdb8bjXtLBJOdWBbBKL83i6ZSdKAGnLbFP5mamMyAiMH+uN
 JSu2iWhSPZsW5MC5Z14voT5BRTZsTqVyBFkU9sM7aTh/NbYIhNeynSfE9qFLcce1jlTkUvOD+
 6BMT1PHhQkCqTWW6czWxV8JZrp7rneIcicFWQ3tqcLEYshDQeowjzlFVVdC7VXRZt3wDDxNoC
 Qa+q+I9JHtvCsR1Fhj53BjJ2uYg1CliRiez8kyFfYkcZ2A9P48dJqCs11aPNMaAN+n4BQeSyT
 wHSa5PvmVuK7z/wqPK5hgmWTLQi1fkjyp6LTK6N7MNl6GcKFvBlJr6N7FRw1FG/clWETqCHzg
 0XIQkPTKdrGF2uqC/clA3gYlMgfWDwLTzRzhoP6HpoOFgqXIZN8DNHiru9nAqP83trQOhmZIU
 APaIKp8n+yDsuHt1dondgF9I/IZ/joXIDF5NQW+zm0zvRs787XpgYxwyitW8xONMbWAGmenfl
 AdmmWoWVmHO9WbkrIdxoJ6yVccpde/iDACATVtSrp9cK1e6bfp4r0tbYlH4H/RcfEXQ9mUL2p
 0GuLcwdIZPId2yxXrA8TMYTKbGU3wyUbIJG8t1WBb2oSDl0smV94Txoim/FHN6nIksSH4yxJO
 7SlsUXe8s4cZ8xSM22JTCUQw4wcvdQ4qIGVbm9Y+8VAXLSxKNdFGHqoqhkw9Z1tl3Fprc+MfH
 QVQ3TbNkhcehVVuV6Ko8QFL6A+zyYwJMLdtmlMAmPzGGhSaLSBZFKjpR7Pgp8qAdJ9cimHohi
 jnEwS5F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.2016 um 21:36 schrieb Jeff King:
> We adjust the test script here to demonstrate that this now
> works. Unfortunately, we can't demonstrate that the
> duplicate is suppressed, since it has no user-visible
> behavior (it's just one less place for our object lookups to
> go). But you can verify it manually via gdb, with something
> like:
> 
>     for i in a b c; do
>             git init --bare $i
>             blob=$(echo $i | git -C $i hash-object -w --stdin)
>     done
>     echo "../../b/objects" >a/objects/info/alternates
>     echo "../../c/objects" >>a/objects/info/alternates
>     echo "../../c/objects" >b/objects/info/alternates
>     gdb --args git cat-file -e $blob
> 
> After prepare_alt_odb() runs, we have only a single copy of
> "/path/to/c/objects/" in the alt_odb list.

A better way would be to provide a UI for that.  We could easily bolt
it to the side of count-objects like in the patch below.  Feels a bit
hackish, though.

Per-ODB counting would be nice, but a lot more involved, I guess
(didn't try).


diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ba92919..b2afe36 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -73,6 +73,12 @@ static int count_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
+static int print_alt_odb(struct alternate_object_database *alt, void *data)
+{
+	puts(alt->base);
+	return 0;
+}
+
 static char const * const count_objects_usage[] = {
 	N_("git count-objects [-v] [-H | --human-readable]"),
 	NULL
@@ -81,10 +87,13 @@ static char const * const count_objects_usage[] = {
 int cmd_count_objects(int argc, const char **argv, const char *prefix)
 {
 	int human_readable = 0;
+	int list_alt_odb = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_BOOL('H', "human-readable", &human_readable,
 			 N_("print sizes in human readable format")),
+		OPT_BOOL(0, "list-alternates", &list_alt_odb,
+			 N_("print list of alternate object databases")),
 		OPT_END(),
 	};
 
@@ -92,6 +101,12 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
+
+	if (list_alt_odb) {
+		foreach_alt_odb(print_alt_odb, NULL);
+		return 0;
+	}
+
 	if (verbose) {
 		report_garbage = real_report_garbage;
 		report_linked_checkout_garbage();

