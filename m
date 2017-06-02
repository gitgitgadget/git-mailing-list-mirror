Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F63D20D12
	for <e@80x24.org>; Fri,  2 Jun 2017 07:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdFBHPz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 03:15:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34356 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdFBHPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 03:15:54 -0400
Received: by mail-it0-f65.google.com with SMTP id d68so8698941ita.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z1L/3YfPUv4LukWAQVBIgAaCpnLLbXGp64IBxtGMW2E=;
        b=OdWAkWiT+JSv3CVGkKlFEt7E4Bi7CXeNfTproXnQ8qzzYOO+qc7yZgDEkeoMf9rvIW
         2kzrSQOJgCujJ0Cxag3c/CNAfHPkxFHCEj1JoBFmTm2nLTEaEY9GUX8yxNy9qXV4iYEv
         mICpK8Wwdv/0iIOUS8vHU1AIcOtLpkyS5sW9DCXgkLJZT6IsncDUvtQxi8LUau1fVSG8
         SEfXcZPZghWzlj3Kb3ZZOY2htG+Ij9h/bkzT/0ovZHA1ZOu7ak8ptSW7pAmpiumvonc5
         H2E21c068cQvFE0GKwfbN/1m0rRVzOGRNRJGbWY2nj+M3VwC86wEtz6p7kuKhCZ7bxz3
         p3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z1L/3YfPUv4LukWAQVBIgAaCpnLLbXGp64IBxtGMW2E=;
        b=YiU27TEyQ/PFzpOgQW/xj6GwnHjHSYY0g4wXNIiHugFiTuW8jyaEMvBFXcRw0IVb3g
         2VsNyvHXFGKUzBm4Ql/MLvDbdhYUG4s/pCuaPEhBpJlDsXLS+024fUkulBcdbocrAhle
         qszsYVfsYQ/srYUtpjJ6YKv+k/soMyIu4FODSAeJP4e6PXiw8HFWNJ1QJ8QGLQz8Bt6F
         SsT4ukRg+ar2YCvdp01iXoaREByTjJHpsygwp1iZm+s8jrZ1NAPZ6Jdl0YlmivIUBtnL
         3dS2x8zhKAr3qL3ls+iIYgPMS0VlWhFobPW/WU6ypgjoWFkBXZ/0oz0BIYYkmAdeFnGd
         tS4A==
X-Gm-Message-State: AODbwcB4elKAUkhds+IozXs7dqjnr5/C+2IcTpoYdXeC39+R0qQAVQX5
        lg98ybQ/fnxH5g==
X-Received: by 10.101.73.202 with SMTP id t10mr5593669pgs.28.1496387753339;
        Fri, 02 Jun 2017 00:15:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id m134sm2387198pga.15.2017.06.02.00.15.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 00:15:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git List <git@vger.kernel.org>
Subject: Re: How to avoid "Please tell me who you are..."?
References: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
        <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
        <20170602070052.3lq22arcncuh6rrl@tigra>
        <CAH8yC8nGR1heD9_xRuHRG-oerdoQr6Pi8mT=ZpFhoeH6LaFK2w@mail.gmail.com>
Date:   Fri, 02 Jun 2017 16:15:52 +0900
In-Reply-To: <CAH8yC8nGR1heD9_xRuHRG-oerdoQr6Pi8mT=ZpFhoeH6LaFK2w@mail.gmail.com>
        (Jeffrey Walton's message of "Fri, 2 Jun 2017 03:07:11 -0400")
Message-ID: <xmqqy3tayi53.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> Is there no switch? Its the most efficient way to accomplish the task.

This is a safety to help normal human users from hurting themselves,
and it does not make any sense to have "I have no name, so record
garbage, please" option, switch or setting that is different from
"Here is the name I want you to use when recording things".

The switch _is_ to set the names with whatever standard way.  
