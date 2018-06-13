Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B017F1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbeFMDI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:08:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58884 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeFMDI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:08:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 969DEFD2B0;
        Tue, 12 Jun 2018 23:08:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=cv7+hKfw/jJFh
        Svmqwwf4l2xaGo=; b=aLItFxAjpgiYKrpBlBRQk2ZAxBoXpfwnbSHDkPK/Veq2f
        oQTsCzcQ7NAq24WhPkpKqsr2QJyu3Qlw15KR3y89eMoMG50wLKlnzDYOOgQPHcbs
        zykWvI5BYCYQRFspeAwrDMtxeUFuLV5WOcLDJqVu76b+G8pNuCAgV1YsTRAvBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=U1XVdRr
        ulOAavrGoO+gioZB1i96BMYTPzhlTpxJabkiy+ws6cLCN0r7R55v0fTeEAJ5dKW+
        40+LmuFg55NuUxGj6wW4J46OJyAfcLniaorai06LKZUKaMncVdEUzigjyyF5ljgn
        SA/8zMOnR8B5J9RQZsozxYD+CivZkLuOYPIM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C6A1FD2AF;
        Tue, 12 Jun 2018 23:08:54 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A70CFD2AE;
        Tue, 12 Jun 2018 23:08:54 -0400 (EDT)
Date:   Tue, 12 Jun 2018 23:08:52 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Luis Marsano <luis.marsano@gmail.com>, git@vger.kernel.org,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [RFC PATCH 0/2] contrib/credential/netrc Makefile & test
 improvements
Message-ID: <20180613030852.GG3094@zaya.teonanacatl.net>
References: <20180607051958.759-1-tmz@pobox.com>
 <CAHqJXRHGq9ofPcCzffUbTmuL6fuoB=33aZnwqNdqYy+nAVA_gw@mail.gmail.com>
 <20180610022802.GX3094@zaya.teonanacatl.net>
 <87efhfvxzu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87efhfvxzu.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 1ABEAD46-6EB7-11E8-88E4-44CE1968708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

=C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> On Sun, Jun 10 2018, Todd Zullinger wrote:
>=20
>>> I added 'use autodie;' without realizing it had external dependencies=
.
>>> According to the documentation
>>> http://perldoc.perl.org/autodie.html
>>> it's a pragma since perl 5.10.1
>>> Removing 'use autodie;' should be fine: it's not critical.
>>
>> I should clarify that part of why autodie isn't in my build
>> environment is that the Fedora and RHEL7+ perl packages
>> split out many modules which are shipped as part of the core
>> perl tarball.  So while all the platforms I care about have
>> perl >=3D 5.10.1, the Fedora and newer RHEL systems have the
>> autodie module in a separate package.
>>
>> That said, the INSTALL docs still suggest that we only
>> require perl >=3D 5.8, so if autodie is easily removed, that
>> would probably be a good plan.
>=20
> The intent of those docs was and still is to say "5.8 and the modules i=
t
> ships with".
>=20
> This was discussed when 2.17.0 was released with my changes to make us
> unconditionally use Digest::MD5:
> https://public-inbox.org/git/87fu50e0ht.fsf@evledraar.gmail.com/
>=20
> As noted there that's not some dogmatic "RedHat altered perl so we don'=
t
> care about them", but rather that in practice this doesn't impact users
> negatively, so I think it's fine.

Yeah, that was my understanding.  I only included the
information on why it was missing from my build environment
despite having perl-5.10.1 was due to the Fedora/Red Hat
packaging.  I agree that any issues which fall out of those
packaging differences are on Fedora/Red Hat packagers to
fix.

(Which should all be relatively trivial, as the perl modules
contain a 'Provides: perl($module)'.  That allows dnf|yum
install 'perl(autodie)' to easily pull in the right package.
And the rpm perl dep generator creates a 'Requires:
perl(autodie)' when is sees 'use autodie'.)

Sorry if I muddied the conversation with that tangential
info. :)

>> =C6var brought up bumping the minimum supported perl to 5.10.0
>> last December, in <20171223174400.26668-1-avarab@gmail.com>
>> (https://public-inbox.org/git/20171223174400.26668-1-avarab@gmail.com/=
).
>> The general consensus seemed positive, but I don't think
>> it's happened.  Even so, that was 5.10.0, not the 5.10.1
>> which added autodie.
>=20
> Right, this doesn't apply to autodie. Looking at
> https://www.cpan.org/ports/binaries.html there were a lot of releases
> that had 5.10.0, not *.1.
>=20
> Also git-credential-netrc is in contrib, I don't know if that warrants
> treating it differently, I don't use it myself, and don't know how much
> it's "not really contrib" in practice (e.g. like the bash completion
> which is installed everywhere...)>

Indeed, that's a fine question.  All the platforms I care
about have 5.10.1 or newer, so either way works for me.

> But yeah, skimming the code it would be easy to remove the dependency.

I wrapped up the changes from Luis which replace my 2/2 "use
in-tree Git.pm for tests" and to ensure the tests exit
properly on failures.  I'll send those out now in the hope
that it saves a little effort in moving these minor fixes
forward.

As far as removing the autodie dep, is there anything more
to that than dropping the 'use autodie' line?  It looks like
doing so leaves us no worse than we were before, but I
haven't written any perl in a long time.

Thanks,

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ocean, n. A body of water occupying about two-thirds of a world made
for man -- who has no gills.
    -- Ambrose Bierce, "The Devil's Dictionary"

