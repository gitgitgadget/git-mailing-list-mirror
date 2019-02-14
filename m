Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDF41F453
	for <e@80x24.org>; Thu, 14 Feb 2019 06:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfBNGuE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 01:50:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61012 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfBNGuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 01:50:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7537356EE5;
        Thu, 14 Feb 2019 01:50:02 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=YMmF0EWIeBtqs
        taB7QqTVntn1Vc=; b=sogWRA1nMujTBpx+4xyjnWhyGGdfBlipgohTRlZhLRxUN
        HYiEmFkPlD2ZfT0Kg4aPx3BlU66oc7qDuZjZnEmVXg426BKxMyFhLmeYwfTqbmq2
        lZixhdx5wMxOWbMi2Y1wQIFHtO8mpWHMaO2o0nVsvRTvngSSSmCntuFNM9JA2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=sBlX+AB
        g5wZA5//GdPFmZlc07ynpJXoJnk9RThuoYCL2ytjgk7OOQY1b1kFJxvfTW72JoaT
        hoFpeZ2K1E+HuxisKNGxLvnPdZ7c4aGq8Q/Qp1SBPNwAxt8YhXIo1lI3VctM3LoD
        lJ+lvI2ooBb3wkJ5FzWOMzLjZ7XCayp48l78=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E5F556EE3;
        Thu, 14 Feb 2019 01:50:02 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 414C356EE0;
        Thu, 14 Feb 2019 01:49:59 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 14 Feb 2019 01:49:56 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
Message-ID: <20190214064956.GE16125@zaya.teonanacatl.net>
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
 <20190214035944.GB7209@sigill.intra.peff.net>
 <xmqqzhqy9axy.fsf@gitster-ct.c.googlers.com>
 <20190214055315.GK20578@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190214055315.GK20578@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: BF20681E-3024-11E9-B629-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Yeah, I do have the feeling that not many people really exercise our -r=
c
> candidates. I'm not sure how to improve that. We could try to push
> packagers to make them available (and I think Jonathan already does for
> Debian's "experimental" track).

Similarly, I try to make them available in Fedora's rawhide
channel (as well as less officially as builds for current
stable Fedora and RHEL/CentOS releases=B9).  I don't have a
good sense of how many git users that reaches, but I haven't
had many (or perhaps any?) bug reports from the -rc
packages.

I typically wait for -rc1 to push to rawhide, just to give a
little time to weed out the early issues.  I'd make the
Fedora QA folks mad if I pushed a git update that caused
them too much grief.

Thankfully, I can't recall ever having such a problem
(certainly nothing that most users of git would run into).

> But ultimately I think it is not a packaging/availability question, but
> just that most people do not bother until there is a real release.

Indeed.

=B9 Those "less official" packages are:
  https://copr.fedorainfracloud.org/coprs/g/git-maint/git/ &
  https://copr.fedorainfracloud.org/coprs/tmz/git/

--=20
Todd
