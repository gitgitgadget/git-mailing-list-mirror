From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Tue, 15 Mar 2016 14:16:42 -0700
Message-ID: <xmqqh9g77879.fsf@gitster.mtv.corp.google.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
	<CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
	<CAFZEwPP5AXHCmAg62wVNy_8FuOQxPdYofeb5b=m3g-ugiJkTyw@mail.gmail.com>
	<xmqqlh5j7am8.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOK1hH8CuFc6TohDc5xq7GXpp0DBnQi4QQ6m+8dspUbeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:16:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwKg-0005Qb-QE
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbcCOVQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:16:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751885AbcCOVQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:16:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F001A4D341;
	Tue, 15 Mar 2016 17:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v4oHYU38lv2X7bkEimPeKo8ImHA=; b=wm7P5N
	RMzwbAcx8k6ZH/W6zDqaxyQRbMysjL7N3cLJ60VboimPTTYmVNXt1qa0MZRVWY1R
	sLHYllNgCoh+Km5+dhy6kgxV/s8Ua92VlsJfQS3Mtzim1IMyNllFTltEtpncHHrt
	ENAU7doesHyVgATR9RFhXS2vc18GaRw66Zbpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yDdJPpKVlfHrM4eFVCLOwS4ern2/4YMu
	ncKxmqZxE7TA/UtZCuPh4/yB8RNV0R7AyWIOhJtsK2TEpMr5QeVAc/wIHM69k6nG
	jii2vyX6GdXW+GCPkn4XP9Pqg2BDT/We3TmlT/Xa0R33chJieSGiXQtwpg1otQlr
	sH9/LVgWRlo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6CC74D340;
	Tue, 15 Mar 2016 17:16:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 66D154D33F;
	Tue, 15 Mar 2016 17:16:43 -0400 (EDT)
In-Reply-To: <CAFZEwPOK1hH8CuFc6TohDc5xq7GXpp0DBnQi4QQ6m+8dspUbeQ@mail.gmail.com>
	(Pranit Bauva's message of "Wed, 16 Mar 2016 02:39:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3788FCB4-EAF3-11E5-A538-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288913>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> ... But then I am still not convinced for the
> requirement of another variable `opt-verbose` as I believe that the
> `verbose` and `config_verbose` are quite enough for this.
> ... Or is there something else which I forgot to
> consider?

I do not think we need three variables.  If there is one "verbose"
that is initialized to "unspecified" (which must be different from
"no", "yes", "even more verbose"), then it is perfectly fine to
reuse that as if it were "opt-verbose" in my outline.  I just used
that name to make it clear where the value comes from for these two
entities, i.e. to contrast "opt vs config" (as opposed to "(nothing)
vs config").
