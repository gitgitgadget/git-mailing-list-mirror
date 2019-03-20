Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220A220248
	for <e@80x24.org>; Wed, 20 Mar 2019 18:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCTSce (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 14:32:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51989 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCTScd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 14:32:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACD451383FE;
        Wed, 20 Mar 2019 14:32:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=Tr4QBL7QvbNAx
        cOIHn4ZLg4/H0A=; b=XZoR8Sv83pqKnZhdAO5Ql1103citC59qg3k3vub0tWP0M
        B2/I/IQOQnlXgOt+/L3hhKOnYWfkQagDcRItuEQ3Yg+iBWbFlN0uzbj16hurLGYm
        ivrNgBomdzLQmbTl2wa/FlhB0Jv0ySR5HrNbee6LaOOaemMsO1gO6pcoRdxkoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=UsTMfb7
        uesfVoo7so9K8LyWLR0G+co5+Td3UGUYDHVxXQCsglFwlnNsDJhKIv6jR50pB7sU
        w41gfP3k/BblbA9i49DDdD5YJv7q3mt/UV9+zNk64KklilROYppgA0OVRWzhxu56
        T5ynl+DxmVtoWYjEm9ARRMyfquJI8KNwAVPk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A50F31383FD;
        Wed, 20 Mar 2019 14:32:31 -0400 (EDT)
Received: from pobox.com (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24FED1383FC;
        Wed, 20 Mar 2019 14:32:31 -0400 (EDT)
Date:   Wed, 20 Mar 2019 14:32:29 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190320183229.GK31362@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190319024645.GA6173@sigill.intra.peff.net>
 <20190319033023.GA25772@sigill.intra.peff.net>
 <CAN0heSo92kS6mhYH0HM-z9jOKNR0wzDynu3bnq=FtBc4_+zCpQ@mail.gmail.com>
 <20190319074321.GA2189@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190319074321.GA2189@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 858E99E2-4B3E-11E9-8438-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Mar 19, 2019 at 08:12:54AM +0100, Martin =C5gren wrote:
>=20
>>> I just tried with asciidoc 2.0.0.rc.2, which came out last week. It d=
oes
>>> seem to work from the command line:
>>>
>>>   $ make USE_ASCIIDOCTOR=3DYes \
>>>          ASCIIDOC_DOCBOOK=3Ddocbook5 \
>>>          ASCIIDOC=3D'asciidoctor -amansource=3DGit -amanmanual=3D"Git=
 Manual"' \
>>>          git-add.xml
>>>   $ sed -n '/refmeta/,/refmeta/p' git-add.xml
>>>   <refmeta>
>>>   <refentrytitle>git-add</refentrytitle>
>>>   <manvolnum>1</manvolnum>
>>>   <refmiscinfo class=3D"source">Git</refmiscinfo>
>>>   <refmiscinfo class=3D"manual">Git Manual</refmiscinfo>
>>>   </refmeta>
>>=20
>> No such luck with asciidoctor 1.5.5. Seems like it really wants
>> "manpage" before it considers these attributes.
>>=20
>> (That's still me holding the tool, so factor that into it.)
>=20
> The refmiscinfo stuff didn't arrive until asciidoctor v1.5.7.

Now I don't feel as bad that I didn't find any good way to
handle refmiscinfo when I first tried to use asciidoctor in
November 2017 at least.

This made me look closer at the fedora asciidoctor packages.
They have been stuck on 1.5.6.1.  So all my recent testing
has been with 1.5.6.1.

I spent some time yesterday working toward getting the
fedora packages updated to 1.5.8.  With luck that will reach
the stable updates channels before too long.

(I'm guessing the upcoming 2.0 release won't be suitable as
an update for released fedora versions, being a major
release with potentially backwards-incompatible changes.)

There are differences in the output from 1.5.6.1 and 1.5.8,
but I haven't looked closely yet.

--=20
Todd
