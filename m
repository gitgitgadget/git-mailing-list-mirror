Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3D7203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 22:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754983AbdGXWXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 18:23:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65466 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753015AbdGXWXX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 18:23:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 754B294626;
        Mon, 24 Jul 2017 18:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=72tEA5SJGao3+HoaWLIKrMrf5zk=; b=ES/vw7
        tiwZXc9ZuBF73fGOwP3L60SF38JfjLXi0zNu6Wy5GPiVxwF4m+0vsDFUZJCHme0S
        q18eJ/IPb5ZFnRBzVMcfZx5CuQvDPojn7r663fuMHWaq2lU1P3tp/+XVrcI93wWe
        85lbQVCXyLZXe9MptdsXKOFQUOAvZGNwoc67A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n0wJnSXprZpj+/raH8/9lQarDXy0DXvB
        5Xrm4v7rji/KvlnBOuX2t43jDJ4J6CkaDkDjhbeM3iXonsiVz5GVVgnODU5AlJzh
        Mru+L2KaI07UbzVS4F8rdQUDDzG4xBobZ4urkPlrD/78srPVp6KdJh2QuBYyn50x
        +upH746Ej2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6906594625;
        Mon, 24 Jul 2017 18:23:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC5C494624;
        Mon, 24 Jul 2017 18:23:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
References: <20170724173601.19921-1-sbeller@google.com>
        <20170724180312.GE13924@aiede.mtv.corp.google.com>
        <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 24 Jul 2017 15:23:20 -0700
In-Reply-To: <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 24 Jul 2017 14:33:54 -0700")
Message-ID: <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3AADEF0-70BE-11E7-9127-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also, while I do agree with you that the problem exists, it is
> unclear why this patch is a solution and not a hack that sweeps a
> problem under the rug.  
>
> It is unclear why this "silently detach HEAD without telling the
> user" is a better solution than erroring out, for example [*1*].

Just to avoid possible confusion; I am not claiming that it would be
more (or less for that matter) sensible to error out than silently
detaching HEAD, because I am not giving the reason to substantiate
the claim and I do not have a strong opinion to favour which one (or
another potential solution, if any).  

I am just saying that the patch that proposes a solution should be
backed with an explanation why it is a good idea, especially when
there are obvious alternatives that are not so clearly inferior.

Thanks.
