Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC111FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 08:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdIJIpE (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 04:45:04 -0400
Received: from mout.web.de ([217.72.192.78]:59377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdIJIpC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 04:45:02 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRCnT-1e1Zvz0dJv-00UcXM; Sun, 10
 Sep 2017 10:44:48 +0200
Subject: Re: [PATCH] shortlog: skip format/parse roundtrip for internal
 traversal
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de> <20170830180037.20950-8-l.s.r@web.de>
 <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
 <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
 <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
 <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
 <20170908043633.smytugbn7ge4twlm@sigill.intra.peff.net>
 <xmqqk219zobb.fsf@gitster.mtv.corp.google.com>
 <20170908092126.55o3342macegtlga@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0239ea26-199c-b39e-91a9-5ea5c470af8f@web.de>
Date:   Sun, 10 Sep 2017 10:44:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170908092126.55o3342macegtlga@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:tqUqiEgnrp9N3gWTfit9PauN2N9lAHgRQypl4G4Sdk+lPV2++Vw
 TwJnJ0ghdzJ0YqBh2gGK4sSXuCAKZfA4Mphs0lv9IlyDTNnmi57edLurYh+tcLlFB+g1ysS
 V9QGVlQU5/Hhk4x0IiGNtOGbFU3Os7aEH8olrTwTk36iR99TScgUCvc06r4j1c9vwRPZa1P
 E6BZ4DGfnQ7BweZZWQw+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s+8bgwDwe/A=:AFC1Pb+3/m9EQnvvK4+KaG
 vlG/EbXs/YghjZVIa1TVlN+ft5GhNlkixIVmx1xScUi/EfrQ6uLE57hhBJErOS9nKMaFeDPMw
 bwuwUx8gYuISrmkpHGX3oRvsL9EwE69qlrj1HXdX9aPaaoyus3rXA2Y7o5FaITgLtY013wc7Y
 ZTFrwdp0Ui09PN0P1uO1IyeibajIA45p+8tHh17rD0y4M+42HNDZrheP6QHh58qxmo09Keg/p
 ZGQ3Sb+JyDl+0jIjyXgdQJ8kxVvm+HIywu2C6n98MlEj1hZEB0r5y5y7cXo/0ySTpBL0L8L2m
 9IZerq0f/PDuchus1kyBfJgDGnGTUm2HC/LjRM4ETzfRBhNAVwFrjLKKGKhTmHDKJStwFeESn
 gizRFkMK+go0EF2uZTpGv/EBRO+NbevghxyN+AblMC9XNYiDcM3Df2d8wSNoZxAl+Zq74VuqH
 HV0JPlMZSfWFT/mDeKsFtlO1PvmgF00flqWAWJBOYBV2BAQhP/JFkahe1wZQzfE99UtwkqKJ9
 JZIWMBWJoleawAXXejhq5DRwrHZxZuGYBrMWKASgxMiUQR8QpTpAAFpqm9ByxeBhB3nUwd/x2
 rV1OH3vA08IiJxFnn8G0VRgUwytB8jxnry3es9MAVrq00Yx/vcK54+bN02AJsZNvkDsnsZ9mk
 qrDfWDWhpGItp8HcdPwxVylW1Hcj2Ui4E+kUsTw3EGsNbBSgBcsOwDrwtGLIiRn5NTx++F8O4
 59kxwPbf6vS9PUZnBitEi15dNdMqiblqXGuVH08pFDfVx2JoYYtuEH/j8kfbnY9yYQYIkb28G
 MQ+bjS1udV/X28Gw9N2RktuGuyYEhkrQiIePdFvIv6baLq6oUo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.09.2017 um 11:21 schrieb Jeff King:
> Note that the non-stdin path no longer looks at the "mailmap" entry of
> "struct shortlog" (instead we use the one cached inside pretty.c). But
> we still waste time loading it. I'm not sure if it's worth addressing
> that. It's only once per program invocation, and it's a little tricky to
> fix (we do shortlog_init() before we know whether or not we're using
> stdin). We could just load it lazily, though, which would cover the
> stdin case.

The difference in performance and memory usage will only be measurable
with really big mailmap files.  However, it may be an opportunity for
simplifying the mailmap API in general.  Conceptually the map data
should fit into struct repository instead of being read and stored by
each user, right?

> -- >8 --
> Subject: shortlog: skip format/parse roundtrip for internal traversal
> 
> The original git-shortlog command parsed the output of
> git-log, and the logic went something like this:
> 
>    1. Read stdin looking for "author" lines.
> 
>    2. Parse the identity into its name/email bits.
> 
>    3. Apply mailmap to the name/email.
> 
>    4. Reformat the identity into a single buffer that is our
>       "key" for grouping entries (either a name by default,
>       or "name <email>" if --email was given).
> 
> The first part happens in read_from_stdin(), and the other
> three steps are part of insert_one_record().
> 
> When we do an internal traversal, we just swap out the stdin
> read in step 1 for reading the commit objects ourselves.
> Prior to 2db6b83d18 (shortlog: replace hand-parsing of
> author with pretty-printer, 2016-01-18), that made sense; we
> still had to parse the ident in the commit message.
> 
> But after that commit, we use pretty.c's "%an <%ae>" to get
> the author ident (for simplicity). Which means that the
> pretty printer is doing a parse/format under the hood, and
> then we parse the result, apply the mailmap, and format the
> result again.
> 
> Instead, we can just ask pretty.c to do all of those steps
> for us (including the mailmap via "%aN <%aE>", and not
> formatting the address when --email is missing).
> 
> And then we can push steps 2-4 into read_from_stdin(). This
> speeds up "git shortlog -ns" on linux.git by about 3%, and
> eliminates a leak in insert_one_record() of the namemailbuf
> strbuf.

Great!  Thanks for stepping back, looking at the bigger
picture and making it prettier.

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   builtin/shortlog.c | 56 ++++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 35 insertions(+), 21 deletions(-)

While longer, the resulting code is split up into more
digestible chunks.

René
