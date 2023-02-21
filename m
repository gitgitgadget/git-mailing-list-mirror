Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24473C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 20:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBUUFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBUUFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 15:05:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA51F907
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:04:55 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p5so2938751pgh.11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeVkfuX1DwRJN5dHCeVbWl+eWXfeBgGkAQ0l//x1JeQ=;
        b=Yy5i+2vGXCRRbka/j/4OaaMYL3663ThMczRFzapLIuUbddofXQ4EQ8uEc3tSCBHygz
         s6SMydApG+vakjS34wuedJiAjs9Z9i8pQRo5jQ4bU8S2lhnid+eir6e8kyfSQJMKFGvp
         k6crDkjaovuN4Wfx1kbV6XYuoAe17npiqIqMKEDfxBIUjcCJthRJJFGEINQ5xhBnHycO
         4MtsaY372UxpRGPx0mFxRT9HFhA6jL3Dc6NiSHg/jVlVqy7y/2DstyC+GnmIcDqXT0hn
         Ds8GsvTj47NW191dDlqtzvIlGMob6g5hljmfLMCxP0a/lB5v/QuGNjLYcMae2D7w8rx3
         se1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OeVkfuX1DwRJN5dHCeVbWl+eWXfeBgGkAQ0l//x1JeQ=;
        b=7F7Yg1WLv+Qk5WvWv6D82Z1gDE7GyEHX89UP9IRie3GpCmdpNs9HOYkoduiwPEO+i/
         b4DwmO3DzibayelhNOP5mMgbAmbnvOPB0Pk/hJ1GuU9N1OuMnegjRDh+TPUhu34UgxNL
         EFRDFAonEKPUO6gdVO1L+fN69XBWJs7O+Mn9RJA0IXXH9TTzilsMlH3LOqyvmaAAb/v+
         Vu4s/+luAXUXnGReRbydpkd/jzx457fZ2mb/zBo9x/dfVEJjK/k9CfrqltMrMC6HV2oI
         nGxpINVKulKzn+GBBo/3yl56gzmOCLNzINtFDuAyAmunt6uxBfjQmgOEUUyObF63cH6Y
         exiw==
X-Gm-Message-State: AO0yUKUzpzmXvICpb28y4LnJPE0JdqQRNIRnnsjdQ6CMD8zmiXF6M9x7
        pgEgzWiJr0aPctGrxzRDTjM=
X-Google-Smtp-Source: AK7set8mNbz2hJkENZeQ+Eri4GCYwNQornx6Qn4L+dEwufND7CgBL9vFVVUSWF0vtRZ79UVTBJmjkw==
X-Received: by 2002:a05:6a00:1da3:b0:5a8:16b7:ce6e with SMTP id z35-20020a056a001da300b005a816b7ce6emr5502752pfw.10.1677009894646;
        Tue, 21 Feb 2023 12:04:54 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 12-20020aa7914c000000b0058837da69edsm2680624pfi.128.2023.02.21.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:04:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ashutosh.pandeyhlr007@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2015-checkout-unborn.sh: changes the style for cd
References: <20230218192128.7963-1-ashutosh.pandeyhlr007@gmail.com>
Date:   Tue, 21 Feb 2023 12:04:54 -0800
In-Reply-To: <20230218192128.7963-1-ashutosh.pandeyhlr007@gmail.com>
        (ashutosh's message of "Sun, 19 Feb 2023 00:51:28 +0530")
Message-ID: <xmqqilfueqe1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ashutosh.pandeyhlr007@gmail.com writes:

> +	(
> +		cd parent &&
> +	 	git init &&
> +	 	echo content >file &&
> +	 	git add file &&
> +	 	git commit -m base

These four lines begin with "HT SP HT"; the space between the
horizontal tabs should be removed.

No need to resend, as "git am --whitespace=fix" already corrected
them.

Thanks.
