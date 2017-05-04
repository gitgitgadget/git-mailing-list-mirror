Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809CF207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbdEDJfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:35:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53731 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751619AbdEDJfh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 May 2017 05:35:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A87E2071D;
        Thu,  4 May 2017 05:35:36 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 04 May 2017 05:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=JQcROWPYFJjXyDhmST0Y5d1sWFfdAckRdH7uM9Fiedg=; b=IO1wwsXs
        v+Sl+n5w7M+yzZGWZOCuDYJsLwM/ww5t31o+uMpvdgKy+OPIS6E6Jjn+MXpCBBis
        3Zs/k8lua2KXPKCTvNwX5/vHoEDkDvQLXClHaYCzqI4UZJ8iajyWLkCkidKsX2Xx
        q2oqKB2dgIyIkyBTc8q/QVmsYS8em79dBn568IpxdTfKyRNtRYW4PJ9stIPkBJO3
        +IsOVzTFdyJS9LGfCE1xm/KnmJRdVu3VRqqy+L6LX9OniTjcqD63v8KqjNoCcrjv
        dET+HnsNaKpXHSxv7yjM1c+ARhNtz1kqqTFR0UmaQmW5cfrgMsYphN9sohILlQvE
        HxmfDmeKVObxUg==
X-ME-Sender: <xms:5_UKWZPwCGs8IDghUGb27urlWeO4EE_LJqvaz20WpyWHCREf3ZWDZQ>
X-Sasl-enc: ks+SiPo50BEssl5pLKGginDdCegVIQJdvtckQdzfPuKK 1493890534
Received: from [192.168.1.83] (unknown [223.207.25.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id E43777E351;
        Thu,  4 May 2017 05:35:33 -0400 (EDT)
Subject: Re: [PATCH] __git_ps1: Don't kill shell if user types `set -e`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
References: <b344d0c3-c8b8-da27-79f6-ae750be6830a@hale.ee>
 <xmqq60i3k6ed.fsf@gitster.mtv.corp.google.com>
 <c8879806-4e43-d033-bd69-918e730e2d05@hale.ee>
 <CACBZZX6XdwND2-7cY0zp8+K_uh60tn-i_r9V7HAe2X-a-RJeQA@mail.gmail.com>
From:   Tom Hale <tom@hale.ee>
Message-ID: <60ea6f0e-aa27-9a2c-54fd-9c14db9f028c@hale.ee>
Date:   Thu, 4 May 2017 16:35:31 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX6XdwND2-7cY0zp8+K_uh60tn-i_r9V7HAe2X-a-RJeQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/05/17 16:16, Ævar Arnfjörð Bjarmason wrote:

> What's the real use-case here? If you do "set -e" in your shell you
> also get e.g.:
> 
>     $ ls -l blah
>     ls: cannot access blah: No such file or directory
>     === Command terminated with exit status 2 (Thu May  4 11:16:03 2017) ===
> 
> I.e. any little failure will terminate your shell, are you actually
> running a shell like this? For what purpose?

If I want to copy and paste a list of commands and have the execution
stop at a failure, I type "bash" then "set -e", then paste the commands.

It saves me creating a script file and then removing it later.

-- 
Tom Hale
