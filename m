Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38ABD20966
	for <e@80x24.org>; Sun,  2 Apr 2017 13:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdDBNS6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 09:18:58 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33706 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdDBNS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 09:18:57 -0400
Received: by mail-pg0-f44.google.com with SMTP id x125so97947627pgb.0
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gc9XIw9p4Gx7Tn5ZRjtLcy3jk73wYXwVoIW10kpwaoM=;
        b=Bpy+LbxlcY7Z3GBatepDnk0f7XeOb8it2qrGuX+km/EhuzoO9PTTXYh8idMatiCur+
         5tTwmaLa9scCvawd9dUsP+vS076IIakuJKbB21uy/r20FkmuMeiHDk2ismq+pEmd+Uhe
         F77SBIeUQE18ElL45tTvTpdQDZNcSCF77RGDC1W0iFn+NSP6wYF2hxZGEznX9at7CjGO
         JelZ3MWKVYcOiXLrvHihUyGM0Ia1sueZBqkQOCMg2DdT54mGAiYAvO6UyumwMzd5F+lt
         aWKP0wRde1MCE4MzOzC6a5eVk2N3sgEkiMHsDDlGBj3sBszqh8LOqeqzvqnfDFTq1NLN
         hSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gc9XIw9p4Gx7Tn5ZRjtLcy3jk73wYXwVoIW10kpwaoM=;
        b=uFECABuOA/LLeLKYfrrEaxVB7lhiJUJezJlWoR/iBN8X7ZiAEMT2ZvIB4x2mWcpHFi
         t/DgPEHr+Bx4acIoHq+qKUkFN27hgmNuBYMRd3qAeIcWUUvQ0jmfuYCxgQS+YKXOUlW5
         XQBrEj5DUSnsPBWxgGSGCKTMWkSx3T7iwp10+KgJRyncFYoIfU0d3xKypKB4RJIld2Zn
         ltiOCBqQsD1E55OXXmOV14xezcfsrAnxR44iEESTUWhXGQQteeskgXdCSL6wpudFPfHq
         Llyb1QRy4HpZ/zcaeQ0yKxIACSa20Bt9lt4SYa8KKtg5OALIUjTLrPboG/N0cWxIzWQP
         k0EA==
X-Gm-Message-State: AFeK/H12txDynO4cYHEqZTRUoE/NBdGv/KJTYSXkJHNVQV5+ZkfMGN2eQXH2g+8xoPwoBm181Kth4ruS07Y5Xg==
X-Received: by 10.98.41.199 with SMTP id p190mr6760176pfp.266.1491139137139;
 Sun, 02 Apr 2017 06:18:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.15 with HTTP; Sun, 2 Apr 2017 06:18:56 -0700 (PDT)
In-Reply-To: <xmqqlgrjtrjl.fsf@gitster.mtv.corp.google.com>
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
 <20170401153049.21400-2-robert.stanca7@gmail.com> <xmqqtw68szz1.fsf@gitster.mtv.corp.google.com>
 <CAJYcaSNAB+1gth2NkTjrcBV9TXT9bRsBQhwOsQCmnudYz5bTmg@mail.gmail.com> <xmqqlgrjtrjl.fsf@gitster.mtv.corp.google.com>
From:   Robert Stanca <robert.stanca7@gmail.com>
Date:   Sun, 2 Apr 2017 16:18:56 +0300
Message-ID: <CAJYcaSNJ0un1RgM3DNX=EOez5zP=Rko+BUt5SMeyBTb20K21oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] show_bisect_vars(): Use unsigned int instead
 of signed int for flags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One more quesestion regarding flags used in structures :
for example: update_callback_data has a flags field (type int) ,
in function void update_callback()  the field flags of that structure
is used as param for add_file_to_index(..., data->flags)
and this function is define as: int add_file_to_index(..., int flags)
in read-cache.c
The question is : If the flags field of the structure is used in
function calls should i update flags that deep?(there are other
cases where the field is used in nested calls )

On Sun, Apr 2, 2017 at 6:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Stanca <robert.stanca7@gmail.com> writes:
>
>> I am used to 1change per patch so it's easier  to redo specific
>> patches...if there are small changes(10 lines max) can i send them as
>> 1 patch?
>
> It's not number of lines.  One line per patch does not make sense if
> you need to make corresponding changes to two places, one line each,
> in order to make the end result consistent.  If you change a type of
> a structure field, and that field is assigned to a variable
> somewhere, you would change the type of both that field and the
> variable that receives its value at the same time in a single
> commit, as that would be the logical unit of a smallest change that
> still makes sense (i.e. either half of that change alone would not
> make sense).
>
>
>
