Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683E01FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbdCMSLO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:11:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751206AbdCMSLN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:11:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9978382C9B;
        Mon, 13 Mar 2017 14:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zgoB7rhJ1DT8PWJRGpGT9dS67is=; b=L0O+js
        L0JSWrQDFhhSs3V7CIz6sRVtw3AD/YV9zDMvflDSu9D86kYkFtSyeHDBFN6/HlXF
        UYWrbpa7H5kSGWHIxVgsx4OnamkjRWZKB8kmqXMV7Eue07KK/ZsR6Eiip26rHZu0
        E8UPawKH78FaPDRRt0Zk02FJZzVb60vhFwnQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLAh2sfVI0wT4Z284PXXsiwVkHS7pulT
        fGsBMyQr+lmSHbEUuvYsyWsdb7hFh1fxKybZ2hnCJA//Q9k1PITZYyJEmpx0hTs5
        X7DLjogH254KQa50H/yoyPxnjGwtTlr2lugpDam6cn4cs8GIXE6qTsYepKzNCstB
        AVRL+ubyuhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 935E582C9A;
        Mon, 13 Mar 2017 14:11:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B07282C99;
        Mon, 13 Mar 2017 14:11:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME for credentials
References: <20170313172232.96678-1-lehmacdj@gmail.com>
        <20170313172232.96678-3-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 11:11:09 -0700
In-Reply-To: <20170313172232.96678-3-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 13:22:31 -0400")
Message-ID: <xmqqpohlrqrm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70124084-0818-11E7-87BC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> +static char* get_socket_path(void) {

By the way, in our codebase (which is C not C++), the asterisk does
not stick to the type, i.e. the above should be:

	static char *get_socket_path(void)
	{

