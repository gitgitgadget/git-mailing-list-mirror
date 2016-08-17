Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555271FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 17:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbcHQRiw (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 13:38:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbcHQRiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 13:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CDF135CB4;
	Wed, 17 Aug 2016 13:38:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0sXMKvqcuFVj
	9e8wPVUjEZhUmA0=; b=v2ez39sXn9bh4nalM+VaOaAksS8B7T+HiVQTwngSUmyL
	sidqHbOSRc8VspdNhaXroHPINV+P9rg1Qf9j0N4nW05iJfbIT0j2jgva5m7esQZy
	IuLOSvlNIM7sZQfOPqGiSPX5zTIp/fBrwniDdabj1uIpW5qT1IG6hMXNS0W8LD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QsHfH1
	94TNirU5JMiLgcoB+Pqpck6H8ryvvw3C6ubcRzavkxakPv2bTlG4hCEz2YBrG0xJ
	bYd6+38WkQVWFasRYwknWsvS24rpWel4cm7xYscYpnr6e4f4W0rRqhWaHvTkNxGY
	pqoPMNGessPsyQ9KUF2FYvc+vICoibsdrScMs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8623935CB3;
	Wed, 17 Aug 2016 13:38:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 133AB35CB2;
	Wed, 17 Aug 2016 13:38:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.0-rc0
References: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
	<bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de>
	<xmqqoa4uhwcn.fsf@gitster.mtv.corp.google.com>
	<20160817064245.GA5775@tb-raspi>
	<xmqq60qzbebt.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 17 Aug 2016 10:38:48 -0700
In-Reply-To: <xmqq60qzbebt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 17 Aug 2016 08:33:10 -0700")
Message-ID: <xmqqtwej9txz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 753DC51C-64A1-11E6-B5DB-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Is this `text=3Dauto` correct ?
>
> Thanks for spotting a typo.  Definitely.
>
>> I think it should be
>>
>>    used to have the same effect as
>>    $ echo "* text eol=3Dcrlf" >.gitattributes
>
> Thanks.
>
>> # In other words, the `auto` was ignored, as explained here:
>> +   $ git config core.eol crlf
>> +   i.e. declaring all files are text; the combination now is
>> +   equivalent to doing
>> +   $ git config core.autocrlf true
>> +

Just to make sure I got you right, how does this look?

 Documentation/RelNotes/2.10.0.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.10.0.txt b/Documentation/RelNotes/2=
.10.0.txt
index 179e575..ccf5f64 100644
--- a/Documentation/RelNotes/2.10.0.txt
+++ b/Documentation/RelNotes/2.10.0.txt
@@ -235,13 +235,13 @@ Performance, Internal Implementation, Development S=
upport etc.
  * The API to iterate over all the refs (i.e. for_each_ref(), etc.)
    has been revamped.
=20
- * The handling of the "text =3D auto" attribute has been updated.
+ * The handling of the "text=3Dauto" attribute has been corrected.
    $ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
    used to have the same effect as
-   $ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
+   $ echo "* text eol=3Dcrlf" >.gitattributes
    $ git config core.eol crlf
-   i.e. declaring all files are text; the combination now is
-   equivalent to doing
+   i.e. declaring all files are text (ignoring "auto").  The
+   combination has been fixed to be equivalent to doing
    $ git config core.autocrlf true
=20
  * A few tests that specifically target "git rebase -i" have been
--=20
2.10.0-rc0-144-gf47a5f1

