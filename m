Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE0CC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 01:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7F461057
	for <git@archiver.kernel.org>; Sat,  8 May 2021 01:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEHBn7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 May 2021 21:43:59 -0400
Received: from elephants.elehost.com ([216.66.27.132]:37838 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhEHBn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 21:43:58 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1481gp8Q098584
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 7 May 2021 21:42:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "'Git Users'" <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com> <00db01d74338$d45615c0$7d024140$@nexbridge.com> <YJXF3oq4n/NFJSx3@camp.crustytoothpaste.net>
In-Reply-To: <YJXF3oq4n/NFJSx3@camp.crustytoothpaste.net>
Subject: RE: [RFC suggestion] Generate manpage directly with Asciidoctor
Date:   Fri, 7 May 2021 21:42:46 -0400
Message-ID: <013c01d743ab$7577c0d0$60674270$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD89NHtCaochqkeQ8Q5lNaqEHivBAK5V/vyAYBPpcOsa59UUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 7, 2021 6:58 PM, brian m. carlson wrote:
>Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
>
>On 2021-05-07 at 12:02:13, Randall S. Becker wrote:
>> On May 7, 2021 2:07 AM, Bagas Sanjaya wrote:
>> >To: Git Users <git@vger.kernel.org>
>> >Subject: [RFC suggestion] Generate manpage directly with Asciidoctor
>> >Asciidoctor has support for directly generating manpage, see [1].
>> >
>> >We support using Asciidoctor as drop-in replacement for original
>> >Asciidoc, but currently we need to use xmlto together with
>> >Asciidoc(tor) to produce manpages. However, most users don't inclined
>> >to install xmlto toolchain, partly because they had to download more
>> >than 300 MB of data just to install xmlto and its dependencies (including
>dblatex and texlive).
>> >
>> >So completely migrating to Asciidoctor can eliminate xmlto
>> >requirement for generating manpage.
>> >
>> >What do you think about above?
>>
>> Our toolchain does not support asciidoctor itself because of porting issues. I
>am not sure it is available everywhere.
>
>I think Asciidoctor is pure Ruby, since it also uses JRuby and Opal to run in Java
>and JavaScript environments.  Ruby is relatively portable to most architectures
>and systems (for example, it runs on 16 Debian architectures).
>
>Is the problem in your case Ruby or is it Asciidoctor itself?  I'm happy to send
>portability patches to Asciidoctor if necessary, but I'm not sure I'm a good
>candidate to send patches to Ruby itself, especially for an OS I don't use.

In this case, Ruby is not 100% portable to all platforms. I have an old port, but the latest version is not portable because of unportable dependencies - not for a lack of a large amount of trying. So the assumption is not entirely workable. My only option is to take the pre-generated pages from the manpages repo.

-Randall

