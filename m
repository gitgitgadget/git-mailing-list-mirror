Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5EF1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbdJ3MSC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 08:18:02 -0400
Received: from marcos.anarc.at ([206.248.172.91]:42762 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbdJ3MSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:18:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 2F7FE1A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace and skip special namespaces
In-Reply-To: <CAPig+cSMRG0_kPpgFv5hco9Lk9jfYmJm-+rkQaw6vNQTdoEg7Q@mail.gmail.com>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-5-anarcat@debian.org> <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com> <87y3nt73uy.fsf@curie.anarc.at> <CAPig+cSMRG0_kPpgFv5hco9Lk9jfYmJm-+rkQaw6vNQTdoEg7Q@mail.gmail.com>
Date:   Mon, 30 Oct 2017 08:17:58 -0400
Message-ID: <87she07rt5.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-29 23:52:16, Eric Sunshine wrote:
> On Sun, Oct 29, 2017 at 10:43 PM, Antoine Beaupré <anarcat@debian.org> wrote:
>> On 2017-10-29 15:49:28, Eric Sunshine wrote:
>>> This may be problematic since get_mw_namespace_id() may return undef
>>> rather than a number, in which case Perl will complain.
>>
>> Actually, get_mw_namespace_id() doesn't seem like it can return undef -
>> did you mistake it with get_mw_namespace_id_for_page()?
>
> Hmm, no. What I see in the function is this:
>
>     my $id;
>     ...
>     if ($ns->{is_namespace}) {
>         $id = $ns->{id};
>     }
>     ...
>     return $id;
>
> So, $id starts undefined and is assigned only conditionally before
> being returned, but perhaps I'm missing some subtlety.

Ah yes, you're probably right there.

-- 
During the initial stage of the struggle, the oppressed, instead of
striving for liberation, tend themselves to become oppressors The very
structure of their thought has been conditioned by the contradictions of
the concrete, existential situation by which they were shaped. Their
ideal is to be men; but for them, to be men is to be oppressors. This is
their model of humanity.
                        - Paulo Freire, Pedagogy of the Oppressed
