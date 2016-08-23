Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19202018E
	for <e@80x24.org>; Tue, 23 Aug 2016 21:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756056AbcHWVf4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:35:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34466 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbcHWVfx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:35:53 -0400
Received: by mail-yb0-f194.google.com with SMTP id g67so4131493ybi.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=wyqNADvLJuDSSwlVrmrD0RcDlpp+sPu8wxVW9FWO+Qw=;
        b=GRpWG71w789UxsjafIhLKZScE8ONfo2DlJEdd+1Be9G7U+RyUCBoIPtCH7WGgRkwGX
         YaEQHDqmjH9nhCT3xfTyxqeg15Li4KGLtOS/yqZZIz3IFltk2H9yvfYroSkRSEb95S/4
         CV906XkuGaOFAfv6MB06wfkO0vrc90WRvC55m3Vv2zU6g8v/nUnF8E8aeCkhTOBjJXAD
         y6AzVLVAGb+q2YUH+XP04ufZkjztJnJn+Vn0C7uYBywR0Id2HlCz6lOBQ5AvcfeiQa5R
         F0bnSZeyUvlBMqVAUaSCFb2S0+iWCzsbYNtRNUc3Ls03+R1qn5Xznhdoma8v5g2GC+I+
         q3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=wyqNADvLJuDSSwlVrmrD0RcDlpp+sPu8wxVW9FWO+Qw=;
        b=TuEolsZvqL0JtCap40ETYUYpZ56Yd4GudNT5uvmYO9gJLJwSl8NEv/omqqq3Q4Cd2/
         3mSaPFdgE/hTXK9QXKg1kwSscviL3lGUjhKYogfSL1/vqwnQp3hcHBbUYknh7A+HsqqS
         htdeU96mgvuCViyjkwtkhtL4vxw3F7J7aeodkqj7Yd25eeB62VNnYxyQvykzMEDp6NI0
         ZIizY50HQcNdarBzD0S6L8kfvdKBv3oMuGGmN5V7kSwkpiwGbzKQMDhCLoUToJYl6qpj
         JuWzigQzJB3B0nQi/oXtU9gnSKMpIZdSnqtLI7Y2A3AbgoMfoQ9EwlkemmYEy+/ItXXY
         4CRw==
X-Gm-Message-State: AEkoouuiu6KyousKMmU4fkkgGKAJLvQNx162bNPOX672edbPNd9ymzBPbYl6+s4tnJ5mJ7i4n2ERtSs3O44elA==
X-Received: by 10.37.162.42 with SMTP id b39mr15110514ybi.53.1471987453265;
 Tue, 23 Aug 2016 14:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Tue, 23 Aug 2016 14:24:12 -0700 (PDT)
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156a48144f8-c0e127c1-8cd9-4295-ac16-449a54315cac-000000@eu-west-1.amazonses.com>
 <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 24 Aug 2016 02:54:12 +0530
Message-ID: <CAFZEwPM6hDbiEVMbe_FakME4h_RNCopyzFcVLsF1PB=V=OheOA@mail.gmail.com>
Subject: Re: [PATCH v14 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

Sending a "cover letter" to this series.

Changes with wrt v12[1] are:

 * Rebased on v2.10-rc0
 * Two function signatures had changed while the topic
    develop so changed those.
 * Correct the "mark for translation" messages properly as
    I had previously used N_() in some places but I had to
    actually use _().
 * In the patch 04/27[2], bisect_clean_state() is put in bisect.c
   rather than builtin/bisect--helper.c because I will need it
   further when porting bisect_next() function.
 * The patches from 14th are completely new to the series.
    They port even more functions and remove some then unused
    subcommands.
 * 14th patch[3] is a tricky one as it changes a lot of things. I am
    not sure whether to put this all in one patch or split it.

[1]: http://public-inbox.org/git/010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com/
[2]: http://public-inbox.org/git/01020156b73fe66f-bfad6316-39d4-4577-8f75-d1b4b2031263-000000@eu-west-1.amazonses.com/
[3]: http://public-inbox.org/git/01020156b73fe6ce-3b204354-849b-40fd-93ff-2ebcf77df91c-000000@eu-west-1.amazonses.com/

Regards,
Pranit Bauva
