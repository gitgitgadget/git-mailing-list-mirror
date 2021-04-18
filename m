Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADAC433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD14F601FF
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 10:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhDRK1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 06:27:21 -0400
Received: from mout.web.de ([217.72.192.78]:43117 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRK1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 06:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618741606;
        bh=jFG5euiMr8Pw3dA7QPL3rqTVpoNJLcxcVIp12d4LQzk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=D+SgFwBQN0TXnPzjQkj9K+WwR+IcbDKeXJXhUsliqGgQ09bg4ZlUCUZSt/orQTeql
         NQovUS++l8ehNQLGWpazvTyQQjwIpqjnOvJ6oQ6f0cD4ZTSF/tKcxGP63qVuZ+qLyc
         Tw4u0PiFuRFc5ZjUkCTsiUAGnxYiNpxPTa7Wl3SY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M4sXt-1lXnv715Oh-0022og; Sun, 18 Apr 2021 12:26:46 +0200
Subject: Re: [BUG?] 'git describe seen'?
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq1rb8bhl4.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5cb071aa-16d1-8ea8-39e7-a0f5b89cbf3a@web.de>
Date:   Sun, 18 Apr 2021 12:26:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq1rb8bhl4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csN9s05vjX709+LfJxRQDZJmyUndbvaxm/bnNyBpuXisikk6nqk
 S5zzf2O7pEt9UIMRniostSp7P7gRgiCZNsX4l9sAgynoLrtx4YBveaY8SwHEwrz8farxLtZ
 K9ofN1mzmMUqygeGzVE+ZftWW7bGuTpTscbr2A2Tb2V5tM7Q7gc1LmdiLJhNsPzvBUW8rmv
 HnmSbZZLmZtnkAlApMN9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuHsYW8C73A=:ZAtWiFhQNCZbGmAbozOVNW
 7TNQurhexhTN8kc0ocexk4JbpeAkXOGwuN2C8o1vzP4R0+FJozpBJ2vDDwkNyXM6pqcsj2FIR
 HfRqw6roTcxuI0/2fEfR52dTwd4BrXM5fL+Ue7hV8H4LJdNIJzZ1WywdtmqqC/5x5GMdTcv5r
 1Sq029/j2uQm7xISnsLxuAJjZeitapFOnATfF3WHb21dqPn5qgCQCN9R8OTmJWO6fsfnqaVQK
 2muO3nKe1JsKORI7PGV4COC1nC4C95JeT1L1uIJmnGoNq+mPeaABeML/QU5NUgis/GwCXX6x8
 u/CJLjO5gfeQnd8qwldwHKSnclR+yWuaIAQlhb9xpMLqPHM2gLx1YKIMd/4lauIAU9Smc3fLH
 GOft8hy30LVxywKoPQQBZoMJkUW9sxH9fYx0E/3omwb8MjhTrnrEfesp0OR+K0BwhRkjtHeJz
 SYIcuAaWlDBpzX0aeY6U5BOfPUbxwHi7TbKnjQMKjdvwFs6viHoNw1MMtQo1tWR4GKs4iDsur
 h3/B0E0UqhgC2LsrDMosfY1lJlEMbgF9o851gkBu8858nU0kkEOFo3creKRYddYrSWdCtwqxp
 FfgugfbhHIeMv5Jv+tIfvpHEiv7hJhpCpai/DyMD4LH1WRo7NWLOxde2KpuWFGAAC7V/nhDa4
 fH17dtXZmvvTNAXOy4myfgleW4Xeh/lUExoXN3D0FX483lePG1iVfuVOj0izBBMSGeR+y38o3
 6MhZMNit7awDPZ1ztd7tU8KsyMrVT+aaSk49aYknmY0vWnweSmM7UhrF+Cvv9FonVfxOLeDth
 eV/Ylma0fVKrC1Hht0eBOHM/9Cf8GIwvTHzpiEivyGzW+JL4Vo5fP/XZnGUOxbcfphFXbxT9F
 1NERO6QBgaeQwcGIa/Xm5bTq3hss+Vl+rU82kAjLxO6D8CyDGeCA8BPa+6PoNC+riqk1b9Un5
 cUj7WUDkZL529ehqkHzwm1Pa8gcZH1QYPfyGMDTn0WOmNp7/EBjnc0yWaDSjyRfBWYzNaBBdG
 GJ87HZ8CGev2syToflm/6dI0j8aptQWax/sWsebhd4pyKxxwrNMYtxDBRFPXXcupsJwt/Z/Wj
 VAWAhE38cAGIT5tRKcyxmzg/icnvU3Vc6k8fs32Hes/dAcmOmkweyy/47o2Vg4eIJBbP76jJk
 P2pU10ozAmL8d6kk/R6IS1jYyaH/Dt+Cd5MKuB0ZJBuyEbSqBhissJo7c0JfIS0+EbmKU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.04.21 um 01:45 schrieb Junio C Hamano:
> This does not seem a new problem at all, as v2.10.0 thru more recent
> versions of "git describe" seem to give me the same answer.
>
> Anyway, I am seeing a curious symptom.
>
> $ git rev-list --count v2.31.0..seen
> 716
> $ git rev-list --count v2.31.1..seen
> 687
>
> The above means that 'seen' is closer to v2.31.1 than v2.31.0; there
> are fewer commits that are not in v2.31.1 that are in 'seen', than
> commits that are not in v2.31.0 that are in 'seen'.
>
> That is naturally expected.
>
> $ git rev-list --count v2.31.0..v2.31.1
> 29
>
> And that difference of 29 matches the difference, which is 716 - 687.
>
> But here is what is puzzling.
>
> $ git describe seen
> v2.31.0-716-g7b65b53281
>
> $ git rev-list --first-parent master..seen |
>   while read v
>   do
> 	d=3D$(git describe $v)
> 	echo $v $d
> 	case "$d" in v2.31.1-*) break ;; esac
>   done
> 7b65b53281ae06ee25dd47dead4062125eb54427 v2.31.0-716-g7b65b53281
> eec14f0fec886c909a29d63a94537df5a62be618 v2.31.0-714-geec14f0fec
> ...
> 103835562c64abef2319995716230f92092f87af v2.31.0-569-g103835562c
> d4324831d9152b16e091646e22a6e03423a59c93 v2.31.1-516-gd4324831d9
>
> Is there something tricky about the topic merged at 10383556 (Merge
> branch 'jh/rfc-builtin-fsmonitor' into seen, 2021-04-17) to confuse
> the counting done in "git describe"?

You get the expected result if you only allow one or two candidates, but
adding more of them changes that somehow.  The patch below shows the
values used for sorting the candidates; the numbers in the existing
debug output are a bit confusing because they show the finished depth
for the first entry and the raw ones for the rest:

   $ git describe --debug 103835562c --candidates=3D2
   describe 103835562c
   No exact match on refs or tags, searching to describe
         472        1 v2.31.1
         481        2 v2.31.0
    annotated        582 v2.31.1
    annotated        481 v2.31.0
   traversed 3621 commits
   more than 2 tags found; listed 2 most recent
   gave up search at 13d7ab6b5d7929825b626f050b62a11241ea4945
   v2.31.1-582-g103835562c

   $ git describe --debug 103835562c --candidates=3D3
   describe 103835562c
   No exact match on refs or tags, searching to describe
         496        2 v2.31.0
         499        1 v2.31.1
         524        3 v2.31.0-rc2
    annotated        569 v2.31.0
    annotated        499 v2.31.1
    annotated        524 v2.31.0-rc2
   traversed 3621 commits
   more than 3 tags found; listed 3 most recent
   gave up search at f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
   v2.31.0-569-g103835562c

Why do the depths change if we add another candidate?  I guess that's
because this loop can increase the depth of each candidate for
unflagged commits:

                for (cur_match =3D 0; cur_match < match_cnt; cur_match++) =
{
                        struct possible_tag *t =3D &all_matches[cur_match]=
;
                        if (!(c->object.flags & t->flag_within))
                                t->depth++;
                }

Adding v2.31.0-rc2 increases the depth of v2.31.0 from 481 by 15 to 496
and of v2.31.1 from 472 by 27 to 499.  We can print the IDs of those
unflagged objects like this:

                for (cur_match =3D 0; cur_match < match_cnt; cur_match++) =
{
                        struct possible_tag *t =3D &all_matches[cur_match]=
;
                        if (!(c->object.flags & t->flag_within)) {
                                t->depth++;
				if (match_cnt =3D=3D 3)
					fprintf(stderr, "%s %s\n",
						oid_to_hex(&c->object.oid),
						t->name->path);
			}
                }

We can then get the commits that increase the depth of v2.31.0, but not
of v2.31.1, when we add the third candidate, v2.31.0-rc2, using
something like this:

   $ awk '$2 =3D=3D "v2.31.0" {print $1}' err |
     grep -v -f <(awk '$2 =3D=3D "v2.31.1" {print $1}' err) |
     git show --oneline --no-patch --stdin

   68b5c3aa48 Makefile: update 'make fuzz-all' docs to reflect modern clan=
g
   241b5d3ebe fix xcalloc() argument order
   93c3d297b5 git mv foo FOO ; git mv foo bar gave an assert

And vice versa, the fifteen commits that increase the depth of v2.31.1,
but not of v2.31.0:

   834845142d l10n: de.po: Update German translation for Git v2.31.0
   408985d301 l10n: pt_PT: add Portuguese translations part 1
   1369935987 l10n: vi.po(5104t): for git v2.31.0 l10n round 2
   b0adcc311b l10n: es: 2.31.0 round 2
   c21ad4d941 l10n: Add translation team info
   8c4abfb8be l10n: start Indonesian translation
   8278f87022 l10n: zh_TW.po: v2.31.0 round 2 (15 untranslated)
   2f176de687 l10n: bg.po: Updated Bulgarian translation (5104t)
   1ecef023a9 Merge branch 'fr_next' of github.com:jnavila/git
   5b888ad949 Merge branch 'master' of github.com:nafmo/git-l10n-sv
   068cb92300 l10n: fr: v2.31 rnd 2
   f6a7e896b8 l10n: tr: v2.31.0-rc1
   929dc48e96 l10n: sv.po: Update Swedish translation (5104t0f0u)
   9b7e82b940 l10n: git.pot: v2.31.0 round 2 (9 new, 8 removed)
   4dd8469336 Merge branch 'master' of github.com:git/git

That matches the observation above that the depth of v2.31.1 was
increased by twelve more than the depth of v2.31.0.

And at that point I'm lost because I have no idea why adding
v2.31.0-rc2 should increase the depth of v2.31.0 and v2.31.1
differently.

Ren=C3=A9


diff --git a/builtin/describe.c b/builtin/describe.c
index 40482d8e9f..24d7a8a9cb 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -432,6 +432,14 @@ static void describe_commit(struct object_id *oid, st=
ruct strbuf *dst)

 	QSORT(all_matches, match_cnt, compare_pt);

+	if (debug) {
+		for (cur_match =3D 0; cur_match < match_cnt; cur_match++) {
+			struct possible_tag *t =3D &all_matches[cur_match];
+			fprintf(stderr, " %8d %8d %s\n",
+				t->depth, t->found_order, t->name->path);
+		}
+	}
+
 	if (gave_up_on) {
 		commit_list_insert_by_date(gave_up_on, &list);
 		seen_commits--;
