Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928332022D
	for <e@80x24.org>; Sun, 26 Feb 2017 12:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbdBZM2B (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 07:28:01 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:32140 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdBZM17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 07:27:59 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id hxv9cKPcq46SJhxv9c9OoN; Sun, 26 Feb 2017 12:27:24 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=anyJmfQTAAAA:8 a=g0ZjVuUTkfxk5Dh_P5sA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=xts0dhWdiJbonKbuqhAr:22 a=YJ_ntbLOlx1v6PCnmBeL:22
Message-ID: <744E670407404147B290392DAD79DF44@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
        "Sebastian Schuberth" <sschuberth@gmail.com>,
        "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170224131425.32409-1-pclouds@gmail.com> <20170224131425.32409-2-pclouds@gmail.com> <29A09E4EDB1F4F4D9E77E67A7A8A33FF@PhilipOakley> <CACsJy8Bq-P8Aw+f0omndCmQU54n_p7ZwDVDK9APuH_3vXDac2g@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] config: add conditional include
Date:   Sun, 26 Feb 2017 12:27:24 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMl1h5uBoXK9S/JpbrjaLfOb2i9FT7a0PfmO9qKqH2wJ5LnBJPhFryWEntCeBy5NvxPZiX2d+Mr2LSe9ybnv+c2uwspf364hSeHAjOImrqj0Wyej1iXj
 diPUxqAdS4ZNkFkXl8/8FSFTYHdlHXa4SJWPxPRPvPu5E4gDs0W67oozNxf+l3m2PklWISZz5AyP2EEMRog5ztdz+6U1SaXxG4FjcOdYbVH66WsSpdC0nSW0
 4rHd+CbGnQ4aZFdtPNH8A1rqK3zsbBeliOxXQmlJpdKvRl/TofFk0OK+jmzpI4DqfZOeui2nmCN6x+Z/sL+4qA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Sat, Feb 25, 2017 at 5:08 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>>> +Conditional includes
>>> +~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +You can include one config file from another conditionally by setting
>>
>>
>> On first reading I thought this implied you can only have one `includeIf`
>> within the config file.
>> I think it is meant to mean that each `includeIf`could include one other
>> file, and that users can have multiple `includeIf` lines.
>
> Yes. Not sure how to put it better though (I basically copied the
> first paragraph from the unconditional include section above, which
> shares the same confusion). Perhaps just write "the variable can be
> specified multiple times"? Or "multiple variables include multiple
> times, the last variable does not override the previous ones"?
> -- 

My attempt, based on updating the `Includes` section would be something 
like:

`You can include a config file from another by setting the special 
`include.path` variable to the name of the file to be included. The variable 
takes a pathname as its value, and is subject to tilde expansion. 
`include.path` supports multiple key values.`

The subtle change was to s/one/a/ at the start, and then add the final short 
sentence that states that the section's variables can have multiple key 
values.

I copied the 'multiple key values' phrase from the man page intro for 
consitency, though 'multivalued' could just as easily be used as it is the 
term used by the 'Configuration File' section that this is part of 
https://git-scm.com/docs/git-config#_configuration_file.

Even shorter may be:
`You can include a config file from another by setting the special 
`include.path` variable to the name of the file to be included. The variable 
(can be multivalued) takes a pathname as its value, and is subject to tilde 
expansion.`


The Conditional Includes would follow suit.

Philip





