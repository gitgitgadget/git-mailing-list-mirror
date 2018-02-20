Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEE51F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeBTTij (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:38:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54248 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeBTTih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:38:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 940EBBCBD0;
        Tue, 20 Feb 2018 14:38:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=DHTK57re2S5Ei
        HTV7Zowurshlww=; b=X/ZfNrD8n2OYelAc3FFDY43lo3ag0yjrYSfBgl7vFd3W2
        FmdRb3w2+HFkI2LdQZOywYm0aSQ3ExJ7N4jsqAuuJRzQM3DOYNchOTYPZZyv/sr/
        fSlTdanIS2Mv1fyywOEnEA+tEUGPtpiEdwWySu1SIqDJPXjus6OxktU1GZJpVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=al5MsUy
        GSpJ4d9QKVHq7EP10o8lDHDiiRdQAduQIw5phdHue0ChTWk/zn9MOkQyqrD+z15n
        Or4RYw24w54ZbUE+rANhAkzwZUrKLFflsUGGLQyM8pcf3uQzUp/ZCv7Fu/uA/czY
        FrlpnQ13GvrhcE8w0GcxuaDz4jkHNgAC+fbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B725BCBCF;
        Tue, 20 Feb 2018 14:38:36 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10C6FBCBCE;
        Tue, 20 Feb 2018 14:38:36 -0500 (EST)
Date:   Tue, 20 Feb 2018 14:38:34 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     marmot1123 <marmot.motoki@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2] Fix misconversion of gitsubmodule.txt
Message-ID: <20180220193834.GM27038@zaya.teonanacatl.net>
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
 <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: A47ECCEA-1675-11E8-83A1-692D1A68708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

marmot1123 wrote:
> In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions =
`submodule=E2=80=99s`.
> It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.

If replacing the non-ASCI apostrophes is the goal, aren't
there a number of others in the same file worth cleaning up
at the same time?

$ grep '=E2=80=99' Documentation/gitsubmodules.txt
the submodule=E2=80=99s working directory pointing to (i).
superproject expects the submodule=E2=80=99s working directory to be at.
When deinitialized or deleted (see below), the submodule=E2=80=99s Git
but no submodule working directory. The submodule=E2=80=99s Git directory
the superproject=E2=80=99s `$GIT_DIR/config` file, so the superproject=E2=
=80=99s history
The deletion removes the superproject=E2=80=99s tracking data, which are
The submodule=E2=80=99s working directory is removed from the file

This does seem to be the only file which includes the
non-ASCII apostrophe under Documentation.

Some tests include it (intentionally) as does
contrib/credential/netrc/git-credential-netrc.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The direct use of physical force is so poor a solution to the problem
of limited resources that it is commonly employed only by small
children and great nations.
    -- David Friedman

