Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53756202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbdKAVFu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:05:50 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:53494 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933306AbdKAVFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:05:47 -0400
Received: by mail-pg0-f52.google.com with SMTP id s2so3132702pge.10
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=gSTRJJTCuZwQ6VkKJlJH8lnYQtIKJebuHuR6r6M1JuA=;
        b=tbfOC3RcitoQh0TJFiu6HNtUkyTjKuISTOFaIk2CaQKRQ0uGjyTq4noOvIOxMIstz8
         7GVPueQ+9wqgQYtWRJ8sxYmUKVlVIxOu6oqG7VBBdtAHf2Uo/TFq2SmobVVTAz0AntC0
         bUfHxXSh+Cvbb5AOmh8BBmW+UurK3N59+FlmIwzZTNT81L8qNzmE+trvB2UtGW7Vc0mJ
         3QAUkHbO0z+gwXY/n3ZLSuVKWBOSv+jgl2LnXMKbW5IRPaqNcphGH+Ntna6xxhkiWOVo
         9rFMvcAptwsxDpbqzkZhMqGHt6miNViy3RPC5PRrL8fI411gyKqe1nWpCQ0Axxr1N7yd
         3FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=gSTRJJTCuZwQ6VkKJlJH8lnYQtIKJebuHuR6r6M1JuA=;
        b=E2c3YciwXKYqYFiPNUJ7wSaaG702f8I3vw9enN5LGfnhhrmdBk0bCJO8AUBLZLrKXM
         34PtZVo2TgqOOzRpWWbo+T5m4JrTwbcsJ3bctNMoo4Jmy5wF5eUp/+7N2u+Co0rNgrKW
         SupIFTGo1UddMi42/Lpo5+1d13PmW2aZDzwNzTIx/htplxQqC0aEyHCaNkJ74vc5JpNV
         Lg/q4Tb3UohFvUPpHMMfuT2bqk10j0X0qug/3x0jVZGfYSAdKOHBoh5YD5FtCdpVBCiY
         +INS9WkO2mEZ4UhaYizfbBuK/8Yt3a2a3oWFC9vMEhH6NeqQtiQmziSgONbjnu8+lHit
         tmXA==
X-Gm-Message-State: AMCzsaU8BJ4yV2buMfduiYCcCJIWFwuBVwySUDLvBBf68h49rF6RbUZN
        sCuaxCreYHl/2BqEeat1AcM=
X-Google-Smtp-Source: ABhQp+TOvaE5QW2oxvWXS3PGcYdF+Pc2gud5RqYTgsIUtauYCRmCoPKEWxkU6OGiIhjPNL44FuLItg==
X-Received: by 10.99.171.6 with SMTP id p6mr1207490pgf.30.1509570346234;
        Wed, 01 Nov 2017 14:05:46 -0700 (PDT)
Received: from [192.168.1.126] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id r16sm2500633pgt.72.2017.11.01.14.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 14:05:44 -0700 (PDT)
Date:   Wed, 01 Nov 2017 14:05:41 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011329300.6482@virtualbox> <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On November 1, 2017 10:59:08 AM PDT, Stefan Beller <sbeller@google=2Ecom> =
wrote:
>>> Does the code describe a9dbc3f12c as v2=2E15=2E0:GIT-VERSION-GEN, or
>>> would it always be <commit>:<path>?
>>
>> As the blob is described using this function:
>>
>> static void process_object(struct object *obj, const char *path, void
>*data)
>> {
>>        struct process_commit_data *pcd =3D data;
>>
>>        if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
>>                reset_revision_walk();
>>                describe_commit(&pcd->current_commit, pcd->dst);
>>                strbuf_addf(pcd->dst, ":%s", path);
>>        }
>> }
>>
>> i=2Ee=2E as `describe_commit()` is used on the commit part, the answer =
to
>your
>> question is: the former=2E I guess that is why Stefan wrote
>`commit-ish`
>> instead of `commit` ;-)
>
>$ =2E/git describe a9dbc3f12c
>warning: reflog of 'HEAD' references pruned commits
>v2=2E15=2E0-7-g980e40477f:GIT-VERSION-GEN
>
>So as noted below, this output is less than ideal, but technically
>correct as
>v2=2E15=2E0-7-g980e40477f contains that blob as well (you don't have thes=
e;
>it is this very series consisting of 7 patches on top of 2=2E15, none of
>them
>touching GIT-VERSION-GEN, hence that blob stays intact=2E)
>
>The way Junio asked, we actually may prefer the commit-ish to give
>that commit that introduced the blob for the first time, i=2Ee=2E add the
>--reverse to the graph walking=2E

I know id prefer the first commit that introduced the blob=2E That's what =
describing a commit does, it finds the oldest tag prior to the commit, whil=
e --contains finds the first tag that contains the commit as an ancestor=2E

Neither of these things is a perfect match for blobs since we want to only=
 find an exact commit that still has that blob=2E I think finding the first=
 commit to introduce a blob is generally more useful=2E Finding the last co=
mmit from some branch before the blob was changed also might be useful but =
I don't know if that's exactly what you implemented here=2E=2E=2E

In either respect, unless it's super easy to implement, going with what yo=
u have now is better than nothing and we can improve it in the future shoul=
d someone wish to take up the work=2E

-Jake
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
