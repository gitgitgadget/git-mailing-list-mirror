Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73682027B
	for <e@80x24.org>; Wed, 17 May 2017 13:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbdEQNk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:40:29 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33881 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbdEQNk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:40:29 -0400
Received: by mail-vk0-f53.google.com with SMTP id y190so6737953vkc.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xJ4rqJE9qvbuBo3ajCdJnVuMFNmMDG9USOMLHPDELYc=;
        b=tPoAkOEHYxz6HJ3udllV8xaPevjr7CReJlIve/FasDAqmXXVgmaWnoWFrWRDBBt1nc
         z2PEaSNxDcRTYTueWdNfsQU/pS5p6unYIo86OvmbVHCui4x6aJtnk6kfrYoTRPVRGaJk
         jkf4kHCy6CmZ7esVsIB7ONnp+14azKdPX/O7yqclXRr8KqVn4HNU1xUDLh06kUFz5dHE
         NyNYcbqXD5LSdBB+ELDdcup/Ev1YMn+1ILbOkOLzwhfUWVSNVeGCp6Opfrkft6eTmPNG
         xN6wcvMFFk437kHehAvanVR6Y5UkZimwwRisBObj6hHKwrfgig9nOggR815yxiblhfvP
         zWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xJ4rqJE9qvbuBo3ajCdJnVuMFNmMDG9USOMLHPDELYc=;
        b=cnC+/FV7BPXaHej/YGhaJtM9lEKhrrEHpR5gE34vRc/9Fq+fGoFVgauVEFmVHVacW0
         9laPqh8hirbZcQC06iBYwEPPda/4+ZZqLkNH3kEsDktNcZ45LqS5iuRxKG7JXFG9era9
         QZ+PgrnriR+Wa89l8Zwiu+0NxqtU9JQeMa548auV0LtaQ3k/8Cz3w/UXiXZf0hFqEOqB
         /DzLIusfxNgMQUhVi117YWHx90J92po3Yipy1GrF4LLLa004ICHxUSkiamTSNHu1ggZw
         Cgj2QHAySspJ/ZAj4vu25fSK3ov2Lj5umdPRCiimO1E0lCNm3huOSXPefN8MRQPSvsLn
         koiA==
X-Gm-Message-State: AODbwcAX5jSaq4256SkS+AGUsUmQN6U3fN3FwXUSFAdoT6IOHdf0a3PU
        12sex9IgXfxOLGRQmBoartMvYiXnnQ==
X-Received: by 10.31.238.143 with SMTP id m137mr1345005vkh.109.1495028428282;
 Wed, 17 May 2017 06:40:28 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.163 with HTTP; Wed, 17 May 2017 06:40:27 -0700 (PDT)
In-Reply-To: <CAHd499DNa1zFm+ktWJb-4Rp09DjSc+p4HMqoHiXDj57muwxukw@mail.gmail.com>
References: <CAHd499ADTbO09OJhH_wWBbAcXZeLRLFAqOw5eTe6=abN-JUrUA@mail.gmail.com>
 <xmqq37c4yzb3.fsf@gitster.mtv.corp.google.com> <CAHd499DNa1zFm+ktWJb-4Rp09DjSc+p4HMqoHiXDj57muwxukw@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 17 May 2017 08:40:27 -0500
X-Google-Sender-Auth: _o94CYFGUR0FJ8UmCQjCi-KghGI
Message-ID: <CAHd499D5WiXfTXCx+Mzg5Mt+L0_pOKVgSuasFOew4QiZ5DGv-A@mail.gmail.com>
Subject: Re: Diff topic branch + working copy changes?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 8:39 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Thanks Junio, I forgot about merge-base. I'll create some aliases for now:
>
>     # Diff Branch
>     db = "!f() { : git diff ; git diff $(git merge-base @{upstream}
> HEAD) ; }; f"
>
>     # Diff Tool Branch
>     dtb = "!f() { : git diff ; git difftool -d $(git merge-base
> @{upstream} HEAD) ; }; f"
>
> Since I use push.default = current, I always keep my upstream set to
> the parent branch (origin/master, origin/release/1.2.3, etc). So in my
> case these aliases work, but probably not for other push.default
> settings like 'upstream'.

Correction: settings like 'simple'

> Would be nice in the future to have another revision specification
> like @{wc} for "HEAD + working copy". I guess this technically isn't a
> revision, but something along those lines. Or maybe just an
> --include-wc for diff or something.
>
> Thanks again!!
