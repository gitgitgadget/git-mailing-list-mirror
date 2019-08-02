Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE861F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391479AbfHBQxD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:53:03 -0400
Received: from mout.web.de ([217.72.192.78]:43365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfHBQxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564764775;
        bh=OGjLUDNIWjAxgFn9l1HKIu3GglOJT5VP/BmUauoKZh0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=MydR0WMfakYbMlu+owMDcHhTtG4gh5kSY4ISuU3GjPVhT6gAjWC6G4fIQyRoEN+Qn
         8r1MNgiWN3qO/T13Sn72HT1HH3+Jjt4sRdJs/CYdEEsTRM4A1//Ot7U3LHgHy2RwAQ
         g56h+UKizMExSDwrJsb+2IIBe/iqABAWHWTX6+Kc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgfJz-1hg4OG2ceV-00NzPb; Fri, 02
 Aug 2019 18:52:55 +0200
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
To:     =?UTF-8?Q?=c3=89tienne_SERVAIS?= <etienne.servais@voucoux.fr>
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Message-ID: <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
Date:   Fri, 2 Aug 2019 18:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nfOKyegVBebIPhEYTN05cKqu+2CogoueU6M62aToM8S+gqTVmLE
 5BtDsWw6sF7TJMUmvo+N2BT8E2kRv0MYeRkEG4Zpx2V14yGpk1VcvvsjJHA2FOVQvG7lW/G
 IEVzaDGPDLiwWpl6xJp502XVm9j3fnSwEzO1OkSDKvuBVs0omtBVvcXJ1jKJYzKrByCXulU
 iskXqbBR1Gi8SiQ3/UuFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LcCnpvOeddI=:O9ao3cvM43NZT0MrEugnmD
 yALAwBraIdhDgiNXZrWmKIqy5cCFsmHIEzdNj6aY7paYr0/nXu5oNeVWV5Q/E2/EWNEu2SFdz
 RCLR03WxA7ligGonP8zv7KiiQNjp6OGkyAw0UZB6YOL7hmlf5sa6QQ+0vwb8u8bVXmKBqUALW
 q0LaNG8K4T3WBBUVWyA+G4WwEBFurrg9yjIRPxjZz/eD8uKSG8M8EOWvcD2c1QmDJ0cudCm/W
 jlhFcqW4htJLZQOMtSciaMhiDfjRHy19MyA/B3LFZ4OjVH50MSYSzrfnkzYOEvR3Tmukxq5aJ
 oROxik7CylfPu9oBg0C11CwVZOE6e8C9xG/AKHDWDsiRtbZ7zEPTAefI3YxwDZn6TRRbOqFCo
 zxmnC4pbW3HtsyNbWVW+FZwvLSRiXqgRULmrE9ktj5aRKFITuB0u2VVlBk1HJ0LXJuIC92c6S
 0UHHAvVEyjWDH7cjLKfMpfSVmu+vuNnkHseE9+yyPTwYjQc/7Geag7kfTJqMScRgzLj4yIrfn
 zvKdnY35qK3xmIVqx2130yNiMoANRtAtZvKamHIbLjEhmPl+vn6g0XP6rZ6baPx186Eo52KFZ
 FlbGyp83zFLfLtUh+EaDrQsaISbWwkxBWYnAoE6T3SYv81f1NqKIdlJVKOLNvvwmVIgRy0UdM
 AAxgFGPnK47bxmO073ssFb8giqetp+wvYCgXMSoaQ7+PQRU7z5Z7L3sbWAGheru/llCl6iLnM
 fZMv1qwroREiip/7fTaG/Fp5JlkZT1yF+A10vJJVNcvlGxskoQRvxaFNj1gI4tp60n6sNLO8m
 Jo0AX4DVj6akHCUhVxKZHoW+XkTusSL4MhRLVKyfeiT5z4GJnBGS7Lv4kH35UbPpRuJtVKK9F
 zw7mQfnE32zszNzcRbGDOQXyTs6Yxfk6n0DppxtRtNw9NtSm/rdhE0S7n/GqSYbLDACUESpX/
 /IIUcQqiFFErqH/pOXPcOfPTelpzko+UGyA/y3oNMlsDd384yctt3f7wKw6AvEBFwfOTgQ4aG
 2LPi/uIJgg61cj8Np9EFZx3xk2RIutwOMmoeyJ9D3sgIY2myzVCX5pCzxNJmrs511L9RdXfw9
 SZ8bvF7ciNfX2CUn3gnKGUYobE+hK1uI1MGsk3XSmsXF19uBCV9649ZhetLHA//DkQb5u3Nkh
 wcXUg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.19 um 10:47 schrieb =C3=89tienne SERVAIS:
> Thus, when I enter
>
> ```
> git log --oneline --graph  --decorate=3Dfull --decorate-refs-exclude=3D'=
refs/tags/<pattern>'
> ```
> The selected tags are properly excluded but once I add the
> `simplify-by-decoration` option
>
> ```
> git log --oneline --graph  --decorate=3Dfull --decorate-refs-exclude=3D'=
refs/tags/<pattern>' --simplify-by-decoration
> ```
> The excluded tags pop back again.

Does this help?

=2D- >8 --
Subject: [PATCH] revision: load decorations lazily for --simplify-by-decor=
ation

Let setup_revisions() and friends respect a filtered set of decoration
refs loaded by callers by postponing its own load_ref_decorations() call
to just before decorations are used to simplify history.  That function
only does any actual work the first time it is called.

This allows using the revision option --simplify-by-decoration together
with the log option --decorate-refs-exclude and having it simplify over
the restricted set of refs.

Reported-by: =C3=89tienne SERVAIS <etienne.servais@voucoux.fr>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c     |  8 +++++++-
 t/t4202-log.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 07412297f0..d3456c959b 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -633,6 +633,13 @@ static int rev_compare_tree(struct rev_info *revs,
 		return REV_TREE_OLD;

 	if (revs->simplify_by_decoration) {
+		/*
+		 * Load decorations lazily; later calls have no effect.
+		 * This gives callers a chance to load a restricted set
+		 * beforehand.
+		 */
+		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
+
 		/*
 		 * If we are simplifying by decoration, then the commit
 		 * is worth showing if it has a tag pointing at it.
@@ -2063,7 +2070,6 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 		revs->simplify_by_decoration =3D 1;
 		revs->limited =3D 1;
 		revs->prune =3D 1;
-		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order =3D REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order =3D 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c20209324c..bb66d1d93c 100755
=2D-- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -837,6 +837,21 @@ test_expect_success 'decorate-refs and decorate-refs-=
exclude' '
 	test_cmp expect.decorate actual
 '

+test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (HEAD -> master)
+	reach (tag: reach, reach)
+	seventh (tag: seventh)
+	Merge-branch-tangle
+	Merge-branch-side-early-part-into-tangle (tangle)
+	tangle-a (tag: tangle-a)
+	EOF
+	git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
+		--decorate-refs-exclude=3D"*octopus*" \
+		--simplify-by-decoration >actual &&
+	test_cmp expect.decorate actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=3Dfull >expect.full &&
 	git log --oneline --decorate=3Dshort >expect.short &&
=2D-
2.22.0
