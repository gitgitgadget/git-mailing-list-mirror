Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301DCC433F1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C844223B0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dkz3V+PB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgGNTF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:05:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58412 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgGNSxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74507D55DC;
        Tue, 14 Jul 2020 14:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BliOPdSzyWyW
        Mg3p9XV+r2aTqQw=; b=dkz3V+PBy4OYLu2fUerLmg/BNYc02c5eFKq+HRw2w3Rd
        K2Ml/NXhADXn01RyLh0tS2UdEjOFmbORyjluCs4uGR/9RSkB+OqmEEV1Cvu67Qdz
        2HuG0J67IrQluWv2e/MA9nJVjqmAevBICA/v/oGnvgmCJ7Nevmo7mvUT/4pHUgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gK+XrX
        DlXG+WBp+J14MoK/0+1CvZLTUNI3Am49L/ZaZZdkSsTm/Z6PKEP+83wb0Fo29d4k
        RhfViJBn/0mNwZ67LMCueD8y9eMbmqiotW/ZrdLT7l9orcQdWUe7ebGI9ioPLBqJ
        NHFctp2FAOd+z47p+pJBm13xAxMCIwaDQQjkI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B56CD55DB;
        Tue, 14 Jul 2020 14:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1295D55DA;
        Tue, 14 Jul 2020 14:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Antw: [EXT] Re: Help understanding unexpected diff output
References: <5F0C38BB020000A100039FF0@gwsmtp.uni-regensburg.de>
        <5F0C38BB020000A100039FF0@gwsmtp.uni-regensburg.de>
        <xmqqsgdvo3ec.fsf@gitster.c.googlers.com>
        <5F0D7252020000A10003A03E@gwsmtp.uni-regensburg.de>
Date:   Tue, 14 Jul 2020 11:53:43 -0700
In-Reply-To: <5F0D7252020000A10003A03E@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Tue, 14 Jul 2020 10:52:34 +0200")
Message-ID: <xmqqr1tekjwo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5855234C-C603-11EA-8501-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

>> I would imagine that the answer would still be a very similar looking
>>=20
>>     =E2=80=91=E2=80=91=E2=80=91 a/0/...
>>     +++ b/0/...
>>     @@ =E2=80=915,12 +5,6 @@
>>      olcDatabase: {1}hdb
>>      olcDbDirectory: /var/lib/ldap
>>      olcSuffix: dc=3D...=20
>>     =E2=80=91olcAccess: {0} ...
>>     =E2=80=91olcAccess: {1} ...
>>     =E2=80=91olcAccess: {2} ...
>>     =E2=80=91olcAccess: {3} ...
>>     =E2=80=91olcAccess: {4} ...
>>     =E2=80=91olcAccess: {5} ...
>>     olcLimits: {0}dn.exact=3D....
>>      olcRootDn: cn=3DAdmin,dc=3D...
>>      olcRootPW: {SSHA}yZ...
>>     @@ =E2=80=9152,6 +46,12 @@
>>      entryUUID: ...
>>      creatorsName: cn=3Dconfig
>>      createTimestamp: ...
>>     =E2=80=91entryCSN: ...
>>     +olcAccess: {0} ...
>>     +olcAccess: {1} ...
>>     +olcAccess: {2} ...
>>     +olcAccess: {3} ...
>>     +olcAccess: {4} ...
>>     +olcAccess: {5} ...
>>     +entryCSN: ...
>>      modifiersName: cn=3Dconfig
>>     =E2=80=91modifyTimestamp: ...
>>     +modifyTimestamp: ...
>>=20
>> with identical "olcAccess: {$n}" lines removed from earlier part the
>> file and added to the end of the file.
>>=20
>> So I am not sure what you are asking.  It would not be correct to show
>> something like
>
> According to my eyes (just using Emacs to make sure) those olcAccess li=
nes
> "numbered" 0 to 3, and 5 should be "context lines" as they are not chan=
ged.

And the "slightly different" example I asked you about has {4} in
both blocks identical, you are arguing that these 6 lines all should
appear as context?

It certainly is possible but then the patch would look quite
different.  As "olcAccess: {0}" line in the preimage (i.e. a/)
appears at line 8, but that same line appears in the postimage
(i.e. b/) at line 49, such a patch that match these two olcAccess
blocks as unchanged MUST delete many lines that come after
"olcAccess: {5}" in the preimage (i.e. starting at line 14 with
olcLimits, line ending at entryCSN: at line 55 must be removed,
because they used to appear immediately after "olcAccess: {5}" in
the preimage a/, but in the postimage b/, none of tme appear after
the "olcAccess: {5}" that you claim to be common and unchanged (in
the postimage, instead you have only four lines that has"entryCSN:",
"modiferName", etc. before the end of the file).

Of course, these lines in the line range 14-55 actually are the ones
that did not change, as we can see above, so if you insist that you
must keep the 6-line "olcAccess" block as common and unchanged,
because your desired patch is deleting them from the pre-image after
"olcAccess: {5}" line, your desired patch must be adding them back
to the postimage somewhere (namely, before "olcAccess: {0}" line).

Such a patch is also a valid one in that it expresses the difference
between a/ and b/ in terms of a sequence of "delete these lines from
here" and "insert these lines to here", but it would be far less
interesting than what we see above.  Instead of "we deleted 6 lines
near the beginning of the file" plus "then added 6 lines near the
end--ah, these 6 lines by the way are identical", you would instead
say "we deleted the block of lines 14-55 that appear immediately
after olcAccess:{5}" plus "we inserted the identical block of lines
immediately before olcAccess{0}".  And you'd complain in the
opposite way: "These lines are identical but appear in different
locations in the preimage and the postimage -- why aren't they shown
as context lines?"
