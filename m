Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BEE1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 22:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeCFWNc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 17:13:32 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:41222 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754003AbeCFWNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 17:13:31 -0500
Received: by mail-pl0-f53.google.com with SMTP id d9-v6so121870plo.8
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QQTkgosCm20cBrqEjZ2CBIjn8BE4cQofBKPjM5s5E44=;
        b=HEY0Nr1o3qOdLkM+scPcHTya9mAbIysE6eOp7Rn4KdzyPgB/ool7KkhrxuSQMZvpcw
         5/JGlgzuCsuUQl7Wqiohk5hfEn0GG44eux2otaNDRgT9imY47VbLMAgyX4i8l8ZYK9K0
         e0UnO0dpVTnhAJPaHSwdFPVNsAeaSqhMHJiJq8yZ9cKtr9I6lPotlvLGtgL84jB2oJ0O
         mXsp2wdU9QDx7v+yyDhTK6haN/wPDewsQ02RWrjpodIpAaKzNCr1n67vKnmTpaVYtLwp
         C5c1lC3DTSQDB3OOlhCcs9FZmooKZXInzGtQ/ZWGNneKAL9rn+XozmkoN8RJuIzoEWi6
         mnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QQTkgosCm20cBrqEjZ2CBIjn8BE4cQofBKPjM5s5E44=;
        b=AqQI8G5sR2L8El8fEVGY+S7rCyokMFW1Jts65uJzG6/u06BQVMtXAq0bWAzAn7WYpc
         FhckzEA5U0dpGm99zCdLRahnJNM3SLbwkQNa0ghtpyAGtDkVQjtdLBv/hSTJB3dOg8No
         iE7978gb1wX0nMjxnpk6q3QVW7TdMcyHKuRy+/pRgvt35iHfsMEDeg15V+SQbYZsP4Vi
         2TWHKLr7nYPXFZoY/mayCxJEEC8ffMhdHIuixNetKmqtU2hJh5g4M07MfhGtcXimL6ap
         O4YD5oNPCjdNV85s8aloeqV7Y/DonQlH3jEVfGvtKrhCSGo2fNJhJB3BwlLkg2fxluAx
         jtrw==
X-Gm-Message-State: APf1xPDFcAIrSP7/dH6UUOdF2mrun9HBWj2IuJHFCbtdXi/JZKfslitT
        +Z1Ux7WywKkL3qkNBPSCLfw=
X-Google-Smtp-Source: AG47ELsX7XbHp+H19WJTubg/bL+RqJDjnLFlxUE/n7RDIpuXKxwp08V0oQveFEkcOBGeL3aJhvXwfw==
X-Received: by 2002:a17:902:7294:: with SMTP id d20-v6mr16473286pll.43.1520374410849;
        Tue, 06 Mar 2018 14:13:30 -0800 (PST)
Received: from neu8r3hm32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id h26sm24508159pgv.22.2018.03.06.14.13.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Mar 2018 14:13:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 5/8] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cTOpBODeoHV=+4-4MEjKM=pUrZSa=BEmHh4mVP=xPpFCA@mail.gmail.com>
Date:   Tue, 6 Mar 2018 23:13:24 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <570D707A-DD9E-4397-8155-E8B3C3D09760@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-6-lars.schneider@autodesk.com> <CAPig+cTOpBODeoHV=+4-4MEjKM=pUrZSa=BEmHh4mVP=xPpFCA@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Mar 2018, at 21:42, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sun, Mar 4, 2018 at 3:14 PM,  <lars.schneider@autodesk.com> wrote:
>> Git recognizes files encoded with ASCII or one of its supersets (e.g.
>> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
>> interpreted as binary and consequently built-in Git text processing
>> tools (e.g. 'git diff') as well as most Git web front ends do not
>> visualize the content.
>> [...]
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/convert.c b/convert.c
>> @@ -978,6 +1051,25 @@ static int ident_to_worktree(const char *path, =
const char *src, size_t len,
>> +static const char *git_path_check_encoding(struct attr_check_item =
*check)
>> +{
>> +       [...]
>> +       /*
>> +        * Ensure encoding names are always upper case (e.g. UTF-8) =
to
>> +        * simplify subsequent string comparisons.
>> +        */
>> +       return xstrdup_toupper(value);
>=20
> xstrdup_toupper() allocates memory...
>=20
>> +}
>> @@ -1033,6 +1125,7 @@ struct conv_attrs {
>>        enum crlf_action attr_action; /* What attr says */
>>        enum crlf_action crlf_action; /* When no attr is set, use =
core.autocrlf */
>>        int ident;
>> +       const char *working_tree_encoding; /* Supported encoding or =
default encoding if NULL */
>=20
> ...which is assigned to 'const char *'...
>=20
>> };
>> @@ -1064,6 +1158,7 @@ static void convert_attrs(struct conv_attrs =
*ca, const char *path)
>>                        else if (eol_attr =3D=3D EOL_CRLF)
>>                                ca->crlf_action =3D CRLF_TEXT_CRLF;
>>                }
>> +               ca->working_tree_encoding =3D =
git_path_check_encoding(ccheck + 5);
>=20
> ...by this code, and eventually leaked.
>=20
> It's too bad it isn't cleaned up (freed), but looking at the callers,
> fixing this leak would be mildly noisy (though not particularly
> invasive). How much do we care about this leak?

Hmm. You are right. That was previously handled by the encoding struct=20=

linked list that I removed in this iteration. I forgot about that aspect =
:/
I don't like it leaking. I think I would like to reintroduce the linked
list. This way every encoding is only once in memory. What do you think?


>>        } else {
>>                ca->drv =3D NULL;
>>                ca->crlf_action =3D CRLF_UNDEFINED;
>> diff --git a/t/t0028-working-tree-encoding.sh =
b/t/t0028-working-tree-encoding.sh
>> @@ -0,0 +1,135 @@
>> +test_expect_success 'check $GIT_DIR/info/attributes support' '
>> +       test_when_finished "rm -f test.utf8.raw test.utf32.raw =
test.utf32.git" &&
>=20
> It seems weird to be cleaning up files this test didn't create
> (test.utf8.raw and test.utf32.raw).

Agreed.


>> +       test_when_finished "git reset --hard HEAD" &&
>> +
>> +       echo "*.utf32 text working-tree-encoding=3Dutf-32" =
>.git/info/attributes &&
>> +       git add test.utf32 &&
>> +
>> +       git cat-file -p :test.utf32 >test.utf32.git &&
>> +       test_cmp_bin test.utf8.raw test.utf32.git
>> +'
>> +
>> +test_expect_success 'check unsupported encodings' '
>> +       test_when_finished "rm -f err.out" &&
>> +       test_when_finished "git reset --hard HEAD" &&
>=20
> Resetting to HEAD here is an important cleanup action, but tests don't
> usually clean up files such as 'err.out' since such detritus doesn't
> usually impact subsequent tests negatively. (Just an observation; no
> re-roll needed.)

OK. I'll fix it if I reroll.

- Lars=
