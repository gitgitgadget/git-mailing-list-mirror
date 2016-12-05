Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5EE1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbcLEV7t (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:59:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64495 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751497AbcLEV7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:59:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 116E955057;
        Mon,  5 Dec 2016 16:59:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OFykOwLUwpVsaN3OV4mAuL4Bcrw=; b=VeDKqz
        ZfZN7hzk936RRtZ7clGl63r6/XnWvw0hH8cTa4qwOdhWI+6IoNN0dkbfP1seBeOS
        DLBea5dUJmJ/LYW9u/KAGpo5LoVLZP/9SlRu+E1JCvT1UI+cl8DMPlyhu7mFCaJX
        WZ2nh0qPv2ylVyrGpqce9CA6b3/m7AAvKNEkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KPacIgP78IdFCPh3mTY/LSJeIlp9zfOZ
        1kKRGX+lm9QdMH5GL8RCTpncUhwWSYurW9KVsnIPFVzLyMCZfqEwW+1VVyF/dNPC
        u7RtZyCl8+KDYGRkeSg6K1yiERhFY1TCwcpDOWSqTywypX1BZDKNUjmrFdfd8cup
        CDh6yl9Qdys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05C4E55056;
        Mon,  5 Dec 2016 16:59:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67FA455055;
        Mon,  5 Dec 2016 16:59:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     ken edward <kedward777@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git repo vs project level authorization
References: <CAAqgmoO+7cLZHpX61=Mh7PjqrCUc0qyFD=C+sjVat_+KPhisbw@mail.gmail.com>
Date:   Mon, 05 Dec 2016 13:59:46 -0800
In-Reply-To: <CAAqgmoO+7cLZHpX61=Mh7PjqrCUc0qyFD=C+sjVat_+KPhisbw@mail.gmail.com>
        (ken edward's message of "Mon, 5 Dec 2016 15:33:51 -0500")
Message-ID: <xmqqvauy2g19.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23316120-BB36-11E6-9CEA-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ken edward <kedward777@gmail.com> writes:

> I am currently using svn with apache+mod_dav_svn to have a single
> repository with multiple projects. Each of the projects is controlled
> by an access control file that lists the project path and the allowed
> usernames.
>
> Does git have this also? where is the doc?

It is customary not to mix unrelated projects into a single
repository in the Git land.  Some hosting solutions give access
control per branches, and some others give access control per
repositories.
