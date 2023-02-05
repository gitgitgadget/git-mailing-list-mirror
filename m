Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF9C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBEOwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBEOwG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:52:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A51B304
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:52:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so1246843wmp.1
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuW6Zhscs6YkLc8oI97jYU5HO4ejoEL+flzoVEFSaJk=;
        b=qHNu37VRJUmbiMLziyDavlhOeVfASuawCDa3ITdBVl8A4bJKWZM9jzXnr89YC8Xlyr
         Ba8GAHIIbX79C23khePxVcIk+ndS2CL2AmOmAMyqHyy/u3GltkpUlDOwfsV/ZaPakI9z
         Cn/XPlBs9YwM2zXhMpEU85OvyJGUsU67JQGTh0CPHM0soOOHwTGxqYhL83zJJ4qbiXEV
         UGLx7hV4KildfABQIcTeJ96KP1j85kVGTeEUto++rf7vnrz/y8CU2mGQxvtCokevC62r
         XCVLWgdknuprfLmor/vHcU79hjYyWv6MmIcOZ70S3s5Z9ZgdctU6tLdU1SIMGqihqlp1
         MnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuW6Zhscs6YkLc8oI97jYU5HO4ejoEL+flzoVEFSaJk=;
        b=iIWSuMn1jSWxKS8w0yY68WMcQW1b/fXEyciYl07E/6F+caa4Vn/qO/K41nWZKK1CJh
         HK3yK/BUxNqUb82AR7AlrBJJE91ktU9Y2kYlslIqNI+fItvym2SgwGq279AnzdJR17/n
         0bzIapTWj1U5OdFmsupW45b+w1jjvAdmV/CPRBlDY2Ik9X/3F84SGQ+7WMVTn9thGKmy
         258rqx7ZFfe0+FsQIsaTNgstaT34qKADwHLgVh2OumjwlrzLzH4PWMagvNtk1kiSArIQ
         Ef0IrstU+HC19CdUvwqrLYUg8Rl+oSAmvSZvKoVoSs1u8w5PSWSYQE1pb+x5O9AAw/ad
         NZ8A==
X-Gm-Message-State: AO0yUKVcn0SQqb8HqUgvYK5UwSVXmmlxOa2FrmPVSeMSBObszg2zztjX
        ay0o8xakKDFfO7dJVZJI9K9t5eTVLgGgATIk4SuWDNt1mxlI4g==
X-Google-Smtp-Source: AK7set+8jwUDZXKpkYIK8+RSgNcDXowgaAGuimcFpaAmRTuZ9mHwe8+/FpGFd5MNEd668jNv9hWXQPjj8JiiqkP9o38=
X-Received: by 2002:a05:600c:2103:b0:3da:f66c:f18f with SMTP id
 u3-20020a05600c210300b003daf66cf18fmr856968wml.37.1675608724246; Sun, 05 Feb
 2023 06:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com> <20230202171821.10508-5-cheskaqiqi@gmail.com>
 <xmqqsffnsrik.fsf@gitster.g>
In-Reply-To: <xmqqsffnsrik.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Sun, 5 Feb 2023 09:51:52 -0500
Message-ID: <CAMO4yUEfcnmfqBEDBxuLfAqwsxOTAOdmOf4L8VDvNq3-6qaFrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] t4113: indent with tabs
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 4:10 PM Junio C Hamano <gitster@pobox.com> wrote:

> Good, but end the sentence with a full-top with a space after it,
> and start the next sentence with a capital letter.

Sure, think I need to change it to " ...space. Fix..". I will pay more
attention to my English written style.


> This is not wrong per se, but the modern style is to avoid having
> any executable lines outside test_expect_foo.  I'd expect that the
> resulting script begins more like the attached.  [PATCH 4/4] stops
> the conversion in the middle, which leaves funny taste in our mouth.

Thanks, Will avoid having any executable lines outside test_expect_foo.


Overall, thanks for the reply and it is really helpful!
--------------------------------
Shuqi
