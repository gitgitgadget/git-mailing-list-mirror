Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00FC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 06:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C356113D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 06:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhI0Ge1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhI0Ge1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 02:34:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35FAC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 23:32:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so10862782pjb.1
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wZPXaB5wkbvc3YYbtlNorfGu977S5jaKUlfve/yV06k=;
        b=WaFqPXDRLksXr+OtIPnDEq+06ATUVKPLuTehsQDWaz+NRYxzfh6m7DPPBu71i8Kk1c
         DrQaMcY1U4jksqd2oIrmCk9NFQrFcg4q/w4jnIFhPrILdynHANqkOtw0eGY5sxknsuJu
         dWIIZd4WO0uxcRS5MCbh4pjLKdoJ4TCFPrCeVjjp2xHbOFJ9r+AxlcaCoJpNV8+q4cC2
         +8SDfM4Zh8qYkQqSlyUiw43LOgPu7sfEDTnO7YNcTLwRljp7QGAo05qRyMl3/kYZ/bVo
         /eMZkUNqHjAWcJgGqJKN+j4JBLECuv4U3+Cq5QqI/M3AvWntsb2vbxTeKqCt73FUkPcN
         A30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZPXaB5wkbvc3YYbtlNorfGu977S5jaKUlfve/yV06k=;
        b=XwiLv3j4T7tCvaXN1VPN6+OUmFN3sz/vWaGE9lMcamruiHqEKTXM0FQ4OO6Ux9fi3Y
         oc+6BsD95kkBHjjjfJYEjlSil2f9Tw+fBFVvYwPW6Th9M51jo4Wv8mDHfZa3N6oguY+2
         rYl+wL124XmhJkHaZhcm65BDy3TYcj2VHoshhaj+/qU0uKP8WyIm8ZVQpxnRq2GrDJ2M
         zPTPHz8+oS0Fvp/pkOnpx0nrjn8Rr3cHIkounSvQLxojqkwUEjNfrtmFMOd91Hy3i1uF
         GSEhRq+2fL2FW6pNO+AqPK5kErY87YYlUrQmgmOH+QAi/T/RsXo1thKBCh18UkALj6cF
         XXwQ==
X-Gm-Message-State: AOAM533xsMQq3LUKcHv8hN8ZL0G+8Ftnp791TxktPMhy2YyD+1oHnLGa
        cMtyg8JTD7Yow44MuZ8sxFCP3/ydiAb0dQ==
X-Google-Smtp-Source: ABdhPJw3jdYNHRaKlql5rISidl3k6qkPeYgU53S2m6kvsHx2pU4pHsOuTV1fyRrKOn0s2p3zobLOEQ==
X-Received: by 2002:a17:90a:540a:: with SMTP id z10mr11508915pjh.115.1632724368897;
        Sun, 26 Sep 2021 23:32:48 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id 23sm17349544pgk.89.2021.09.26.23.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 23:32:48 -0700 (PDT)
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Sashank Bandi <bandi.rao999@gmail.com>, git@vger.kernel.org
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
Date:   Mon, 27 Sep 2021 13:32:43 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/21 22.09, Sashank Bandi wrote:
> Hello,
> 
> I am new to the concept of mailing lists so please bear with me.
> 
> I'm a JS developer. I love Git GUI for its minimalism in both size and
> layout. I have been using Git and Git GUI on Windows for a long time.
> I think the only thing missing from the "Official" Git GUI is dark
> mode.
> 
> I use dark mode on almost all places. Firefox, Discord, GitHub,
> Outlook, Notepad++, VS Code and even Reddit too. The only place that
> is missing dark mode in my workflow is Git GUI.
> 
> Is there any way I can make Git GUI dark mode ?
> 
> I don't know a lot of Tcl/Tk but I am currently trying to learn it. I
> did a few edits and made the About page in dark mode.
> You can look at it here:
> https://user-images.githubusercontent.com/76554862/134190271-d861407a-31be-436d-aac4-9ea3d72f0fb0.png
> .
> 
> I have found two threads in the mailing list but those are just dead
> ends for me. Hence I reached this mailing list.
> 

I would rather like to see yourself posted PR to the dedicated subsytem 
at [1].

I think you want to implement tri-state `Dark mode` option. When it is 
set to `Yes`, always use dark theme regardless of system settings; when 
it is `No` the opposite; and `Auto` use dark theme when it is enabled in 
system settings, normal the opposite.

[1]: https://github.com/prati0100/git-gui.git

-- 
An old man doll... just what I always wanted! - Clara
