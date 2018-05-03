Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9585200B9
	for <e@80x24.org>; Thu,  3 May 2018 04:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeECEz6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 00:55:58 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:55024 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeECEz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 00:55:58 -0400
Received: by mail-wm0-f43.google.com with SMTP id f6so26113541wmc.4
        for <git@vger.kernel.org>; Wed, 02 May 2018 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rtny2oaGMIp9CnWDOQ17SwUTkkjuzncBd0FWqXRyZ+w=;
        b=bQJwIEau4zbwIuylNRcuQXH/sx09wJyftDi6aH0uea5e3u1QvN1udREfSxnPFz+KO1
         oSsjSswll5K1J3kZHjiIm4n0BH5GpIxenG83YSEpVQFTN+pRb93jzGHptKq3IUPd3Naj
         IWODu4LNS8o3A/4wVYpOd/j9X3es19p8zUkameQNXhfKLVqjo6c//LbqVgb6T2i23b69
         1biScx7MQz54FY/Fco+HfjP7ygPufFwof6c47uNyassSC/Ap3524vbpx3ML7xiApf5Pb
         rPqRQ/MtFnGQHt8SUW5kYNzpELBB3bXXObMNOjIMasOlqGrQmN4uYQClRmRBNLAoHNXl
         +6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rtny2oaGMIp9CnWDOQ17SwUTkkjuzncBd0FWqXRyZ+w=;
        b=ATT6JR02T9x9cf4HtvRwpwN8SpVUtNJ2qsx7jGrenX+sZh6dDFEFYqDGxoQ9ImQr6S
         cYFFzu2MoUiVgPdhF3ZUiX/xvo9NXlx7UI2srKsE8ZGJcTIoQ2dkTdFb1EPGjsslSpda
         Q+78nNXYqhdRHMUsrxuxN6xB3f0ELmYWEy+kcLPQJcQLfHmSd3Vx/9HrKuv0bCv/MeEl
         TkF/EvzkU3uss3aO8algjgDAWH8ZxN2PxAXE054FfaIgeNzpYCDAfsrAmUuP9lY3tc+B
         WtaoU48cOkslCbrHduTASFLyjcXz4cWDSSMkTCXeVjjJkVJ0DMrerIDC8XDUekMldq/Y
         zQ/w==
X-Gm-Message-State: ALQs6tDwQ+J/juW12qtOz+D6Afwi/4tDJxkVrXffeRKa69OfKZEcu5Ae
        vAfktVUW7unkOkQgo2T/jTs=
X-Google-Smtp-Source: AB8JxZppVmz920P6Fe0VZzrEiKMgMVHw+QHdP5ZrdEnTwkLs+Gh5jTiXc3+9i9XkJRoJ7xae7shrVw==
X-Received: by 10.28.87.198 with SMTP id l189mr11674424wmb.161.1525323356488;
        Wed, 02 May 2018 21:55:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u36-v6sm20579986wrf.87.2018.05.02.21.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 21:55:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>
Subject: Re: Blame / annotate with mixed mac line endings?
References: <B8114616E07247C7A78F1DFF91E16A63@ad.pdinc.us>
        <xmqqh8npv8hy.fsf@gitster-ct.c.googlers.com>
        <8957C3B9BEF94443ABE0A67340786A86@ad.pdinc.us>
Date:   Thu, 03 May 2018 13:55:54 +0900
In-Reply-To: <8957C3B9BEF94443ABE0A67340786A86@ad.pdinc.us> (Jason Pyeron's
        message of "Wed, 2 May 2018 22:32:05 -0400")
Message-ID: <xmqqd0yduylh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> $ cat /usr/local/bin/helper.sh
> cat "$1" | mac2unix
>
> The important issue was to not use mac2unix directly, because it
> modifies the file itself.

I wonder if

[diff "test"]
	textconv = sh -c 'mac2unix <"$1"' -IAmArgv0-

works without an extra helper.

