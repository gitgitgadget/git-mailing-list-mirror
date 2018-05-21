Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BE41F51C
	for <e@80x24.org>; Mon, 21 May 2018 01:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeEUBG2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 21:06:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37932 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeEUBG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 21:06:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so14361894wrf.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8Lfi+Ro5p1MgpXSGQLTd1woKNXPP3krHyVUlcWHvxxM=;
        b=BR4ChyFB3SRYR8lRPlvtLx6uk8POJEx7U6bId6IxeHztkVT8BoLw3AoWzf3BOZlYzt
         YpA46aULnaGFc5K+cLD37zYs64I2KsbW9XRi1AUuXrRwTPWh7MAQuSw0mzcGKMa0soDT
         uF7kqZm9febOBGWg6WbDLK9N2Etb4omdwFoddTrD3gkX2TVZ7CsE4ngy8XEYiYrHhb3j
         BVAWn5pbFk3p0UGuuLtx0ebnOsHrhoD5yUkPqaejt1kJwi2kiadkDSMGvl2ilSw7xono
         pb2J+KQKel5J9CKC7iRgzKU3jnZd+TT+Md5oHStW4GWQfL3uHsH++Rdf3i86TfuJow/x
         iTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8Lfi+Ro5p1MgpXSGQLTd1woKNXPP3krHyVUlcWHvxxM=;
        b=hucurSBZTmmvhyvywx7B9gCZ+/XbcJcTbYdGBEJyCFWlpfcN4s8XTAdNIQ2lm15+Hg
         tPqIr4RSqOU/rym1XZE+CqUgv5ehhJjhcmxKPStpDJ6L7prJi0Tana1JWpgIdYdX86uA
         i+/q7z55qOdOsNBhRxpbyluCw7cIQRh4oqdPYG4EWc5cSg7ekh6qwNqHaFouzZjCKoOi
         NwMkol/MPFIVCn7zmtI22hkcpqdYUYzh5K9jC95qS4S8dbjOHzzss2qfOFOjUIj8D+MZ
         VD/Q6Fupa/0wVMCG4AOZN53Zl2EhyzCrUv2z91jZSKvvokEWEj1KJuBwf9jLdS+N/xg3
         Zu3g==
X-Gm-Message-State: ALKqPwe38LhcmT4a2eK2h0Ea9F0qvZil6WadfJMx7D8K8cUCGSyMFVbx
        BlHHD443GQw60U1sJyICsu8=
X-Google-Smtp-Source: AB8JxZoaV/E23tvYDtXXM8iz4ShzVeQL/PVC/6zvP5JnmPbHwcYU8HvUIoQlhCYWS8tFd7tHHLBXJw==
X-Received: by 2002:adf:e9c3:: with SMTP id l3-v6mr14773322wrn.195.1526864786551;
        Sun, 20 May 2018 18:06:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d12-v6sm6536644wre.39.2018.05.20.18.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 18:06:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 13/14] completion: reduce completable command list
References: <20180519042752.8666-1-pclouds@gmail.com>
        <20180519042752.8666-14-pclouds@gmail.com>
Date:   Mon, 21 May 2018 10:06:25 +0900
In-Reply-To: <20180519042752.8666-14-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 19 May 2018 06:27:51 +0200")
Message-ID: <xmqqin7h3jhq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The following commands are removed from the complete list:
>
> - interpreter-trailers not for interactive use

Typo here.  see below.

> -git-interpret-trailers                  purehelpers                     complete
> +git-interpret-trailers                  purehelpers
