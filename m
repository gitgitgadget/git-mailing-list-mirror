Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47E920899
	for <e@80x24.org>; Wed, 26 Jul 2017 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdGZHfC (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 03:35:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750880AbdGZHfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 03:35:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2611B8AF6D;
        Wed, 26 Jul 2017 03:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EiwxIkA4f7PF
        jsnfNfpo6H+sDuc=; b=AupY6rjetiV9DWjsa2Uc9Xccrd4/pVDgmTmaITkSMFRh
        8iluUtW1HG/OPssY+c0hShvZdnmhyZVwF81wzk95LS5e44Pb8BJAMD++SlxitIey
        hPsnEdmZVJqoUqw47piwh/mJ/BvmqyVWZFg45hcz7CFlkyz388JB+agkvNNxSB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nq9Aw0
        UkpZ7shzOJQ1SOL2EpYNb1B9j/cBLl4CLUGqwEB1+hohjcseds9QhnEN4TkEG3Ou
        fx4CMah4Hl8jhCuqx6LtW/RQf84b14Yq2Zv+mdLBwZjowIjzzzD/FVuaLnVA48Qr
        DxkP6yV/Fhz326svhUB2v1ESWtLLURNVDcmU0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E03C8AF6C;
        Wed, 26 Jul 2017 03:34:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 902258AF6B;
        Wed, 26 Jul 2017 03:34:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     lukaszgryglicki <lukaszgryglicki@o2.pl>
Cc:     Dan Kohn <dan@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: [PATCH v3] merge: add a --signoff flag.
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
        <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
        <xmqqeft4bbqa.fsf@gitster.mtv.corp.google.com>
        <7A9ED766-4A25-4F34-8E02-3DFCE1D63ADF@o2.pl>
Date:   Wed, 26 Jul 2017 00:34:53 -0700
In-Reply-To: <7A9ED766-4A25-4F34-8E02-3DFCE1D63ADF@o2.pl>
        (lukaszgryglicki@o2.pl's message of "Wed, 26 Jul 2017 09:13:57 +0200")
Message-ID: <xmqqa83rtzvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EAE5DF66-71D4-11E7-BFFA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lukaszgryglicki <lukaszgryglicki@o2.pl> writes:

>>> +--signoff::
>>> +	Add Signed-off-by line by the committer at the end of the commit
>>> +	log message.  The meaning of a signoff depends on the project,
>>> +	but it typically certifies that committer has
>>> +	the rights to submit this work under the same license and
>>> +	agrees to a Developer Certificate of Origin
>>> +	(see http://developercertificate.org/ for more information).
>>=20
>> This is taken verbatim from Documentation/git-commit.txt and "this
>> work" in that context is entirely sensible, but it is not quite
>> clear what it means in the context of "git merge=E2=80=9D.
>
> Changed slightly, but I=E2=80=99m not a native English speaker, and
> don=E2=80=99t really see what is wrong there.

Oh, the language is not the issue. =20

I was trying to remind you that a "merge" may be an automated and
mechanical one, in which there is no original work that requires
signing it off in the first place, which was the point =C3=86var raised
when Dan's original post came up.

