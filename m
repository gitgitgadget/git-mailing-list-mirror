Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93FC0015E
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbjHLAy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjHLAyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:54:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA030C8
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:54:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B94D280B9;
        Fri, 11 Aug 2023 20:54:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=pdrg63fGybC3S
        1IY3+uKRN30tVuNEw6/DjdMwUGq1qo=; b=nk2AAb/Daxcs//Sj/xhwrVD6cFIMq
        /b8ElDfeV/1HwKmnezrfQFJBIQFdkGXlS8BeFLR23izGtIiMItsZlQbDcVkNphog
        MmxZHEi7L1fSph+A1dygal709Bk7aMjGt9mhYwp32jUNZMCZOONUYhFDrHNQITo1
        ZDmq8RPhfJdZEY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45BAB280B8;
        Fri, 11 Aug 2023 20:54:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0761280B7;
        Fri, 11 Aug 2023 20:54:18 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 11 Aug 2023 20:54:15 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Mun Johl <Mun.Johl@wdc.com>
Cc:     git@vger.kernel.org
Subject: Re: "fatal: Not a git repository" issued during 'make' from source
 code
Message-ID: <ZNbYNxEfPYAB3ILb@pobox.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
X-Pobox-Relay-ID: C496967C-38AA-11EE-B878-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Mun Johl wrote:
> I am new to git and am trying to compile git-2.41.0 on RHEL7.

This isn't a direct answer to the question (which Randall
and Junio have covered well), but if you're interested, I
build git-2.41.0 for RHEL/CentOS 7 (as well as newer
RHEL/Rocky/Alma and Fedora release) in the Fedora Copr
("Community projects"):

    https://copr.fedorainfracloud.org/coprs/g/git-maint/git/

I currently maintain the git package in Fedora and try to
ensure it always builds for all supported RHEL releases=B9.

For RHEL/CentOS 7, the steps to install would be:

    yum install yum-plugin-copr
    yum copr enable @git-maint/git
    yum install git

The upside is that it's a current git build packaged the
same as the RHEL package.  The downside is that it updates
the RHEL package, which may not be acceptable in your
environment.

It's certainly a big jump from 1.8.3.1 to 2.41.0.  I had
forgotten how ancient the RHEL 7 git package was. :)

Alternately, building a git package for RHEL 7 from the
current Fedora git package is another option, if you'd
rather have an rpm to install on multiple hosts.

=B9 I may not continue this due to Red Hat's recent decision
  to restrict access to RHEL source code, unfortunately.

--=20
Todd
