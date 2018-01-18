Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AAF1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeARVkP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:40:15 -0500
Received: from mout.web.de ([212.227.15.3]:56931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbeARVkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:40:14 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYRZ-1f83x63dLR-00o0j2; Thu, 18
 Jan 2018 22:40:09 +0100
Subject: Re: [PATCH] describe: use strbuf_add_unique_abbrev() for adding short
 hashes
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180116171130.16568-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7390fd9c-5969-61f1-86b8-6971eaf1432b@web.de>
Date:   Thu, 18 Jan 2018 22:40:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180116171130.16568-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:a5WcQOs8/nfI5NTdyczUKRvt84grR9gGjSyZjAict2INue4d3ss
 zMtMhJy2Ikk6izh+bu73uSXsPhkS9N0zCz6G2QL2CwkD+zJQ+oJmUHI6d77il7KYOzzt4PS
 lH9xiYA5tz280MDzFI9t1RbyohNZoROAqtY5Lo1DbDoNEMZvLSNldeTeN5zYCAjPa2OPuhF
 14Cf+7RgPlaiSsKfOb3oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UvggZQxZzMA=:DXvkWljQgvkMuIsiBNQZju
 AsRHL8/k2g96FSRHklgfKpkfFrlpVfsnmVV1/pCExBS9IffnfduH0LQyRPyYgoOXZsAhPUOVJ
 1Z1Qp+8Z1jwxpP3fMSGaJx8cyiJjSNZ1a5b3EG35SKAA7VxKNKMA+PYhfDgFpfFiyf409/DWX
 jtOMJ6xfuqljiuhORrwv14KWJ+Ewc0YUmKCKT4AqbjnMi6630tzQ0NV/gD1KdPwpqxMyCRBQT
 QH6aiysRTPVuZMLC3lS22w+1AamfKdYuFZNExF2m+TfV9wU27F/Nzfqv8Q3Q0vuLLMjnJIVZP
 eWUZV1tg+yYwXTvKLVqLZMsBzr0KbBZLvcwAbm2SJO3ENgVeeYigL+zZ89FnOwrUDr3T4ZIru
 DuJn4DwokfESBOhodNSO2Bhh7qiC1c7iaLBdFd1Hz8H/L0MOc5sxnMQlHckCRHpyD12aEtoFm
 vcVpTDiYl1Q6Dvr9BKMN0mTRvQNuGYBN3HRKEfafmVypco98OOO88Ev+zCC2EmpgGB7BsayiS
 LeNosXJdZLx7ttmCjVeBYZEw6JFyEIj9rIOj5psIMnfgqaQD8sPz1QUBB8KVRTZdHQeVwIitG
 WdxsNM3qY4/g67Z4oIeEdu2aSqkdSWyRIH2Bi/a/AFBe7Ifmi7qXZNpczrLZdD+j9uhIMp2Gt
 im90ZzBWqOSBDAazvXlIsrAW6xhr7biWA/2dzu/scvXYLQcb0iB+Cc7RC/N1BQZFaYIZ/JJdz
 uQ093bdjJ1vE4Fmrrp1GkKZnLetD6voDPFpVBC0a+orFCa6gPfk9Z+f/Xpfn5jjEilm2ZwPJm
 p3mYV5c7LUCzjsaevi2uRomnuQzjOqxE0cer0uPN3ii8BOYIvk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.01.2018 um 18:11 schrieb SZEDER Gábor:
> Unfortunately, most of the changes coming from 'strbuf.cocci' don't
> make any sense, they appear to be the mis-application of the "use
> strbuf_addstr() instead of strbuf_addf() to add a single string" rule:
> 
>    -             strbuf_addf(&sb_repo, "%d", counter);
>    +             strbuf_addstr(&sb_repo, counter);
> 
> It seems that those rules need some refinement, but I have no idea
> about Coccinelle and this is not the time for me to dig deeper.
> 
> What makes all this weird is that running 'make coccicheck' on my own
> machine doesn't produce any of these additional proposed changes, just
> like at René's.  Can it be related to differing Coccinelle versions?
> Travis CI installs 1.0.0~rc19.deb-3; I have 1.0.4.deb-2.

The version difference may explain it, but I couldn't find a matching
bugfix in http://coccinelle.lip6.fr/distrib/changes.html when I just
skimmed it.  I wonder if the following patch could make a difference:

---
 contrib/coccinelle/strbuf.cocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 1d580e49b0..6fe8727421 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -29,8 +29,9 @@ cocci.include_match("%" not in fmt)
 
 @@
 expression E1, E2;
+format F =~ "s";
 @@
-- strbuf_addf(E1, "%s", E2);
+- strbuf_addf(E1, "%@F@", E2);
 + strbuf_addstr(E1, E2);
 
 @@
-- 
2.16.0
