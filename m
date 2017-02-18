Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDB0201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbdBRNQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:16:19 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:33660 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdBRNQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:16:10 -0500
Received: by mail-ot0-f178.google.com with SMTP id k4so26337636otc.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qp4DHTgT0LPqhy4oshh4ZHU3WhRGDkeEiGLHSs+JvDw=;
        b=HJ/aFBVne58rErOWhC5jIlzYSGdmYjR89O5VMAzAjjCfK7JcTWw0/TlC0V2X1W40gk
         5hQ98ePxzBXha4Dj8JQW7XH39YiaCLjPX8ckiVDgVy3/Uwf1vvsIvuyQXGGcYV99jq2i
         YGvZ+sf6U0i/5ISH4AhtcGnqkTE4VwuKIfBNUCdCWAt9ogqvO0euY5LjM2X27yamzurl
         QybtqDLTr9Lf1U2KbVsVI/4zqVfF5iFi5iqq9stbH53ZSo4bRzoaN5HGepWsDRlO7cPm
         GeYY4bRUA45ZRbtTr0WuA23WGhmmmNxLKM2qU4GinrKNmELxHfY80EO80+kvcHRVPoKv
         nx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qp4DHTgT0LPqhy4oshh4ZHU3WhRGDkeEiGLHSs+JvDw=;
        b=qEZuG+6OtchSCFM7/tolzwKlBTWVREHK0Ud45bDTFZuDXzD0GYxPKnalLqkS4Nw4In
         +sZ7VbNzmeBlflB4YqnmuXqGsUxVCX4T26EgiYHohtjwOPD6P5qibVZX96iyBa+GMfFJ
         HjjeRXh5r9XzOffuWR2dNxegk69BX1yuZiKWXGuKDkobdFRYI26VeVONyVypmCiO6qoy
         pK8b2xKUMV/QVKdzQu3hOaETbYJLTMWlIfd6k+qlNtQfzgLniroAr7VZVBZGbijhGZR1
         FEKeYuDyHa0856Ith74DHI0Y2hKvIQ7r06SF1yltM6uJwTT3AuTkvzx7Nff7tW+MEprM
         bXbA==
X-Gm-Message-State: AMke39nCCepleXt2kitykWwSDB51CKTh8gqjjYgors4DO5DntIQvjO4Yc09nfJSOYdVNOqsp7jkaEW8TiLagLA==
X-Received: by 10.157.37.39 with SMTP id k36mr506862otb.271.1487423769140;
 Sat, 18 Feb 2017 05:16:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 18 Feb 2017 05:15:38 -0800 (PST)
In-Reply-To: <xmqqzihksm0i.fsf@gitster.mtv.corp.google.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170216114818.6080-1-pclouds@gmail.com>
 <xmqqzihksm0i.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Feb 2017 20:15:38 +0700
Message-ID: <CACsJy8AhVPTLNkW+y+pHDa+FfknR4x4Gj-eksKp4MZEZmNdviw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Remove submodule from files-backend.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2017 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> I'll be sending two more follow-up series, if you are interested, soon:
>>
>> 1) v2 of nd/worktree-gc-protection
>>
>> which kills parse_ref() in worktree.c _and_ set_worktree_head_symref()
>> in files-backend.c. Both are bad things that should not have happened.
>> (PS. The topic name is misleading as this is mostly about eliminating
>> warts, unless Junio intended to combine my second series as well)
>
> Your description sounded that these two are just preparatory step
> for the main one that would soon follow, and that was why these two
> patches landed on a topic named as such without any of its friends
> (which were yet to come).  If you prefer to keep these a separate
> preparatory step from the remainder and have them graduate sooner,
> let's do so, as that is my preference as well.
>
> Rename it "nd/worktree-kill-parse-ref" perhaps?

That's exactly my branch name (minus the nd/)
--=20
Duy
