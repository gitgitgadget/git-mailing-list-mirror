Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F131620D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdFBBe7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:34:59 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35873 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBBe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:34:58 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so42235371pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b6LC5FgRtQz/poQ+83IS5kCdNjs+W1V473jdeb4wdYo=;
        b=DW60A55fF7wmzB1xGSzakfxdx8tTWjlBlNwxNXrHY4vjd692yrs2u6nHOkBK1mxUV+
         nYo/ousrEKa/vbgdBAEgQFEOH5+NxCrVFbKSrRV5jvQScYdQMpZj7TCCWgeONmweIhr2
         nvwV9FBAZDNpTgDm4dVy11B4eNxybyt9ZSsnm6TEw1JInnfcmTbtU2fHWhvE7BAeU0oc
         e23gHNbaURDIckFyUnY/LDp7APOlFI6DymU4Dql7JJh3BQFZvT5owHCJi+OlyUOuZYZU
         50stQ+jidj/XNF876pzPbFYg1+1z9aTy4uVp2AiTEZm+6EcRS9oEfFUADJdwFqGps2zY
         UnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b6LC5FgRtQz/poQ+83IS5kCdNjs+W1V473jdeb4wdYo=;
        b=fvk/44YFl0H6VLDXWdwr19Asp+12ZKEKrZceKkCpfKfiDwzPMke8SRp6cJthtqZMYL
         YMtKyPMcIL5Tk6qPpaj/r1wDZvcWvugCHb3F/7hvJRrMpELwRH6ADPn4lUbAQq5snmjS
         jygRZ/uDwZIPHvLhaZH24YX0v1uqxQ+oFpLyJjSfT5ikRqEf//OCeLD8l2vpkGV3H2Gt
         CAe3Cu8tajQol4iTEpN5pxyMp3o+UPE1MpyZlIuaYODPVd5++bwuOY0la9fg+Pcx8ice
         SykbRXhSWBM07EKGJYnOrAH1mek72h52oyMNZ9+z5OQTZInLqG97VGV4fXcMN1fJRrLU
         9gCg==
X-Gm-Message-State: AODbwcC30ODqiJpzfCmDLTa9B1gAxGQKX5Xtj1/HTztlbVfPLJoD8xIb
        juM6l7pmd15Rmw==
X-Received: by 10.84.175.65 with SMTP id s59mr29650522plb.20.1496367297648;
        Thu, 01 Jun 2017 18:34:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id m5sm42716584pgd.28.2017.06.01.18.34.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:34:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
References: <20170530173109.54904-1-bmwill@google.com>
Date:   Fri, 02 Jun 2017 10:34:56 +0900
In-Reply-To: <20170530173109.54904-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 30 May 2017 10:30:36 -0700")
Message-ID: <xmqqzidr18an.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> A month or so ago I thought I would lend a hand to Brian and do a round of
> conversions from sha1 -> struct object_id.  Now that Brian's latest series has
> hit master I can finally send these patches out.
>
> The first couple patches are from Brian which convert some of the notes logic
> to using 'struct object_id'.  The remaining patches are to convert the grep and
> diff machinery to using 'struct object_id'.

Nicely done for all of them.  Thanks.  Will queue (with tweaks
mentioned in the comments).
