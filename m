From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Wed, 02 Mar 2016 18:57:31 -0800
Message-ID: <xmqqsi082rqc.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
	<CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 03:57:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abJSM-0006OZ-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 03:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbcCCC5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 21:57:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754169AbcCCC5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 21:57:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EC104A064;
	Wed,  2 Mar 2016 21:57:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=caPlQtNXM0JWi/bpFMc50Kj26mk=; b=dpBJHA
	zNK7SJT6W4zNB9SjaMgqKdGAbQ0FZfGhgnx1Hjy8V3Bn5snba2tp8nGridE1YWqw
	zs1rbR5KL/5oHFg/zcFHLhHncXXsY2in88iXoBbkDdIZ9Bn+MIQsULyCrpjsHBCJ
	v9E4Z3CAVaEhk19gDnQStn90UBQr919/RlSho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jkg3dR8xAstP1CYQup6sy3RURJaLIins
	Y0IR0IUlHyeR+LvZFAYJcQa87e0JOiAxMnZq3D4I/8rQ8yBVLpIhcOVCC5ioAexa
	Ns+GytBdaSGibrYjo8oS273obc7xJMaTog+m5JVV1lvVQHhzopcAEs0cGVTiiUuL
	IrCYMW/bC8w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55D2A4A063;
	Wed,  2 Mar 2016 21:57:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC3124A062;
	Wed,  2 Mar 2016 21:57:32 -0500 (EST)
In-Reply-To: <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 3 Mar 2016 08:04:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACED2F50-E0EB-11E5-AAC8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288163>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 3, 2016 at 7:07 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi,
>>
>> It looks like commit 57ea7123c86771f47f34e7d92d1822d8b429897a (git.c:
>> make sure we do not leak GIT_* to alias scripts, Dec 20 14:50:19 2015)
>> broke "./t0001-init.sh --valgrind".
>
> Just wanted to confirm the problem. I will look at it later today.

Thanks.
