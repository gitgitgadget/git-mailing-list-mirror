Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1614E1F406
	for <e@80x24.org>; Sat, 12 May 2018 17:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeELRuO (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 13:50:14 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:51143 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeELRuN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 13:50:13 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id HYemf8hr13fRRHYemfWDk8; Sat, 12 May 2018 18:50:12 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=YZWTGTZf c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=RPUpm6aFTCeVFKKpSrMA:9 a=QEXdDO2ut3YA:10
Message-ID: <E92D8A89AD3E49229B84F08DDE883ED8@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Cc:     "Git List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com> <20180507175222.12114-1-pclouds@gmail.com> <20180507175222.12114-12-pclouds@gmail.com>
Subject: Re: [PATCH v6 11/13] command-list.txt: documentation and guide line
Date:   Sat, 12 May 2018 18:50:06 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180512-2, 12/05/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfObW18fl4vLP5h/Q+Dn0skHaSTHvQ9vjVgYmnFNa/1oYoZbYd/b9a4qUF/XA52YykknI6D0DSUINCj7I2gsYl9rkjbHXBNm//TnV/J4mUW0v1khsT1Sw
 hb3NbFKY7C44UnSQGlI1K2NskqNCLEpzGmZ092e9Adghssomcx2r7TMC6N1983D4OqtBVY2pRQY6P9Nsu5dAiz5VF4s6aNaQe9su3Ndbrp5qci1N3MKohic2
 lk3GdHSEzbBWG0nVoYLQSp2ivbGbvkbURffZvmVzSMFlqU0GG+x1zmy/V4sDjqKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

From: "Nguyễn Thái Ngọc Duy" <pclouds@gmail.com> : Monday, May 07, 2018
> This is intended to help anybody who needs to update command-list.txt.
> It gives a brief introduction of all attributes a command can take.
> ---
> command-list.txt | 44 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
>
> diff --git a/command-list.txt b/command-list.txt
> index 99ddc231c1..9c70c69193 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,3 +1,47 @@
> +# Command classification list
> +# ---------------------------
> +# All supported commands, builtin or external, must be described in
> +# here. This info is used to list commands in various places. Each
> +# command is on one line followed by one or more attributes.
> +#
> +# The first attribute group is mandatory and indicates the command
> +# type. This group includes:
> +#
> +#   mainporcelain
> +#   ancillarymanipulators
> +#   ancillaryinterrogators
> +#   foreignscminterface
> +#   plumbingmanipulators
> +#   plumbinginterrogators
> +#   synchingrepositories
> +#   synchelpers
> +#   purehelpers
> +#
> +# The type names are self explanatory. But if you want to see what
> +# command belongs to what group to get a better picture, have a look
> +# at "git" man page, "GIT COMMANDS" section.
> +#
> +# Commands of type mainporcelain can also optionally have one of these
> +# attributes:
> +#
> +#   init
> +#   worktree
> +#   info
> +#   history
> +#   remote
> +#
> +# These commands are considered "common" and will show up in "git
> +# help" output in groups. Uncommon porcelain commands must not
> +# specify any of these attributes.
> +#
> +# "complete" attribute is used to mark that the command should be
> +# completable by git-completion.bash. Note that by default,
> +# mainporcelain commands are completable so you don't need this
> +# attribute.
> +#
> +# While not true commands, guides are also specified here, which can
> +# only have "guide" attribute and nothing else.

While the file is called ~ "Command List", the list is here as a support to
the Help function, and ultimately to the user's reading of the man pages,
including the man(5/7) guides, so I'd view the man page guides as first
class citizens.

Perhaps:
# As part of the Git man page list, the man(5/7) guides are also specified
# here, which can only have "guide" attribute and nothing else.

--
Philip

> +#
> ### command list (do not change this line, also do not change alignment)
> # command name                          category [category] [category]
> git-add                                 mainporcelain           worktree
> -- 
> 2.17.0.705.g3525833791
>
>

