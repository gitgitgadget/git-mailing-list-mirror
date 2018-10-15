Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA541F453
	for <e@80x24.org>; Mon, 15 Oct 2018 05:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeJONjE (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 09:39:04 -0400
Received: from mout.web.de ([212.227.15.4]:59461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeJONjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 09:39:04 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcgkx-1flMW80d4J-00kBkk; Mon, 15
 Oct 2018 07:55:11 +0200
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcgkx-1flMW80d4J-00kBkk; Mon, 15
 Oct 2018 07:55:11 +0200
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de> <20181012222234.GF19800@szeder.dev>
 <20181013050057.GA6805@tor.lan>
 <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
 <20181014025207.GA1527@sigill.intra.peff.net>
 <1e3233f4-ea40-6fff-0951-6b4885f88445@ramsayjones.plus.com>
 <20181015000147.GB13510@sigill.intra.peff.net>
 <d3d291ea-00d2-f0dd-5a43-cbea5476d64d@ramsayjones.plus.com>
 <xmqqin236dpb.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <93518ecf-faf6-ce75-c081-8e2e7a56abb1@web.de>
Date:   Mon, 15 Oct 2018 07:54:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqin236dpb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tsvTxKaTH3VAC7zb2LhtjBaXEO1fb+O0uckW74M+QCmcAld2B5d
 vUokuECym+h7MvytohKclsxi+viz2qAHWF6dADqsxiBGtikboi7/NYJteSsfZoi79NFJUlz
 /6i4O0JSOlAHUEdrCVm4PZI1vhY+RTcCE935cMkBR7ETpQitZ1OfYM5biTp1ajvefJI3i3j
 MtpUNJ0ltEv0DHmUZfVBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:duBi3qUe4Vw=:bHnxKrbQTCcbi+5DVFro/h
 QicDXT1igeBzfvDykicm+1FTrmFwckqGhQPtpgs3ZHXjvVzQ+62zwaPV4CR31EbDm18M3txw8
 qoibsZscWSGuxhR7LcWZFVmmoO9r1m3BzjekLHvFvJrFx1ojMm4deQX+GH6BRj56KwawuwRuK
 Fp+n7o9Vm7eh0dXjjgzvJkIJhdKbiTupOW+0l1NhCRN+LnITtfhcOEjYfN/ohH9WZR4sOCkHz
 2WiZ3nOMvbXmWvtY+mtA7fqok4kagXe+6F5Vyi/9xPd5DDV6HDznodScnRfepL+wDnmIY2fIc
 TplOJRc/1KYOC16b39akmUdZj9I9xUwxN1zxlgJ9rYBxMIhAHLNcH1gzrilMWOuYJ6KB5CTBB
 /+ZByN/8MB0RuE0SCVm6zhCOSAS2VGe3Xiu7vKc2CMBEG6WyTFNv0QtebO7Gnd4KcRMbx4vBo
 bF4TWn8dU+07FLAj+AIe8UaG/w5A7ESaamzrGRaqeYMaSxidmOh1JnWdfIQpyDciGYO0Q1Xjy
 DKY6S/iAsa/H7/Ho5Sdushpm0IjwdRmME3I6gW8c+UsUZpyBeJu8fcfHn/lClZ7YnUSHO/KVy
 5bQqpw2tPbLhHsoDiIys/vbZqWOYVqu+BoAGXa31SgL3T3D9GWfNNc3wVpwIZqaPqBsBsD0pl
 pquPhHDcqeIlw5SZruYpJbazfRg90obMikmN7A5B6gs5S+xkt+8Tmzk7TY1q0UpHQutLEzBPV
 obI/IUwR9wjzsamEmdi2hGRbsESdpCjItFIWJDnd7HYq/4Psmld9PFT6zHvQUiB+87fBHXQVe
 nozd71D1qNQ/2DoXLh89ev4BF9Qak6NdMSwUAeNL/0rAVV3f3I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.10.18 06:22, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>>
>>> For the record, I am not opposed to including the comment _and_ using
>>> xsize_t() to do the cast, giving us an assertion that the comment is
>>> correct.
>>
>> Heh, I haven't found any enthusiasm tonight. Let's see if there
>> are any more comments/opinions.
> 
> OK, in the meantime, I've replaced the thread-starter partch I had
> in 'pu' with your v3.
> 
If that helps to move things forward:  I'm fully fine with v3.

