Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14903202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 08:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdGEIFQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 04:05:16 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35230 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbdGEIFN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 04:05:13 -0400
Received: by mail-qk0-f177.google.com with SMTP id 16so183612744qkg.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yxZkS/o5QPNt7ONQxbL2LDR4gdofQ2Mz+PLSbb0IU7s=;
        b=b7iAfs2lTt7Mt6CfEFFEYeQv50VGZkkcgk3J4pueYkI7SSXDMKvWR+vfs02nErXjip
         79rOUmec2UmnbuThRbhokRlaOPRIFSe0aH4iskq3uGoO/ltf1j0bZ8BIU2eV6+j3mVij
         GVn8TDMvuSwj96Sp6Lm7wddWODWLAXNADm4jKddMAF9yKtB/dMvneQD9UzVK9n9reHkW
         e71oSmh6TF4xWE2waURLSdQuTFbcpzikg0F84yX4RcRZlbwPGycmxFhyiEfRxpROJKjp
         1UQTxITMY2+QAkKj1dASRsoC+LfAJ6/AyO0s6plU7cUzvuuA9GpS1MbAeMrqgETOIHIr
         PFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yxZkS/o5QPNt7ONQxbL2LDR4gdofQ2Mz+PLSbb0IU7s=;
        b=ZjMDFo9fDF4xLVr534qAqzZJsXy60RU525WJW/8ld6jBed0pXBPtbtxiNv8XPn9asf
         vn+UP7XHyWD7N7tIQ30USc3Z/ednn7Bdx4JlPhdwMIh6wX/lVEG12B+pcFO/P7+FCSdG
         OpHYIZIR4Y+WsQjR9DL2JSCW3NqL6qMDdScQ58tDMk7hCPF8y4PSqMTQ/cP+yXwFQvPG
         W6drntQDlDvj13U8RcZ+weLxaO6MqqS6QHEhQqa9w/M+tG4KBIAWlSDocujvsCvQGv/d
         xEq9NYpCxLs1BIT5q9/WRBTWgolHfzSAQe1JxJmjCDHIDPf4jPE6w6hqH3CyZKffQEBL
         Zhhg==
X-Gm-Message-State: AIVw111haIsJ7iBq38EX/oDgkgdWGYd53d0FmpRDh/kDHp6RRFhGeN9a
        WRyJHrMT8AdarLcPfEZNpuXj8sDdIgfIopgcvw==
X-Received: by 10.55.53.202 with SMTP id c193mr39055411qka.232.1499241912899;
 Wed, 05 Jul 2017 01:05:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.140.67 with HTTP; Wed, 5 Jul 2017 01:04:32 -0700 (PDT)
In-Reply-To: <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
 <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com> <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
From:   Francesco Mazzoli <f@mazzo.li>
Date:   Wed, 5 Jul 2017 10:04:32 +0200
Message-ID: <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 July 2017 at 09:43, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, Jul 4, 2017 at 11:34 PM, Francesco Mazzoli <f@mazzo.li> wrote:
>>
>> Could you clarify the danger you're referring to? E.g. give an example
>> of surprising --force-with-lease behavior that we do not want to
>> encourage?
>
> https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/

Thanks for clarifying, I had not encountered this because of my git workflow.
I'd also be happy with a config item  that simply disables `--force`
and suggests
`--force-with-lease`, but then we'd need a flag to override that config item
when the user definitely wants to force push.

So we would have something like

* `push.disableForce`: config flag that disables `--force` and suggests
    `--force-with-lease` instead;
* `--disable-force` and `--no-disable-force`, config flags to tune the above
    config parameter at will.

What do you think?

Thanks,
Francesco
