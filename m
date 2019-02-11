Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844FD1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbfBKSf4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 13:35:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40651 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfBKSfz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 13:35:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so250534wmc.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BiA6R5jJQpkSQW+82xsR26rRP6RS5cV5AVIJGSSbvsQ=;
        b=tDRDjtpeMRx1SP8LzXR8a+e5Pl0CtDtwWFti8xOzbmILOugxQRYsl72L4Ow4t87rWb
         isQXTgwBkzPyTIMPi1fRSjFa2gfdpxpIxb7iODyeuYA2pIPGzIA8CyPYNOT56Go+n5Vs
         P/Ikk9zaACbjxWnEgcbwbUEHmbH0GPG22DsZjXb6jPHWT8bj2eQoE1TnNat6svrR7pL6
         9wco3ug7UQe+PAAaNVsrAUmLkXvDFo0lxYGs/6sg5Th5YHpueH1Lgvh0bRajqTIGvca1
         PdH5uV++Bcl9goeWLX9OlwxHXtwunSu6bgk6l5JDXvwisIatIVvIPbt1CcdurRUnpwpG
         UbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BiA6R5jJQpkSQW+82xsR26rRP6RS5cV5AVIJGSSbvsQ=;
        b=nON4DoAOUjvWys/fBs/dc25jLQARk28a7bV5noSjHXfO5IkapcZMisRB7NsyZ3YdNy
         dByUhdM0VV2aCEo89KDpbwDfrS7Fr+ZlI0/7EEPTIt+DU4OEr/JhXkv6+CAwi/zWPdDj
         tNoJqbBUtVG/FcQLbKBoD+HiGN9l0I+9keTdbhvk2N3XAWf5wdcC/mByWBgmlUudaIQi
         9gKgk26Xf6Nb11+GHwA2FqSLnncODoEwXELUVSI3wnkQHVhvxR07Z0C78XVhGcNkXb6Q
         k5kEOavG1GJaRiaDg9YufoZJj7yZ1aXzz0PN+1z37Nn82Z/myLOpBS7mRhYYw4z07/yQ
         4y6g==
X-Gm-Message-State: AHQUAuaft72KrAMvd/QSNh7Ay7iUeLEyYAqAc+lJNtDuVa3TEy6xjQeW
        gghmLadqMSaxXFVJLleCMwPR/0yB
X-Google-Smtp-Source: AHgI3IbuCdwOGn9JdnWP5Yl/xOwV7zsztWBRoOQdVRgJJaDmJ6ROFFVVXEVw+FcNCP+sG8HFVIkDvg==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr709178wmj.0.1549910153576;
        Mon, 11 Feb 2019 10:35:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm43960wmb.39.2019.02.11.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:35:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/21] nd/diff-parseopt part 2
References: <20190207103326.10693-1-pclouds@gmail.com>
Date:   Mon, 11 Feb 2019 10:35:52 -0800
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 7 Feb 2019 17:33:05 +0700")
Message-ID: <xmqqftsui35j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> "What's cooking" mails seem to indicate that the series will be cooked
> in full there then landed on master later. So here's the second part.

Ah, I should have responded to this part.

I think that the part 1 was reviewed and found reasonable, and we
could merge them to 'master'.  But because they themselves won't do
much good until completed, I'd rather refrain from including them in
a half-done form in the upcoming release.  In other words, do not be
surprised if you see these early part(s) land on 'master' before the
remainder after the upcoming release.

Thanks.

