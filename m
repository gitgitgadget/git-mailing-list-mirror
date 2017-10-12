Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B691FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 05:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdJLFmd (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 01:42:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53217 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750758AbdJLFmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 01:42:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EEAA9BD27;
        Thu, 12 Oct 2017 01:42:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uMT+YTzcUcgGDW8+FrMvOh4dENY=; b=GiD+g8
        C93+hjcIoT0pKJaj3xaypgsUyc4MYOmSzx4DokCRA29+xvUSsU+Zh45GlpEaBC+D
        rTrgSp98Hq9/5AqQecvxtvMxHxv9N0miO1COtM4qwCi2Nyz+8jVdUusXfaid46l7
        jMcDhopCAdAM78g/BmhckbtB847xkThiGIN5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x4Nh3SdvtMI/KCDnwPJczv+gxrFK1IS7
        SIvwiO5XdQyAXAXXCSX3kkfznGrNon6T3wZCftf8UQ+5nqbcJq7IG6ek45U7w90d
        o4v4g479VGQhLi4SCYOCovEKkzUH4jxaMfSrFEJDlfxu9RBkUlXuDIJ3em0fzO9s
        /Ak74vTi43s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55E169BD26;
        Thu, 12 Oct 2017 01:42:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDF009BD25;
        Thu, 12 Oct 2017 01:42:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH] pull: pass --signoff/--no-signoff to "git merge"
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
        <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com>
        <20171012053002.GZ11004@valgrind.tremily.us>
Date:   Thu, 12 Oct 2017 14:42:30 +0900
In-Reply-To: <20171012053002.GZ11004@valgrind.tremily.us> (W. Trevor King's
        message of "Wed, 11 Oct 2017 22:30:02 -0700")
Message-ID: <xmqq60bk2a7t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2421CCEA-AF10-11E7-8C31-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Oct 12, 2017 at 10:17:51AM +0900, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> 
>> > Following 09c2cb87 (pull: pass --allow-unrelated-histories to "git
>> > merge", 2016-03-18) with the tests also drawing on 14d01b4f (merge:
>> > add a --signoff flag, 2017-07-04).
>> 
>> I cannot find a verb in the above.
>
> I'd meant it as either a continuation of the subject line, or with an

Never do that.  The title should be able to stand on its own, and
must not be an early part of incomplete sentence.

> Much nicer, thanks.  I'll add a patch to v2 to make the same change to
> t7614.
> ...
> Sounds good.  I'll add a patch to v2 to make the same change to the
> existing t5521 --allow-unrelated-histories test.

Please don't, unless you are actively working on the features that
they test.  We do not have infinite amount of bandwidth to deal with
changes for the sake of perceived consistency and no other real
gain.


