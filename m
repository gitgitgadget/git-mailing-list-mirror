Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C81C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 13:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbhLWNuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 08:50:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348462AbhLWNuo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Dec 2021 08:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640267443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=HX7T6bml/0cL3Nkj6gaCBpynErPI+1FuaP6+rho9weI=;
        b=QMtXqBErcqWpyAd1+evpyR1rNFzf1fL/WZVHhgMhxLPF9G7EoAK7tRTpuVODiyDdocWmKK
        qYlJs8SA40i45KTNoaSn7PxtoJ/XwmtAGIHg/a9S+eTmjSVrzL18AJHqhPcUwannZYQYM7
        K8JlKaqLhvL+FYge3SwhtOoHCd0pEdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-V4NMN0gYORKJSicW2MV99Q-1; Thu, 23 Dec 2021 08:50:40 -0500
X-MC-Unique: V4NMN0gYORKJSicW2MV99Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB28110168C3;
        Thu, 23 Dec 2021 13:50:38 +0000 (UTC)
Received: from localhost (unknown [10.39.194.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 212F75D6CF;
        Thu, 23 Dec 2021 13:50:37 +0000 (UTC)
Date:   Thu, 23 Dec 2021 13:50:37 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Review process improvements
Message-ID: <YcR+rZ7YznQlTuRf@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Iz9Er4V2afVSVa7Z"
Content-Disposition: inline
In-Reply-To: <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Iz9Er4V2afVSVa7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I'd like to also mention that I'm hoping to add a few more features to b4 that
> will hopefully improve the patch submission process for folks.

This looks excellent! I wanted to mention a few features that have been
popular in the git-publish patch series management tool
(https://github.com/stefanha/git-publish/) in case you want to include
something similar in b4:

- "Profiles" (.gitpublishprofile or stored in .git/config) with To and
  CC addresses, --subject-prefix, cover letter templates, etc. The
  default profile is automatically loaded when you run "git publish". If
  the git repo you're working on includes a default profile then you
  don't need to specify any command-line options to send a correctly
  formatted patch series to the maintainers! A great help for one-off
  contributors but also a time-saver for regular contributors.

- An interactive mode that lets you inspect the final patch series and
  edit the CC list. Avoids mistakes and embarassment :).

- Saving the CC list between revisions (v2, v3, etc).

- Sending pull requests (for sub-maintainers) because there are times
  when pull requests also need a v2 or even a v3 ;). The workflow is
  basically the same as sending patch series.

- githooks(5) before sending patches series and pull requests. Useful
  for coding style and patch series linters.

The git-publish man page is here if you want to read more:
https://github.com/stefanha/git-publish/blob/master/git-publish.pod#quickstart

Stefan

--Iz9Er4V2afVSVa7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHEfqwACgkQnKSrs4Gr
c8iCsgf/ZW3jHoB+YAnHS0KAZle7Xg/m8Ql5LKA/4RIr2CLgxeHhBhrq9AXR0t4/
pK83huJ9nW1xuhbFjcztrIcXqyjv+YJl4nZzJc0xIQsEy3E2KlfAw+q52YB21Sih
o8qxKb+c49PR3hRAVH/PZjPrZSewozq8VII1d8aATdpmNcp1yzGT4wGlFSdCHPVR
y3EMUMK7NUCB1JyZeF09WxsoMbALkDLmHvK7aNLRVU1fCYPT3qHq7H2JuXoFk8q5
IWqMeeCEL0psOZ4GtqI5Czbd+4C0U+4960X3wzyIa4wzAo3Zc8sriwxtLsP+Wukv
DwgBxsNezhTtE/oMVyGdMsidFs8TNg==
=Q7R5
-----END PGP SIGNATURE-----

--Iz9Er4V2afVSVa7Z--

