Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6992020467
	for <e@80x24.org>; Thu, 12 Oct 2017 09:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750729AbdJLJ4P (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:56:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54787 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751473AbdJLJ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 05:56:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BECE79F90E;
        Thu, 12 Oct 2017 05:56:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n1tMeiC6sead
        3kscGKbB443MJqg=; b=xmbfoY/0TKU/G7PxBxYGPJ1Grmv3GqPwRqH34RFFzXcO
        h5lh0oPi0VbLgzvW4WwVglNMMIE2rVG0Km+V2DEkWA8m6PiaLBZZNlEtz5n2+o2G
        xn8678q23IlVuqNUlB/CMvh87yoOSIvOftFBKn6L5gkv8cJRNF+cdBByVv5aIpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kjiQ4P
        wlhVCW1kbT9OtLxFIdzINCDLjYvjjQoQZIEjrZBZsIYJLsbVi2HGw8lT6CcS3cpi
        X3RN0kiXDBTV5BT6es5VArutEpxNmhNoAYL6jsCNd/h+yEGymJ9je/hQk5yEyYBM
        MACI2jMibsAjEIIsjpsKryqrtfVVfHYZjcQ2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B71319F90D;
        Thu, 12 Oct 2017 05:56:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32F0F9F90C;
        Thu, 12 Oct 2017 05:56:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org, Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
Subject: Re: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
References: <20171011180350.99888-1-takahito.ogawa@datagrid.co.jp>
        <xmqqr2u92nkr.fsf@gitster.mtv.corp.google.com>
        <CAC2Jkr+ZDUxd9JcKvVwZqCHVW+Bpp2CbdyehwgKV_Ru-Uqxo8A@mail.gmail.com>
        <CAC2Jkr+zFy9q4Xnzxcqj6rq9+TOs2sO9J5Wx9ccd3oiY4N20uA@mail.gmail.com>
        <CAC2JkrL01G-j+Dxbog9Lq95OKsLpVv6OjV=qg4h0-nwneZ+Oog@mail.gmail.com>
Date:   Thu, 12 Oct 2017 18:56:11 +0900
In-Reply-To: <CAC2JkrL01G-j+Dxbog9Lq95OKsLpVv6OjV=qg4h0-nwneZ+Oog@mail.gmail.com>
        (=?utf-8?B?IuWwj+W3neaBreWPsiIncw==?= message of "Thu, 12 Oct 2017 12:54:32
 +0900")
Message-ID: <xmqqsheozo3o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94C560B0-AF33-11E7-8738-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa217@gmail.com> writes:

> As you point,
>
>     git stash
>
> without any argument is equivalent to both of
>
>     git stash save
>     git stash push
>
> . The original sentence is correct.

OK. =20

Note that I was merely reacting to "Correct it." in your
justification for the change, which made it sound like 'save' was
incorrect.

As a part of a move to deprecate 'save' and nudge users towards
'push', the change does make sense.  I just wanted to make sure the
change and its motivation are presented with honesty ;-).

