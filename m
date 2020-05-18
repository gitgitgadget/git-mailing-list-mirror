Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9AEC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ED82075F
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFj3UsL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgERUSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:18:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53294 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgERUSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:18:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28F8CC992E;
        Mon, 18 May 2020 16:18:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=SOgP6dhnoxrsZ
        3tj8vuoMHIXMEo=; b=iFj3UsL4HeViBoZVsitW98+jfL4VaTkFGrjvtWzr7PDr3
        EX/a8y0W+8g++gIdaPEak/igzIMrzgRm+HPWBU4f9n7AFt2S6WHPSyO/umBydH2r
        3DZdNaI/lUi6HTdI1Be6lZJhT0HLNpqc8fPR01xyN+R4+Xe3ffWcnSCr6bCo/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=Av6zOI6
        Z2CUMHKzBB5qO4w54T3MIJNY5xbbUivwmvZuR5eyr4H5nNkzbM33+o6LE92jPVPb
        kcsWqMNSNf2cn8zuUbAPRMcecc/fLLT1cNxjikMY3WsGDjo5lKn3y+PGi1dGkSJ4
        oDErwzBr2mu2T+l/QEPEWzzwygrZqGKWSSp8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20C0FC992D;
        Mon, 18 May 2020 16:18:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.10])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ED6ACC992C;
        Mon, 18 May 2020 16:18:30 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Mon, 18 May 2020 16:18:28 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] git-bugreport.txt: adjust reference to strftime(3)
Message-ID: <20200518201828.GW24220@pobox.com>
References: <20200518193736.19320-1-tmz@pobox.com>
 <xmqqa7252f5t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqa7252f5t.fsf@gitster.c.googlers.com>
X-Pobox-Relay-ID: BDF348BE-9944-11EA-96B5-8D86F504CC47-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>=20
>> The strftime(3) man page is outside of the Git suite.  Refererence it =
as
>> we do other external man pages and avoid creating a broken link when
>> generating the HTML documentation.
>>
[...]
> Thanks.  This was noticed elsewhere in a different thread but let's
> take this as a patch independent from the other documentation topic.

Ahh, I have gotten behind on my reading (and only just got
to testing rc0=B9).  I'm glad this unintended redundancy
worked out well, by chance.

Thank you.

=B9 FWIW, this was the only issue I found in building for the
  various architectures Fedora supports: aarch64, armv7hl,
  ppc64le, x86, x86_64, and, last -- but by far the most
  likely to turn up issues -- s390x.

--=20
Todd
