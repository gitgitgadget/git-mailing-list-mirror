Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE436C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbiATTt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 14:49:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61073 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiATTt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 14:49:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81CA41157F3;
        Thu, 20 Jan 2022 14:49:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tX1tXp7NJUgMvogu3lRaNX1w877Ni2UGSGoOEx
        mOLF4=; b=CFXO00nlD1tpPsu0rp0+mX/lgdUcrKYTYLUm9DpTK9y4+OB3jUx3qc
        6nP6Dgf3EM+uYBU15MTd/akPCTB0q3/ZI8sM5uuAzx9E1t+Y52nWq7Hey+UqJ3Nr
        Gi8Naq0ZO6pOEtmjYwPjVagEORTw48nxbgTuXt2/1LKuEZlR0cho4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7682B1157F1;
        Thu, 20 Jan 2022 14:49:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D57A91157F0;
        Thu, 20 Jan 2022 14:49:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: Note SSH and X.509 signature
 delimiters
References: <20220120053223.221667-1-gwymor@tilde.club>
        <xmqq7daui4s8.fsf@gitster.g>
Date:   Thu, 20 Jan 2022 11:49:23 -0800
In-Reply-To: <xmqq7daui4s8.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Jan 2022 11:30:15 -0800")
Message-ID: <xmqqzgnqgpbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11E21D16-7A2A-11EC-94A4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +Signatures always begin and end with a delimiter, which differs
>
> The term "signature delimiter" is understandable, but is that the
> term used by the users and the developers of OpenPGP, X.509 and SSH
> who know and use such an ascii-armored signatures?  Just making sure
> we do not accidentally "invent" a new word that the upstream/wider
> community has an established word for.
>
> 	... Goes and looks ...
> 	https://www.rfc-editor.org/rfc/rfc4880.html#section-7
> 	seems to use "Armor Header and Armor Tail Lines" to refer to
> 	the BEGIN and the END delimiter lines, respectively.

Please do not take this as my recommendation to blindly adopt "Armor
Header" etc.  It was merely an illustration of what level of due
diligence is expected behind a change in this project.  If you make
a similar study of nomenclature used by X.509 and SSH folks, you may
discover that there is no agreed-upon standard term common across
these three, in which case "signature delimiter" might be the best
"vendor neutral" word to use in our documentation.  Or it may turn
out that RFC4880 is the oddball and the other two use the same words
to refer to their header and tail lines, in which case, unless those
common words are too technical and hard to understand for readers,
we may want to use that common one.

Thanks.

