Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237991F462
	for <e@80x24.org>; Tue, 28 May 2019 00:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfE1AFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 20:05:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64370 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfE1AFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 20:05:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E28F7662AC;
        Mon, 27 May 2019 20:05:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=4wmuMbIFhbV0y
        lNl8Vrd7/w5uII=; b=jRZS24Zb1awCj9zZ0EaS3VzJ/5gD9IKTzhCrmlvf1zieN
        Tzug+uqcWM/TuAA3IaDasfLBbWZ5sktsE6nfF19c38CL99e4CPEPfrWlT2jpntQ2
        ZXLOOJ3bAnSxt8Om/uItQ1ZLGWfKy11cAsSL4T9m2X650vkCZkVfcDMnJwEzTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=ZSM7Pvf
        UfKWpIafVlBEqDoFAn317Idt20vTE+YhwAxcWzvOIfwEtrAkMUrW0PhIC7mjLHRa
        m6ZywtZuQQ/KDdgKtfFiDnaouRN+i4nM6Ykyo2hVfztxhkFpOebx2Qk3/LVPEpjG
        2dcLobe7vQIjdRKMCUEQiQeiGRxxqmTmaPc0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF59D662A9;
        Mon, 27 May 2019 20:05:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DCB1662A7;
        Mon, 27 May 2019 20:05:47 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Mon, 27 May 2019 20:05:44 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Chris Mayo <aklhfex@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190528000544.GX3654@pobox.com>
References: <20190526172242.13000-1-aklhfex@gmail.com>
 <20190527193517.GA22013@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190527193517.GA22013@dcvr>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 5883F3BA-80DC-11E9-B68E-8D86F504CC47-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote:
> Chris Mayo <aklhfex@gmail.com> wrote:
>> git-send-email uses the TLS support in the Net::SMTP core module from
>> recent versions of Perl. Documenting the minimum version is complex
>> because of separate numbering for Perl (5.21.5~169), Net:SMTP (2.34)
>> and libnet (3.01). Version numbers from commit:
>> bfbfc9a953 ("send-email: Net::SMTP::starttls was introduced in v2.34",
>> 2017-05-31)
>=20
> No disagreement for removing the doc requirement for Net::SMTP::SSL.
>=20
> But core modules can be split out by OS packagers.  For
> Fedora/RH-based systems, the trend tends to be increasing
> granularity and having more optional packages.
>=20
> So I think documenting Net::SMTP (and Net::Domain) as
> requirements would still be good, perhaps with a note stating
> they're typically installed with Perl.

I didn't know that git-send-email.perl could take advantage
of Net::SMTP::starttls until I read this.

[Adding Dennis and Jonathan as the authors of 0ead000c3a
("send-email: Net::SMTP::SSL is obsolete, use only when
necessary", 2017-03-24) bfbfc9a953 ("send-email:
Net::SMTP::starttls was introduced in v2.34", 2017-05-31),
respectively.]

The current Fedora and Red Hat package have a requirement on
Net::SMTP::SSL from long, long ago=B9.  As I looked at whether
I could remove that (or more accurately, replace it with
IO::Socket::SSL which is needed for Net::SMTP to handle
starttls), I noticed that on RHEL7 the Net::SMTP version was
2.31, but starttls support has been backported=B2.

I wonder if it's (separately from this change) worth
adjusting the conditional which sets $use_net_smtp_ssl to
use "Net::SMTP->can('starttls')" rather than a strict
version check?  (It might not be if using 'can' is too
fragile or would only benefit the Red Hat 7 packages which
likely won't officially be updated to a newer git with such
a change.)

Something like:

diff --git i/git-send-email.perl w/git-send-email.perl
index 24859a7bc3..84ac03994d 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -1465,7 +1465,7 @@ sub send_message {
 		}
=20
 		require Net::SMTP;
-		my $use_net_smtp_ssl =3D version->parse($Net::SMTP::VERSION) < version=
->parse("2.34");
+		my $use_net_smtp_ssl =3D Net::SMTP->can('starttls') ? 0 : 1;
 		$smtp_domain ||=3D maildomain();
=20
 		if ($smtp_encryption eq 'ssl') {

=B9 https://bugzilla.redhat.com/443615
=B2 https://bugzilla.redhat.com/1557574
  https://git.centos.org/rpms/perl/c/13dfe3?branch=3Dc7

--=20
Todd
