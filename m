Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56A41F404
	for <e@80x24.org>; Tue, 20 Mar 2018 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeCTVrQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 17:47:16 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42549 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCTVrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 17:47:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id b198so3404419qkg.9
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ienZPOu/AwQLDX/OYN3IFuqmElu+YxwK0XENvOgosn0=;
        b=A05KdW8FmehfPKrHlrd3BOqC+Ro7MuS5Xp1jpzaHhetUcaBga2BPGE3/vrfCZs7SEa
         kLM95IiDMoIrVCx4382IlQfYdysFn+CLh+ZMEqycbMKBh2tAG127dpVPDdtu2ctIm+PV
         tvaAGIiswOMKU9d/PPNQSvfQV9I938/BiiGdQE9AsemKnB49TXDE6G9LxTYokEVwSkvy
         rW2GaKNXsARfbM1u+Vt7WdUP/w8YMxGtdy84TmYF6DB/KxMH6TqqX2SoghcMYXER/wWe
         7+1auhfMbpaH+TB2f3XHjzgtsNvw1m0qjXy2RpLriGylIvB6fysnBVf4otqio+j/K/Zk
         ssnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ienZPOu/AwQLDX/OYN3IFuqmElu+YxwK0XENvOgosn0=;
        b=I1ik85nSEHqNTPpdsPwv4cJvsCLzNYKtJfgpyoPl1HKxEvCbNXkbIcZwnIMy4fkYSh
         UmWxLieIuVAtUOWw47rtKHV3Dfr3JH/7/6h0pWHHZZTbKMlWb0VaZ401xjwpV9KY95DQ
         rF54kFs8Lgd/6nTt/VD/8S3qqPvtn6VSYxpzgAUDgszUOwg+pVyakquBu/l6SNbYAltg
         E/sAG/Z1enzxWYkItX0qeuWlGvxC7jzcIBKMP1ZGson9sB8IHL8h0BA9hjXSK3nLM+e5
         kKOT+FU5c7IaFSpPVwFhb8HrSaIq0qJ7E1JstfYbo9E4u3WHO/tuWXCzHDUEZuzo2LYS
         YG0A==
X-Gm-Message-State: AElRT7G/PPgzVn3kdS7P2XwfYNPAdWEznca2qy/OHQXKLMexpXlTT/3n
        DAqrw6CfK94T9hCQwRvlGq12WFzZFEFj7T3i/8g=
X-Google-Smtp-Source: AG47ELtteBZLV2o2t5HgFDWACqgvBgIgRuI5tJ9DL/fHKhj8rltS2cSfWf3j3GsQC0BaY8665elfAKYeB4t5UuC3gC4=
X-Received: by 10.55.120.66 with SMTP id t63mr25671965qkc.42.1521582434904;
 Tue, 20 Mar 2018 14:47:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 14:47:14 -0700 (PDT)
In-Reply-To: <CAKk8ispSvaAr3iRhC4X+gufeKm20AQzw9_mvuysT7SiDsZQYJw@mail.gmail.com>
References: <20180320204507.12623-1-wink@saville.com> <CAPig+cRw4MSfcKJcgT-srCE7sDYi3qA0TrNApXBDBsgodVb3Pg@mail.gmail.com>
 <CAKk8ispSvaAr3iRhC4X+gufeKm20AQzw9_mvuysT7SiDsZQYJw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 17:47:14 -0400
X-Google-Sender-Auth: iaDD2YUJe5Aawd4TTwRjdH1z-Kk
Message-ID: <CAPig+cSvvg=hXjXLKM2yYqqy=q+z_T_TVkuUJe0W=R_494CMkA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] rebase-interactive
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 5:23 PM, Wink Saville <wink@saville.com> wrote:
> On Tue, Mar 20, 2018 at 2:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> A problem with this approach is that it loses "blame" information. A
>> git-blame of git-rebase--interactive--lib.sh shows all code in that
>> file as having arisen spontaneously from thin air; it is unable to
>> trace its real history. It would be much better to actually _move_
>> code to the new file (and update callers if necessary), which would
>> preserve provenance.
>>
>> Ideally, patches which move code around should do so verbatim (or at
>> least as close to verbatim as possible) to ease review burden.
>> Sometimes changes to code are needed to make it relocatable before
>> movement, in which case those changes should be made as separate
>> preparatory patches, again to ease review.
>>
>> As it is, without detailed spelunking, it is not immediately clear to
>> a reviewer which functions in git-rebase--interactive--lib.sh are
>> newly written, and which are merely moved (or moved and edited) from
>> git-rebase--interactive.sh. This shortcoming suggests that the patch
>> series could be re-worked to do the refactoring in a more piecemeal
>> fashion which more clearly holds the hands of those trying to
>> understand the changes. (For instance, one or more preparatory patches
>> may be needed to make the code relocatable, followed by verbatim code
>> relocation, possibly iterating these steps if some changes depend upon
>> earlier changes, etc.)
>
> Must all intermediate commits continue build and pass tests?

Yes, not just because it is good hygiene, but also because it
preserves git-bisect'ability.
