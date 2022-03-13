Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9A8C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiCMXZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 19:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiCMXZD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 19:25:03 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA96570
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 16:23:55 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22DNNhvU043225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Mar 2022 19:23:44 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Sean Allred'" <allred.sean@gmail.com>
Cc:     "'Philip Oakley'" <philipoakley@iee.email>, <git@vger.kernel.org>,
        <sallred@epic.com>, <grmason@epic.com>, <sconrad@epic.com>
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>     <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>      <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>      <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>      <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>        <87ilsha2b7.fsf@gmail.com> <xmqqtuc1tpdj.fsf@gitster.g>
In-Reply-To: <xmqqtuc1tpdj.fsf@gitster.g>
Subject: RE: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 19:23:38 -0400
Organization: Nexbridge Inc.
Message-ID: <021401d83731$62813630$2783a290$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDHpNtgb5IcYOGFILwDPZIseKDDCgE3FbtSAfu2vTkCYUxZpQI7aYtuAn9FDKYCNWE3yAEm8zVuArWMc+kC1eeJ6wFdCBScrjp7q2A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 13, 2022 7:16 PM, Junio C Hamano wrote:
>To: Sean Allred <allred.sean@gmail.com>
>Sean Allred <allred.sean@gmail.com> writes:
>
>> rather than use magic comments :-) Adapting to your suggestion, this
>> might look like the following:
>>
>>     A. U. Thor <foo@example.com> <ada.example.com> <[ approxidate ]>
>
>You'd probably want a timerange (valid-from and valid-to), instead of one
single
>timestamp?
>
>Because at least three valid forms of mailmap entries should be understood
by the
>current generation of mailmap readers, i.e.
>
>    Human Readable Name <e-mail@add.re.ss>
>    Right Name <right@add.re.ss> <wrong@add.re.ss>
>    Right Name <right@add.re.ss> Wrong Name <wrong@add.re.ss>
>
>the extended entry format to record the validity timerange should be chosen
to
>cause parsers that are prepared to take these three kinds of lines to barf
and
>ignore.

Could we not use SSH's ssh-keygen -V for this purpose when establishing
persistent identities independent of user/email? We already do this for
signed commits.

