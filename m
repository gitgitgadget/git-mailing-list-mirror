Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C82C1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970152AbeCSS5A (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:57:00 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:42320 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970655AbeCSS4v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:56:51 -0400
Received: by mail-oi0-f50.google.com with SMTP id c18so15228932oiy.9
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4v6nRf7PVQzZ5cvBGlC/OjEmEv/nr+TyVJSBoVxcb84=;
        b=Cb5F1fYwZPYmd1OhzIw096ObLWEhJtpDqhXzVyszKMGsQy+lI+N8VmATyXffAZMSNg
         JCogOAcRTgJJvfjNfRl+4wwJrGivPeCqyQ3mgNnoWupGZzL+/yL1ozb3lNMWhDjfFyk7
         68cd4wvA6dFXQlYml4ULFpeaStinI+58FUdJVHGYn4YIqmEkuE3YqolqLlP2/7gzVhlv
         JLMR6ztG6PPyKreZwE4KQOgPA12qi2LjgzZPaZohjQ8mXHUj+OChc73bl/7bgqUdl5KY
         XAr76vMMDJe6jCpFgduwOL5GGVchSKivW/B5dOzJPjd6dZWHWni9DWX57rVJSrLzF3YF
         guMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4v6nRf7PVQzZ5cvBGlC/OjEmEv/nr+TyVJSBoVxcb84=;
        b=punffQC77mx7W48JeV/doE8167MExejBkBMYXFGYQgkNGtrjEtT3YsJPDorboqObfb
         DAgjU1ezlllhbD9qhnZQWLh9WbALMKzinnuMAjQDhpOexf+FStkqTEINi7gnnwz0LCkS
         3p4QZHh6NJXYxQyhHWjXNlUfDCOIcMQprMitMwepEutd2Sl36CSNdX16yflHZIxTXV0V
         9HFDUqCcV3EQdq93g8guLbBPuOnCeVmyapHvWrnfiHKf+Tf27EuNt1clRk0p9yN538zU
         fgiHRAyG0/9CYDPDD9XjqXvOIsVhmMax5rO+cv80Gb1iRWqUUOnFsAVzuUNuH5A3k6aM
         IGoQ==
X-Gm-Message-State: AElRT7FQTNchDVVLdj1EXHcpAW0ybWm/XNU5rrBz4szJLT/DOgIXvlAp
        DvBJW9Pt21tuIz802yuE0wAh6r909A6uMo3crfE=
X-Google-Smtp-Source: AG47ELtoev4t/O6gX/DlGRkRqIFHj5qFBEeaKiiExy6AXSYuWmKaDE0/vUf3GY/p/9Hpr0w4i0NYOTBlyZoSQKTkOLM=
X-Received: by 10.202.64.85 with SMTP id n82mr7943973oia.30.1521485810925;
 Mon, 19 Mar 2018 11:56:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 11:56:20 -0700 (PDT)
In-Reply-To: <20180319110735.56f860f2794c36b1e2e6180c@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-3-pclouds@gmail.com>
 <20180319110735.56f860f2794c36b1e2e6180c@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 19:56:20 +0100
Message-ID: <CACsJy8D3Dn8FeSX9su8edYFM28N-qG2bjNYRpajNWaEi6qdTDQ@mail.gmail.com>
Subject: Re: [PATCH 02/44] repository.c: move env-related setup code back to environment.c
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 7:07 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> -extern void repo_set_gitdir(struct repository *repo, const char *path);
>> +struct set_gitdir_args {
>> +     const char *commondir;
>> +     const char *object_dir;
>> +     const char *graft_file;
>> +     const char *index_file;
>> +};
>> +
>> +extern void repo_set_gitdir(struct repository *repo,
>> +                         const char *root,
>> +                         const struct set_gitdir_args *optional);
>
> Optional: Reading this header file alone makes me think that the 3rd
> argument can be NULL, but it actually can't. I would name it
> "extra_args" and add a comment inside "struct set_gitdir_args"
> explaining (e.g.):
>
>   /*
>    * Any of these fields may be NULL. If so, the name of that directory
>    * is instead derived from the root path of the repository.
>    */

Yeah. I think Eric made the same comment. I'm still (very slowly) in
the process of unifying the repo setup for the main repo and
submodules, which hopefully may kill this function or replace it with
something better. But it's too early to tell. Since this part of the
series has landed in 'next', I'll post a fixup patch soon with your
suggestion.
-- 
Duy
