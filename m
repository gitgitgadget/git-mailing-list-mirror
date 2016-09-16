Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1F0207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 23:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbcIPXHG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 19:07:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51631 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753245AbcIPXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 19:07:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D703F643;
        Fri, 16 Sep 2016 19:07:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SJmWXWdl0AmM6YXTTTmn2uMCszk=; b=wI+dVq
        ZAFyDIXjikmiLUWsSDmYbmfjpMDrmSCSmKewkYwhyldkxY9BcEt/0x+aKBMoEWZr
        4ClXkWwjqx3QukIoRHrCQxs9bhQKNly6RllXKRMLp71TYlst2AR3o7HZN9RD8n1m
        lAZBJwO2Pr0CGqc0lAb84ivOS7T/0f3mc6hgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lUPLjY/1sjwzOOnCl5fiVdvahapm3UyR
        E8hsU+cu+L0jFFlMiZvpwchZpFAXurLlbBEiyUtG8yH9ePVtvzngGUldxN2WdSeh
        CEb+Oo9HsnTR+qwhNIe/3kZDuM0Kog1KHEfi0+B0aCKYK+KKDVDojJuDYvVF0T8Q
        PD0k2yk1WrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 517E13F642;
        Fri, 16 Sep 2016 19:07:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9CCE3F641;
        Fri, 16 Sep 2016 19:07:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] run command: add RUN_COMMAND_NO_STDOUT
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com>
Date:   Fri, 16 Sep 2016 16:07:00 -0700
In-Reply-To: <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com>
        (Kevin Wern's message of "Thu, 15 Sep 2016 20:12:21 -0400")
Message-ID: <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 476DA868-7C62-11E6-9427-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

> Add option RUN_COMMAND_NO_STDOUT, which sets no_stdout on a child
> process.
>
> This will be used by git clone when calling index-pack on a downloaded
> packfile.

If it is just one caller, would't it make more sense for that caller
set no_stdout explicitly itself?
