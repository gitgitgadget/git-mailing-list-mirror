Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A5B1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 14:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbcFYOoX (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 10:44:23 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37153 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcFYOoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 10:44:23 -0400
Received: by mail-it0-f42.google.com with SMTP id f6so33805184ith.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 07:44:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AOetkjaIET2AguFZc31qmfn0WoZ4RGSMIF5kheqaW9E=;
        b=Cq9fN11yzCmKqHmuW3ixP6TvudxNIxlqO/PXqE/nmD5o56Lb9vyD06wFLRTcCFxvqE
         RW0i8Qisqa5NG/dEf7t0PMFtKIrkfrAX1PhjlbSh9qm5lw7yrBpzD08pXCqJsUNv/YV0
         O6vmOD4CVjpoeeAbVB99I2T1mV1ZiuUaYh/JrHainhSdUglzbmqPtKz0PrKMUAf0AYM6
         ehlyIymLgOerjPpnzyjPmnGdgqyH0KufT0nVpeBRiF5qHfBwUO2FqgZkmWVzY+6xtT3w
         pe0kVyGrAsYA9GoBcCF6+IYoTVm4EZbeJSgsWJ0wfrKyhdrom3D45EqJP6fZ77vSB920
         FwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AOetkjaIET2AguFZc31qmfn0WoZ4RGSMIF5kheqaW9E=;
        b=j0YoD73fskmfn524M7KgumZKpfDOBXTB2Qzim+wVyx3gCaGRWenRHzalOMIhdKFSlA
         3ho8l/mRf60TfO3zHJlMwItPPxM7KG5vzzdSauiXM3WCe5OAzZLR1jVbejdiHxorrJnU
         XE3+OZeraXKj3pFHbqZI2N8aYIITzR54A9OarErYcHWCl5hCVefRWWTGIWZHWhzLQtGe
         0ndnGGoIDXk0VteLuVMhVRiwyv7+nvfNB0jegcPiQsnIIX2dR5GV+hoXRcts7srXFtwU
         fHD99//eCIMTN6A38LavtjrZEGRg1y0/t4aghmE3ptUgN/RgTQKxsSyNPy69Gl1V6eYC
         QiGA==
X-Gm-Message-State: ALyK8tJjJTO8rcZ71OecS5H6zauc/hxZzijM311ViWaLQoa+T1SlZA9EsymPLQvXi7fQLbtLoxd/mMU0B2GOeA==
X-Received: by 10.36.130.130 with SMTP id t124mr2541247itd.42.1466865862346;
 Sat, 25 Jun 2016 07:44:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 07:43:52 -0700 (PDT)
In-Reply-To: <1463694357-6503-6-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-6-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 16:43:52 +0200
Message-ID: <CACsJy8BbfjoyTpgB6+rgHW-HORjs20KLP-gU2q19Od1HgjkYcA@mail.gmail.com>
Subject: Re: [PATCH v12 05/20] index-helper: add --strict
To:	David Turner <dturner@twopensource.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> +--strict::
> +--no-strict::
> +       Strict mode makes index-helper verify the shared memory after
> +       it's created. If the result does not match what's read from
> +       $GIT_DIR/index, the shared memory is destroyed. This makes
> +       index-helper take more than double the amount of time required
> +       for reading an index, but because it will happen in the
> +       background, it's not noticable.

Slightly off-topic, but for big indexes, running by a script or
something, then the window for reading/verifying is not big and this
strict verification will become noticable.

>  `--strict` is enabled by default.

.. so we probably still want --strict by default for now. After this
feature exits the experimental stage, we can switch it off.
-- 
Duy
