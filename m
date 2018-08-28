Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08FE1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 01:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeH1FCN (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 01:02:13 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42703 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbeH1FCM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 01:02:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4B7EA4D8;
        Mon, 27 Aug 2018 21:13:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 Aug 2018 21:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=XiUKEj4m4yU1o1Trstl7HRK3ys6zq
        WJp8He9P8GrVYg=; b=V3CTf5ItcEdJTmUu5SPTs/STpuMqWGN7+I7jicvbq6AgO
        ZlHBYcnCnAeJgvyB7mV2RjXajwL7/zNTvyI3Rryt+OUgJz2dmTF/SGJfV2f6OpvR
        7T+jdfWjgXyPOVE1G6C23EE0F+Oysic+lVooC6Lc9tvLGBa/N00RDUJSuJb3XYk2
        5QxbyYBFZ5MBnR9Svi/ujrqcqKoWnNKmJbgSZMs9O+l02KjzJT/cEM3EWffhHndP
        2mz1Iehc1iIPSH36tS1hs8H8RXJkefJlqjc2h9gGjI+1nUyOT8/fpdHt0xg0sxlo
        oqg3ZrH3X2EbCddZBdERIrp8vgGVYqm8ISGJh+/Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XiUKEj
        4m4yU1o1Trstl7HRK3ys6zqWJp8He9P8GrVYg=; b=Qg1KX4uG71Dm3dAPnGPhIE
        sMp2ZY4/qkBvszYZuDGVCf7/93MQuURA6hPGHeJdZ/BNsNK+/suc/sSi7nw2Sju/
        ArAtFhJu+9iAOGQKRMfWraQi1TokUuEm2z7wx7xtikQg1XTkvykEE9mmQMKc5Lia
        SVyCV+Mg4JGaxEx0aRugurxRNY63kuEjerXv+2PY7WIQL0rulfxu0OQHcT85v3DR
        pK2kTHT5R75uA3xCnKpzIXNSlY5kDdgDmgABnPoVSWHv00RC4BAPqeiJCSdtJr1d
        2/jnOtJWit/qY+2IlK4zvegiilKn/I/ux1KIuiopT9uH8Et/UuiXdcPANM+ZQeWA
        ==
X-ME-Proxy: <xmx:oKGEW7QpvI012OlZ-0bvYkFaoG5aqsD_2XRAFaAaFk_gG0xnjl3-mA>
    <xmx:oKGEW11v9Emg7Swt1_gP9IARyEXp5RNUxv13WYmseOT7iVeWOs5FBQ>
    <xmx:oKGEW55VSW2gRKEfiHzY4y3H-tSKH_QxabW5H8FNmZy1QeQD-KTX_Q>
    <xmx:oKGEW2znr31p4FOZbpOrkspv5PzkErujg6kRptt6ZXtgvKqKf0xRUw>
    <xmx:oKGEW9yXOOTqRFmwYDP5_CmXOTNDlb1lRtvNTAkOuSxVxTQKbPH8UA>
    <xmx:oKGEW3xVwT3GPriUkSdGNLatlKF68fFfn1SIi-8GJekrLrZSpZQ13w>
X-ME-Sender: <xms:oKGEW34HDlf_zXWv65Ixg_2szcnKyf89IynFWWP__q0rug8DZNmbMA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44811E4015;
        Mon, 27 Aug 2018 21:13:04 -0400 (EDT)
Subject: Re: GIT_TRACE doesn't show content filter files it's operating on
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
 <20180827235321.GB11663@sigill.intra.peff.net>
 <28045b26-4822-b00c-30f3-1076d2e49d1f@stason.org>
 <20180828005810.GA18659@sigill.intra.peff.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <9fc6cdcf-2e72-8eb1-9bcd-f513babd9c6f@stason.org>
Date:   Mon, 27 Aug 2018 18:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828005810.GA18659@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-27 05:58 PM, Jeff King wrote:
[...]
>> 2. Is there no way to get git to do the filename reporting as a normal
>> GIT_TRACE behavior? I don't know anything about its internal workings,
>> but it surely must knows which file it operates on when it opens it and
>> sends its data as stdin to the content filter. It makes the debugging so
>> much easier when one can see what files are being worked on. So perhaps
>> this utility can be made available to all not just as a hack/workaround.
> 
> No, because GIT_TRACE itself only reports on the execution of commands
> and sub-processes. There are other GIT_TRACE_* variables for various
> subsystems, but AFAIK nobody has instrumented the smudge/clean filter
> code. IMHO it would be reasonable to have a GIT_TRACE_CONVERT
> that covered convert.c (so these filters, but also newline conversion,
> etc).

Thank you, Jeff.

Would you please add this to the TODO list (if that's how new feature
requests are made)?

I now know how get the filenames for "clean/smudge" filters. Can you
please help with the same for "textconv". %f doesn't work - it gets
stuck there waiting for stdin, the following seems to pass, but I'm not
sure it's correct:

[diff "ipynb-code"]
	textconv = "f() { echo >&2 \"textconv: nbstripout -t $*\"; nbstripout
-t; }; cat $1 > f"

In a trace (git diff w/ one modified file) it gets invoked twice:

18:05:27.640955 run-command.c:640       trace: run_command: 'f() { echo
>&2 "textconv: nbstripout $*"; nbstripout -t; }; cat $1 > f'
/tmp/4nCYaT_004_callbacks.ipynb
18:05:27.642205 run-command.c:640       trace: run_command: 'f() { echo
>&2 "textconv: nbstripout $*"; nbstripout -t; }; cat $1 > f'
dev_nb/004_callbacks.ipynb

The first trace gives a tmp filename, whereas I need the actual filename.

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
