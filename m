Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94C01F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeAVNN2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:13:28 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34037 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeAVNN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:13:27 -0500
Received: by mail-io0-f194.google.com with SMTP id c17so9375696iod.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oLKxhPSjxFEFlXnmsPk2ssYgsEd76VQIsR+45stY27I=;
        b=oorske8NnJBrrPQ6u7bAd9/fRZPEpkl7JCC8wgg3RCmILDLuJxJCOc9DzcS++7UxuD
         guUss+gRCelcC53OUtfW2Filp/cf4ZkYtc5zgoJTnx446HlnRdTGb1fzLvgPYYB3X7/q
         0M0A3lertyg+3x+Yw4+C8OE0kembbfSTr3Vm1ey3ah3HeOvSWMoTyS8wgBO/nNusWTmT
         M5h7JnUPQVdhVtmubhnQ5jIZU2wJy7WuLRfhXbP8U57HMlbeBZdJbx3Lpks341k9XTnA
         6d2513pr2QHrH4VDfxM45B0W0v5EwFeiShMlEH7X+peLQlHJ5/mb7OOWNkNeDCbdbOlf
         ZD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oLKxhPSjxFEFlXnmsPk2ssYgsEd76VQIsR+45stY27I=;
        b=TFGOsQVtykFLjfq5CzmLDFO26WL9w3BodPxrjsjxrZNgu3iR5cYDsybTjG5aIdLYwB
         bzE4gkTH18CfOGsAdhNfLsCLOVMJ4lDf7RTgh1bhCfOr7dzWP6wdOedfMauc0zO0dBAM
         a5E3TZXx1+5Kt4qff7dFy7bfh/0OGrzR4DUer2OLUDQQxhLSVyX339TXy/YMFI+mvUoL
         J/CLU9gEQ/8FXkX/S7DezQtM32Jskz62gD/u+Sgta654cOYdhaSdOSJQDYD9rH//Rger
         t8dZLyQ2P6kuIuXpVLRjkHusTpfSjLvaguQmakOX3mQVR0EoINeqUXfAQ1ouhgHnUW5S
         ulVQ==
X-Gm-Message-State: AKwxytdWWuoxlFk5xGXlG0/elPDWJhxx9jjgRd+NCXwti8uMswYCwhri
        INOQ3tw3Y3v8Qi5Cn1YuJm0MLbyWJ8Kz2sYANdE=
X-Google-Smtp-Source: AH8x227ja+Woig3YGABO+xrugqYfgqfm/w49L8IdQCEM6P2kDNO02lw5J4d/Om52HloY4eCG8CJKXLl9H6+tRV/4XrE=
X-Received: by 10.107.78.16 with SMTP id c16mr8293690iob.105.1516626807195;
 Mon, 22 Jan 2018 05:13:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.140 with HTTP; Mon, 22 Jan 2018 05:12:56 -0800 (PST)
In-Reply-To: <20180122115642.GB5980@ash>
References: <cover.1516617960.git.patryk.obara@gmail.com> <b5782b135fb68b645ffea711028bd6024176005a.1516617960.git.patryk.obara@gmail.com>
 <20180122115642.GB5980@ash>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Mon, 22 Jan 2018 14:12:56 +0100
X-Google-Sender-Auth: nIrTspAO345tS1HsSpfIGJey6W8
Message-ID: <CAJfL8+TrFV=DkJPZAYYYc69recsYiOGdeV8Ev0r5xfcmmqP-Hw@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] match-trees: convert splice_tree to object_id
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 January 2018 at 12:56, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jan 22, 2018 at 12:04:30PM +0100, Patryk Obara wrote:
>> Convert the definition of static recursive splice_tree function to use
>> struct object_id and adjust single caller.
>>
>> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
>> ---
>>  match-trees.c | 42 ++++++++++++++++++++----------------------
>>  1 file changed, 20 insertions(+), 22 deletions(-)
>>
>> diff --git a/match-trees.c b/match-trees.c
>> index 396b7338df..0f899a7212 100644
>> --- a/match-trees.c
>> +++ b/match-trees.c
>> @@ -161,19 +161,17 @@ static void match_trees(const struct object_id *ha=
sh1,
>>   * A tree "hash1" has a subdirectory at "prefix".  Come up with a
>>   * tree object by replacing it with another tree "hash2".
>>   */
>> -static int splice_tree(const unsigned char *hash1,
>> -                    const char *prefix,
>> -                    const unsigned char *hash2,
>> -                    unsigned char *result)
>> +static int splice_tree(const struct object_id *hash1, const char *prefi=
x,
>> +                    const struct object_id *hash2, struct object_id *re=
sult)
>
> Maybe change the names to oid1 and oid2 too. I had a "what?" moment
> when I read hash1->hash below.

OK

>> @@ -197,26 +195,26 @@ static int splice_tree(const unsigned char *hash1,
>>               if (strlen(name) =3D=3D toplen &&
>>                   !memcmp(name, prefix, toplen)) {
>>                       if (!S_ISDIR(mode))
>> -                             die("entry %s in tree %s is not a tree",
>> -                                 name, sha1_to_hex(hash1));
>> -                     rewrite_here =3D (unsigned char *) oid->hash;
>> +                             die("entry %s in tree %s is not a tree", n=
ame,
>> +                                 oid_to_hex(hash1));
>> +                     rewrite_here =3D (struct object_id *)oid;
>
> You don't need the typecast here anymore, do you?

Unfortunately, I do :(

Few lines above:
192: const struct object_id *oid;
194: oid =3D tree_entry_extract(&desc, &name, &mode);

Function tree_entry_extract returns const pointer, which leads to
compiler warning:
"assigning to 'struct object_id *' from 'const struct object_id *'
discards qualifiers".

On the other hand, if I change const qualifier for 'rewrite_here'
variable - warning will
appear in line 216:

216: oidcpy(rewrite_here, rewrite_with);

So the question here is rather: is it ok to overwrite buffer returned
by tree_entry_extract?

When writing this I opted to preserve cv-qualifiers despite changing
pointer type (which
implied preservation of typecast) - partly because parameter 'desc' of
tree_entry_extract
is NOT const (which suggests to me, that it's ok).

But this cast might be indication of unintended modification inside
tree description
structure and might lead to an error is some other place, if there's
an assumption, that
this buffer is not overwritable.

Maybe const should be removed from return type of tree_entry_extract (and m=
aybe
from oid field of struct name_entry)?

I will give it some more thought - maybe oidcpy from line 216 could be repl=
aced.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
