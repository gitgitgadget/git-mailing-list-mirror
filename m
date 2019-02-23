Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C13220248
	for <e@80x24.org>; Sat, 23 Feb 2019 17:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfBWRML (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 12:12:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62601 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWRMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 12:12:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9E7957C02;
        Sat, 23 Feb 2019 12:12:06 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=Y0TVID5hek8Om
        ioBtKBZv1yFlGs=; b=efnDckPHUTHzjWEzL94LAZT7wzmaOpqmmHSBzASdXONLL
        Hjg8SzEbUJZFiKW7iiRVbyIygXyN0lFeMWfYI3kE3xbLM8QiVamzmFmYW8hMJKOo
        5jbF6/7E6jRq2h7E/TGFNLnSoIEax+ytXuWLFDzRseb3mMYZaviLEWrb1tiA7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=hqqMNc5
        HIGWujnvBKv85aR2AAo6BYv2VBvB1c0/UzHLUN4P5dev9WE6qyfo5A/L+aZWJ6+V
        VIKJ2gxMAQNTR3TlmPqc2R06DgAeO5ortHHPsahyt1qImEb5HZse22IUGzZsC5Du
        9ctwMvPoqdUkuPS9U5w3cNLJ1EA+3ngNCz/g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C29E457C01;
        Sat, 23 Feb 2019 12:12:06 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0C5857C00;
        Sat, 23 Feb 2019 12:12:03 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sat, 23 Feb 2019 12:12:00 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: on fedora, "man gitweb" exists but actual gitweb command is
 missing
Message-ID: <20190223171200.GB16125@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1902230756280.24879@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1902230756280.24879@localhost.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 23E7F2E2-378E-11E9-8526-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:
>=20
>   not so much a git issue as what looks like a fedora packaging issue.

Yeah, it's just a minor packaging issue.  The gitweb
manpages are included in the main git package rather than in
the gitweb package with the rest of the gitweb files.  I'll
fix that for future releases and when f29 is updated to 2.21
it will pick that up=B9.

Since gitweb requires git, you'd be sure to have the
documentation after installing gitweb.  If we made it
possible to install gitweb without getting the
documentation, that would be more annoying. :)

=B9 https://src.fedoraproject.org/fork/tmz/rpms/git/c/0d9ad786

> it took only a few seconds to determine that fedora bundles that
> functionality in two separate packages which are not dependencies of
> "git": "gitweb" and "git-instaweb" (output abbreviated):
>=20
>   $ sudo dnf install git-instaweb
>   ...
>   Installing:
>    git-instaweb
>   Installing dependencies:
>    gitweb
>    perl-CGI
>=20
> and now "git-instaweb" works fine.
>=20
>   the question is, is it not inconsistent for fedora's basic "git"
> package to include the man page for gitweb, without including the
> corresponding functionality? is this something i should submit a
> fedora bugzilla report for? or am i misunderstanding something?

If I hadn't seen this thread, then a report in the fedora
bugzilla would be the way to go to ensure one of the fedora
git maintainers noticed it.

Thanks,

--=20
Todd
