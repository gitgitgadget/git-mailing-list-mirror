Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF771F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfFTKgT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:36:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37711 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfFTKgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:36:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so1230410plb.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEjS81C0NVWuvDAynhalKT6bHs1xbQ0hXDvWGtnWZpA=;
        b=LLwcX7gfPTgfZrMRa4mQ7IO9lLN2p5do6lpWnR+3g3DJeUgL27bemJEqph3ps7VeMJ
         +2EIW3ZkWNcHWym7+a9LsRdU4ebDZhgfAgWm3wLm7N65HV92iPbAskITsb9fhGVeCAAR
         HmK+axAnNs9RDyIO2npAJdxbj2hHVc0OTKF+eUDXo731dJ1iJNo/ReiEYh/lB4qwhqYz
         v3SgWtz90+CxAA0XI2EndEPCpl3f6u0yFq2qs5msESueCT0YxWxjHHDnSJz8htTChEcL
         ilYVTfypsEJsA0PRt5sIk4uYvMYv5KAFLA9wpr/pCYZS7zwSREIRHJbVCc8uzmV20+X1
         XhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEjS81C0NVWuvDAynhalKT6bHs1xbQ0hXDvWGtnWZpA=;
        b=PFlNbpbzMcIQQAFPzHlwOCUTyaelHfLwfy5QnS62AT3tlGWz/IuU72DYzQ86a3jefH
         m76ZtNT1sbQy8huF5r3knvWFF6lo8ir7Y5cD1MmdIOlKjxtagCeh/ckfpe8f3IFlXR/R
         +nzZg7p8e0hjGaTjcQaRaARwbywbT3HLQ5jMFusZ4e+PYA4ylz4cjSF3kpxHq7nDMB9i
         2xfyyrmdlD4IdbYviI47GeCykr6sayaxdn7gt79dyOhkyNyCiXLATZXaGeR0VF3jIHou
         PZv1azCRhsCgfZqchOR2zW1FPyT3G/vqZvmiPuZQGZpc7G/NMZi1H0DNX0c7mfitUWEk
         /Dvw==
X-Gm-Message-State: APjAAAVSk6Fk+ba4HA8jGvLSft3tznOy4fNqBhYVrtjmEN6/GprsQn6D
        cmTbgifUY+xD1fiPkbpTLPA=
X-Google-Smtp-Source: APXvYqzAc8mjQTbgJr9COCbNcMKZghAb5oi7/gDX95tt4bJVvQslLoS6RAykD3BjBdwgkziGZtIYtg==
X-Received: by 2002:a17:902:7297:: with SMTP id d23mr111260057pll.254.1561026978140;
        Thu, 20 Jun 2019 03:36:18 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id u128sm5383061pfu.26.2019.06.20.03.36.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:36:17 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood@dunelm.org.uk, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
Date:   Thu, 20 Jun 2019 16:04:01 +0530
Message-Id: <20190620103401.29654-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <0047b8c6-8a58-7546-2ae8-19c4ab668fa3@gmail.com>
References: <0047b8c6-8a58-7546-2ae8-19c4ab668fa3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2019-06-20 10:02 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> > +test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
> > +	pristine_detach initial &&
> > +	git rm --cached unrelated &&
> > +	git commit -m "untrack unrelated" &&
> > +	test_must_fail git cherry-pick initial base &&
> > +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
> > +	git cherry-pick --skip
>
> If you change this to --continue rather than --skip the test also
> passes! I think we could fix this by checking if HEAD has changed if
> CHERRY_PICK_HEAD/REVERT_HEAD is missing and not dropping the last
> command in the todo list in that case when we continue.

I don't think I fully understood this. At this point --skip is essentially
--continue. How is checking unmoved HEAD and unchanged todo uniquely related
to --skip flag (or for that matter any _flag_)?

Thanks
Rohit

