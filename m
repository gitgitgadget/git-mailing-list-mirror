Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30DE1F462
	for <e@80x24.org>; Wed, 29 May 2019 19:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE2TzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 15:55:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60727 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2TzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 15:55:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04DF27785E;
        Wed, 29 May 2019 15:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6iMF+W+ndAvWhg1eFnLCSNV8AdI=; b=glHM4H
        +ZtIX5WMoe5rCHd0QKZZKl/ONf2lC4JQ3QpAbrx6pl8tXv9sLKrwM1KW0JoTm1Rd
        zcXWfffWn8JzLQa26IP6cuQnBk3F8yA0qo+4kxvf9/qJnL8ACi4IA4vxt8MWMQyj
        0XRZv8W2HOykkVtk4wpxL9mABbgcd8sRk/SR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=im9xNFCAxLvHTTHf40f5YDwcDMrr7443
        gt1s3QpDJZQu/mCxHmMkNpwCz8/fkmrz/GZ4I8pQyB+sAifv0UVkrBlKnHmVerb3
        +BC1/61K2UOF6KvsTKIChFGgVhfCiqmRhhlydyfUJOp0tKaQYY2mHebmtiHNpO9B
        lYt2dwhl2rM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1EB57785D;
        Wed, 29 May 2019 15:55:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B46977859;
        Wed, 29 May 2019 15:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] diff-parseopt: correct variable types that are used by parseopt
References: <20190524092442.701-1-pclouds@gmail.com>
        <20190529091116.21898-1-pclouds@gmail.com>
        <20190529091116.21898-2-pclouds@gmail.com>
        <20190529164755.GE3654@pobox.com>
Date:   Wed, 29 May 2019 12:54:58 -0700
In-Reply-To: <20190529164755.GE3654@pobox.com> (Todd Zullinger's message of
        "Wed, 29 May 2019 12:47:55 -0400")
Message-ID: <xmqqv9xtxch9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A45D3D30-824B-11E9-8E01-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> FWIW, I ran this versions of the series through the fedora
> buildsystem and noticed no issues on s390x or any other
> architectures.
>
> Thanks,

Thanks, both.
