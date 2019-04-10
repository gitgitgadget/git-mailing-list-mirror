Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20D220248
	for <e@80x24.org>; Wed, 10 Apr 2019 00:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDJAlZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 20:41:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63931 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDJAlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 20:41:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E3F0533E4;
        Tue,  9 Apr 2019 20:41:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=7w34on+6TH1mk
        IsxHc0MD0rfD+E=; b=xR3GLNeq0AenkqCGUlRWej70nz1MuS4sAmKLkx+UoRmfz
        qnak3TvGXveXMIkHNjiwMlwK4MiQCjBykZPaFOqAYJWwTSJBFuh3yr8OsV0vyoBG
        ej0QeID6YPmzdnu6acsJIft2vmQAm5ucJIevqpUBjmsjcldcwYUOTcPxb+Z7sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=SZlZvnX
        SP3zbRL3uuYVwywRQWZkVk7rfou1xJSDcD+vLwMZwpjiTwG4AT0nSQAh4JtAgjeY
        e+dnqQXexQPY0Tadk8ZsPFM6BmRD3xCr/KN7z8NZk6ukCIIuhfP5yfxWBcO6YgfV
        1HIFieg4Tt2ukDuoZtuBdk2FvhhP89n8tcqc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FF54533E3;
        Tue,  9 Apr 2019 20:41:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 293CE533DD;
        Tue,  9 Apr 2019 20:41:20 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 9 Apr 2019 20:41:17 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/git-svn: improve asciidoctor
 compatibility
Message-ID: <20190410004117.GM3654@pobox.com>
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
 <20190405225115.3882-3-tmz@pobox.com>
 <CAN0heSpL_pQMtDaEdDgcsC_Sso45owHjRttrdp7cQdYOb7i9BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAN0heSpL_pQMtDaEdDgcsC_Sso45owHjRttrdp7cQdYOb7i9BA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 5BE7B182-5B29-11E9-9ED4-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C5gren wrote:
> I think what's happening could be related to the fix in the first patch=
.
> There, it's ok to explicitly escape only the first '. The second one is
> matched to it and gets escaped implicitly. Something like that could be
> happening here, too, just that we don't want it to. (Should we escape
> the implicit escaping? ...) Just speculation, though.

It could well be a similar issue.  I think I tried adding an
escape to the existing \* and/or to elsewhere in the block
of text, without success.  But I didn't try very hard
though, as adjusting the test to use `*` seemed like an
improvement.

Thanks,

--=20
Todd
