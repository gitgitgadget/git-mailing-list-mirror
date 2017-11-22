Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800AF2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdKVBwV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:52:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52300 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751344AbdKVBwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:52:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E4E7AF9A2;
        Tue, 21 Nov 2017 20:52:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HR5Hy0/dztlUEnxsVaJaJh0mNSg=; b=G65i88
        D+l25GfvBiIWKpQwpvUD3m+ckZF2Cq+zmYNUfz2ajFyyndpOA3EtPBPdNHCLron7
        v8B0Z9diuhVQwvy3VvZcmn6guBJvfV7ckeMA6ZT9pE2EvRzpZt6N+At+d8R9xW3z
        ZRQ2wa6zQpSY3qXHfUggiQHMBVZjeYihbUSpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WJ7jfrTZR7yb9RAiQOFdvyxCksLcJRka
        +Z2AvUEwXajSgNyYLHjNDjBug7hAK4rGVyCOOOYxAIho0Ia0vZsrjH0e+oBOwIqM
        8hDmWBuQlh5GVA+O1IMIOr4jcs6SUePC45PUnsjTCs1dsANlbBUPiZblF+UxkCLu
        BOhJS6VSmC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63894AF9A1;
        Tue, 21 Nov 2017 20:52:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C330FAF99F;
        Tue, 21 Nov 2017 20:52:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH v3 0/8] Coping with unrecognized ssh wrapper scripts in GIT_SSH
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 10:52:18 +0900
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 20 Nov 2017 13:21:34 -0800")
Message-ID: <xmqqmv3fxep9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C67CB2FC-CF27-11E7-9FD1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder (8):
>   ssh test: make copy_ssh_wrapper_as clean up after itself
>   connect: move no_fork fallback to git_tcp_connect
>   connect: split git:// setup into a separate function
>   connect: split ssh command line options into separate function
>   connect: split ssh option computation to its own function
>   ssh: 'auto' variant to select between 'ssh' and 'simple'
>   ssh: 'simple' variant does not support -4/-6
>   ssh: 'simple' variant does not support --port

Thanks.  All looked sensible.  With this, we can unblock both topics
;-)
