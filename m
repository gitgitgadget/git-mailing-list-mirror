Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09FD1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbcGLQqb (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:46:31 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35240 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbcGLQqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 12:46:30 -0400
Received: by mail-it0-f44.google.com with SMTP id u186so92246480ita.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 09:46:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TB4FILOSVGmWaAn1Wz3PINEURRtXwZW/O5HpLwailyU=;
        b=VCXtbgQY6To4eHMLJ0h1EGFyuZXoRglV5/jnY2fyf80u62Il1XjMpcFswOg6Mfa+P0
         RjMhwYL8Vz7RsqNB0qDOEoygo5/uccxm3s3OI0T2FyjefqTxIncWdULU24xD4MbtPkZg
         jfeCPo7cAkwZfYwnNEpthauRW/uW5VyHA4uvA65SE83aajeASmdDHRJo50Yi69wgVuz4
         K6+JMVkLMYqn4u3tFPDv92IP7G+gumLlj9jGkd+op/gVEIFNVV3e16Q3p2mJWbfQ0ktD
         jBYktclLYuoeUcnRGhh0N+Tv3re+RqJi52KJKSuiQx6QUTuaBUH8Mt/mG+UaNLdae94k
         2GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TB4FILOSVGmWaAn1Wz3PINEURRtXwZW/O5HpLwailyU=;
        b=EH1Bb8VIILnph6W29AnXFlzqTpSm3Q/hFM673vly/lSdnMBNOun+aK2hIi50Cn/OL+
         KNo75i0MbiqsXcckJUteCZSonA5z9KEXIlqluwphS5xD0Doiaqm3E/yj1bPgj1BIx4BI
         OpmP/dKeKAdAMaNbnFZi6epp32WVsO0R4piMBI4HN/SMSetYcGKSVKp93URDCncVqVFV
         fp1OkTBfJnCDfgPshHa5r4tFfgOSTRx52cIBNecpfMaZVGIBbGWAiiZbHzanU24eFH5/
         Cdeu0S2CJd/FbMiWgcm0qnoU43XeLZsBMl9Z9/W/NPS6lNJO5uMHNZgxoyaGPQjsfcG/
         qPeg==
X-Gm-Message-State: ALyK8tIwQGukoLGElSRTG2FOArcO6eIOjOyfKMYz4qW/nHEJWc/nL9Qf/WhJxtuvdf/mEnQXvQyD6AvRYUChi0X0
X-Received: by 10.36.217.12 with SMTP id p12mr3497065itg.46.1468341988828;
 Tue, 12 Jul 2016 09:46:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 12 Jul 2016 09:46:28 -0700 (PDT)
In-Reply-To: <loom.20160712T131832-33@post.gmane.org>
References: <loom.20160505T140253-275@post.gmane.org> <CAGZ79kYmh9wtzXdThzPTdEZ5SsKznYxze6EvmbaZdGog4yydNA@mail.gmail.com>
 <CAK1enhO-2Ne4XVqRNXz+6Jd7uEEHde8-_xzwWzXh=b01bZhj0g@mail.gmail.com>
 <CAGZ79kYjw6vzf7rf_-bOiMmm0VtAwO03vpk67QP4u2m_N_Mm4g@mail.gmail.com> <loom.20160712T131832-33@post.gmane.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 12 Jul 2016 09:46:28 -0700
Message-ID: <CAGZ79ka7wRk3ksf52fHDLccvYJR3DHjnH=CB+8uobe8aKiexvg@mail.gmail.com>
Subject: Re: Submodule's .git file contains absolute path when created using
 'git clone --recursive'
To:	=?UTF-8?B?UmljYXJkbyBTw6FuY2hlei1Tw6Fleg==?= 
	<rsanchez.saez@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 4:22 AM, Ricardo Sánchez-Sáez
<rsanchez.saez@gmail.com> wrote:
> Stefan Beller <sbeller <at> google.com> writes:
>
> Hi,
>
> sorry to awake an old thread. Has this been fixed? In which git version?
> It's hitting me on git version  2.7.4 (Apple Git-66) (default git client on
>  OS X 10.11.5 (15F34)).
>
> I think all submodule .git files should contain relative paths. Otherwise,
>  duplicating or moving the cloned  repository folder breaks the submodules.
>
> Best,
> Ricardo
>

The commit I referenced earlier:

$ git tag --contains f8eaa0ba98b3bd9cb9035eba184a2d9806d30b27
v2.8.3
v2.8.4
v2.9.0
v2.9.0-rc0
v2.9.0-rc1
v2.9.0-rc2
v2.9.1
