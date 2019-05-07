Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A3D1F45F
	for <e@80x24.org>; Tue,  7 May 2019 17:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfEGRqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 13:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEGRq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 13:46:29 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B0E205C9;
        Tue,  7 May 2019 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557251189;
        bh=zucg60GRIA7d95oBxecIeisWjJrzzC11VgMIotdi7f8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=owQexc1ABvQare+94EzMBC/Y+ABvrlCVWMO4n75KVc3er8iBc01GVgyeHSEmCGra3
         1X53lciS8KdSqlWX7dn2skex3/tGec/vXEZUiCtrZhgS3wjBThK7DWJxCnxhqI7o0c
         1+Hy4FrVVbU3fb/gFqTZbHjHeH63qYIHoee7YN8M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqpnounakf.fsf@gitster-ct.c.googlers.com>
References: <20190426235157.106350-1-sboyd@kernel.org> <20190426235157.106350-2-sboyd@kernel.org> <xmqqpnounakf.fsf@gitster-ct.c.googlers.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] format-patch: Make --base patch-id output stable
Cc:     git@vger.kernel.org, Xiaolong Ye <xiaolong.ye@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Message-ID: <155725118838.14659.6891235578536334187@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 07 May 2019 10:46:28 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting Junio C Hamano (2019-05-06 21:38:24)
> Stephen Boyd <sboyd@kernel.org> writes:
>=20
> > I wonder if we need to make some other sort of form of
> > "prerequisite-patch-id:" here and let that be a legacy form of the
> > patch-id so that users know that they have a fixed version of this code?
> > Maybe "prerequisite-stable-patch-id:"? Or we don't have to care because
> > it's been broken for anything besides the most trivial type of patches
> > and presumably users aren't able to use it with 'patch-id --stable'?
>=20
> Do projects actively use -O<orderfile> when generating the patches?
> I had an impression that not many do, and without -O<orderfile> in
> the picture, --unstable/--stable would not matter, no?
>=20
> So, I am not sure if this matters very much in practice.
>=20

I'm not really concerned with projects using -O<orderfile> for patch
generation. I'm concerned that the documentation told users to use
--stable and that didn't work for me when there was more than one hunk
in the patch. This leads me to believe that either I'm doing something
wrong or the other users of this feature have been using --unstable
since this was added to git format-patch.

