Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0FD1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbdHVWS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:18:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751292AbdHVWS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:18:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F31190D36;
        Tue, 22 Aug 2017 18:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lii0SkE/KVdXfdECFkDLil1tbpo=; b=NSMqJz
        OPPRighhCxv70dlOaZJuaubcjk5zpq79wOMdk1+tDZ94qnaWsJF2NvH7wT9pbCof
        PiRaINn0swdLUV6nzTJ1MXqtsKzgOVhbYUeH3Mx+7RZLqBQig9XjeqUx6OS6qKKm
        fESmNPd/B3ozf5kyNBO7tFoX5/g1M+482PpTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u9xnqKD9LXIVi6cN0J0NMKVsxnC5oG2J
        7jUWTYUHTzsiwxPTbw1HQN3ZKVDmrGmgEBti+VcbXoxPPCuuhAYaACdUn1UQ9+8i
        2yGKgR8AS8zGVXd0sbkroE1ja1T3RAGMgC5Dhcdwl9XEHqwsXKWhYrMERH6G0vBL
        3GCVBxNPJwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6719990D35;
        Tue, 22 Aug 2017 18:18:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA6D590D33;
        Tue, 22 Aug 2017 18:18:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] vcs-svn/repo_tree.h: remove repo_init declaration
References: <20170822213501.5928-1-sbeller@google.com>
Date:   Tue, 22 Aug 2017 15:18:25 -0700
In-Reply-To: <20170822213501.5928-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 22 Aug 2017 14:35:01 -0700")
Message-ID: <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1CF4D0A-8787-11E7-A4AF-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:


> The svn specific declaration of repo_init was not used since 723b7a2789
> (vcs-svn: eliminate repo_tree structure, 2010-12-10).
>
> This was noticed when including repository.h via cache.h as that has the
> same function with a different signature.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

It looks to me that this is a reduced duplicate of what brian posted
yesterday.  The first two patches in the 6-patch series that you
commented on, I think, covers what this change wants to achieve and
probably a lot more.  I've merged those two already to 'next' and
was about to push the result out.

Thanks.


>  vcs-svn/repo_tree.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
> index 889c6a3c95..8592beb59b 100644
> --- a/vcs-svn/repo_tree.h
> +++ b/vcs-svn/repo_tree.h
> @@ -17,7 +17,6 @@ void repo_commit(uint32_t revision, const char *author,
>  		const struct strbuf *log, const char *uuid, const char *url,
>  		long unsigned timestamp);
>  void repo_diff(uint32_t r1, uint32_t r2);
> -void repo_init(void);
>  void repo_reset(void);
>  
>  #endif
