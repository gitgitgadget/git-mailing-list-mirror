Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8781F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdBBUV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 15:21:57 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33702 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdBBUV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 15:21:56 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so2705572pgd.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 12:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OFhLEubb31iQ8dcFair8KzeAnvZoULU42KyL0bCUVAc=;
        b=E3LuFbzYh2ooTNHDH2uq5XoRMBn4pgTlYbt6Rz/GithJ7tFRWz4pBD4zqQsyHMak2m
         5H7fCpwuGdkiWxP0f/n6IK8Ebv0nKcbGKMnEGyK9FgsPialX1eZ0fUQNEs9lYBt7CtIm
         oQSlvJbN1c6g/OjZj25UaRCl0+X4X/HaR6j3IAFm8AN/GVhDxH1MV/OJgJLjv9x59kMs
         8i1xN/ZSFv8sxQRV2Rxgeki9M2qgfBE/vGrv+8KWRFtdaR1NNiG5gyot1hSY934D/kGr
         hZQT0sR+6r5LCiWNMTjyT+snd5dsZ8QzXWOZ5njCUfoxmk94J3zdJd82IRLTSeY34Jhz
         D0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OFhLEubb31iQ8dcFair8KzeAnvZoULU42KyL0bCUVAc=;
        b=k1F7PNVL0vrDFLEujWt7Q+0/4jbihMTCpbpvWX/WfVa+jQNT6x01BkydDTm0NJpvv/
         dTNudY0t58cfC5WaJWjS7dgogF/3Ce+yZmUrR/OMMqqutKxxzKqdfPwYBdc7ZAvD6GYC
         hmSAFyPhjm4O/p4BZ0NNI9JXi1dHpgUTq7xg7Ib6+wYdW+FuC4oWgRl+z4zCrnQiBe6A
         8tkSwOGB6nGUkRhpLdG4pVFP8XQ2dnEaXNc+sh3NvozMrc7Ye4qn263/G4VBgePdO12t
         tKFKlyhmtSfw83LffwwozuhIdnqkF6MSKJ/d28XGJVEsUvwpGaG/TM0EJOY/4HFAm73/
         1QVg==
X-Gm-Message-State: AIkVDXKStdrQduJcwB0foPtIXYtDuAooIe0ouUulFYRkaAdoFDAmnLrcWZH5z7AiMpnoLQ==
X-Received: by 10.98.87.142 with SMTP id i14mr12941666pfj.85.1486066916163;
        Thu, 02 Feb 2017 12:21:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:358d:de5e:fbec:baab])
        by smtp.gmail.com with ESMTPSA id u29sm60775754pfl.17.2017.02.02.12.21.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 12:21:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] nd/worktree-move update
References: <20170202085007.21418-1-pclouds@gmail.com>
        <alpine.DEB.2.20.1702021015160.3496@virtualbox>
        <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
        <alpine.DEB.2.20.1702021043110.3496@virtualbox>
        <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
        <alpine.DEB.2.20.1702021136210.3496@virtualbox>
        <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
        <alpine.DEB.2.20.1702021223320.3496@virtualbox>
        <alpine.DEB.2.20.1702021330040.3496@virtualbox>
Date:   Thu, 02 Feb 2017 12:21:53 -0800
In-Reply-To: <alpine.DEB.2.20.1702021330040.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 2 Feb 2017 13:33:38 +0100 (CET)")
Message-ID: <xmqqmve4s5r2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, the more important reply was Peff's reply that suggested that the
> proposed fix was incomplete, as it misses --unpack-unreachable:
> https://public-inbox.org/git/20160601160143.GA9219@sigill.intra.peff.net/

While I think that --unpack-unreachable thing is a symptom of the
basic approach of patching things up at the wrong level, if you are
hinting that fix to the issue that gc does not pay attention to
various anchoring point in other worktrees is more important than
adding new commands to "worktree", I fully agree with that.  

We have a basic structure of "worktree" working well enough to allow
adventurous folks to experiment (there is a reason why we keep
calling it experimental).  mv and other additions are primarily to
make things _easier_ to use, but we shouldn't be encouraging its use
to general public by making it easier for them to hurt themselves,
if we know there still are sharp edges.

Thanks for bringing it up.
