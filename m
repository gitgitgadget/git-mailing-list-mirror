Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25F020954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbdLGVVn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:21:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56945 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdLGVVl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:21:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82D52C5106;
        Thu,  7 Dec 2017 16:21:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KoFgUk1AdzhJwk7TSwpyhYoGkIs=; b=nsj+et
        hX7HWjfOolozEUWP7TIrewf07ei9VjkvbpDkV+iMmGhXjejAISB6PTVrZzQxVPUy
        QXIVUN5g5IFMlTm2cYZcQSXV/8T67R3sr9MRyZmX1K0mcr93HVRXoCADEjG1kGms
        ZhiMlyaduqlm9QXQhuiGtUwW+YYL0o+6tErwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R6SRoW8LfKQlSHoD5sRNQGsmQzlcMJJM
        dlCsISoPFB8wj3Ia+mWlUOHhSVDLAbt0amny53Xwg+/w5M5jkz2ZVE3RM8zS7Zop
        ZaB6n50GgYg+nH5d4+Tr+trwBCN3Do3VHZcgSXtFpqNc/iJJHQaiIUF50+2RPRBq
        KT/RHPlIork=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A70FC5105;
        Thu,  7 Dec 2017 16:21:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9ECBC5104;
        Thu,  7 Dec 2017 16:21:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
        <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
        <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
        <20171207202201.GA3693@zaya.teonanacatl.net>
        <xmqqlgiecleo.fsf@gitster.mtv.corp.google.com>
        <71F9850F-5D7F-4CDE-8408-E000ADD48406@gmail.com>
Date:   Thu, 07 Dec 2017 13:21:38 -0800
In-Reply-To: <71F9850F-5D7F-4CDE-8408-E000ADD48406@gmail.com> (Lars
        Schneider's message of "Thu, 7 Dec 2017 22:08:02 +0100")
Message-ID: <xmqqd13qcjz1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D518712-DB94-11E7-9B5C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> The acl stuff hasn't changed for a long time and I do not think of a
>> reason offhand why the test should behave differently between say
>> 'maint' and 'pu', yet 'maint' is passing while 'pu' is not...
>
> My recent 657343a602 (travis-ci: move Travis CI code into dedicated scripts, 
> 2017-09-10) change might have broken that somehow...

But the puzzling thing is that commit is in 'maint' as well as 'pu'.
