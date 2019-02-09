Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340201F453
	for <e@80x24.org>; Sat,  9 Feb 2019 06:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfBIGsa (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 01:48:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63732 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfBIGs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 01:48:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C34104DC36;
        Sat,  9 Feb 2019 01:48:27 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=L2qbjAEHVjALG
        yGq6TvLhFjL8ho=; b=HlnJacbUgJpuo5T5HcjoaNBs613h8wyFxUa69Vspqs79J
        TMwd1DYnQHOneSkr0WSp8JfY7wHFKpMmOLIOw2B/00zWq0ACRyOz69j4XKc/CgVC
        v9sdCD8BpzSJ6H/+EIiOowTpFNivQs2E+2E5DEyfrSB3pF0sh7kUhujYXzxHC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=epqk12h
        +r/dcsoW6wYYdwaghs6lEiyam8GE4PBGwYE3NCWMzkOD9IN42qBHQ2C/JDBEGmg+
        vkWbI01D+O6F/DdmVhKDnu0eJo9U4jBqtBxV6p5I+7J6joAxvT+r3ErKAnQb3T1q
        /bOvJov3x+pfKpJ6M2QUOtBWWUUI0vobv3Yk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBC464DC35;
        Sat,  9 Feb 2019 01:48:27 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6DB0D4DC33;
        Sat,  9 Feb 2019 01:48:24 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sat, 9 Feb 2019 01:48:21 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Message-ID: <20190209064821.GG30548@zaya.teonanacatl.net>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
 <20190208111002.GU10587@szeder.dev>
 <20190208201128.GD30548@zaya.teonanacatl.net>
 <20190208203009.GC10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190208203009.GC10587@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B2A46E42-2C36-11E9-BAD8-D01F9763A999-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[-cc: linux-kernel & git-packagers]

SZEDER G=E1bor wrote:
> On Fri, Feb 08, 2019 at 03:11:29PM -0500, Todd Zullinger wrote:
>> It made me wonder how I had missed it in my own testing.
>> This one requires SHELL_PATH to be bash, while I only set
>> TEST_SHELL_PATH to bash for the improved -x tracing in the
>> fedora builds.
>=20
> Note that you don't need Bash to use '-x' tracing since a5bf824f3b (t:
> prevent '-x' tracing from interfering with test helpers' stderr,
> 2018-02-25) and the followup commits, except for 't1510-repo-setup.sh'
> (and even t1510 just falls back to ignore '-x' instead of causing
> failures).

Huh, cool.  I somehow missed that nice improvement.  Thanks
for all your fine work on the test suite!  It makes my life
as a packager much better having a robust test suite running
with each build.

--=20
Todd
