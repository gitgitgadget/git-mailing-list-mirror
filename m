From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Mon, 30 Nov 2009 12:01:08 -0800
Message-ID: <7v1vjflr3v.fsf@alter.siamese.dyndns.org>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <7vr5rlerqf.fsf@alter.siamese.dyndns.org>
 <32541b130911261405q6564d8f2o30b7d7fd6f708d05@mail.gmail.com>
 <7vvdgs1qip.fsf@alter.siamese.dyndns.org>
 <32541b130911301008v4156f0c6ge9f30952565392f9@mail.gmail.com>
 <7viqcrlrb8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:01:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFCR0-0003Xw-Rl
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 21:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbZK3UBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 15:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZK3UBL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 15:01:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZK3UBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 15:01:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 110CEA3326;
	Mon, 30 Nov 2009 15:01:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s/yJw4EXsS1I7pCeeMtQevlTGVs=; b=m399tu
	EGkunep5PkOzcqJdpGdktzn6PUL1WOlVMPDKx7WydvBlt9SZmVu/qjVOYvzz0CQe
	H0pq1ui1Mun115jwfFPPmiaH9BUF2502riu+iCTt7yoSp4kU2T8tSZCVhfmIOeAm
	W2LzxHWwbRKahPcVw6OGcxuFeB07Drcc8HGZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQDKuX4q2aDg3LyHuNLe3zFh9fYXlZIZ
	pyWhgFCutNJJZbjW+aNH78ulqcIVzydf4uR7UvknvqggRIiGXyRLEREXDPkmydn2
	eL9lxiSXw2HY6C156nDexpeSduCdGjmPnewhMI8aLpeLDA1Hp/tuek9Ufa/LIbv/
	F8MGGYmgmdo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E417FA3324;
	Mon, 30 Nov 2009 15:01:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A260BA3323; Mon, 30 Nov 2009
 15:01:09 -0500 (EST)
In-Reply-To: <7viqcrlrb8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 30 Nov 2009 11\:56\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CDBC368-DDEB-11DE-91F0-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134134>

Junio C Hamano <gitster@pobox.com> writes:

> Avery Pennarun <apenwarr@gmail.com> writes:
>
>>> I've queued the series with minor fixes to 'pu' and pushed it out.
>>
>> Since I see you didn't change a couple of things you mentioned in
>> earlier comments (the NEEDSWORK comment and the sq-then-eval trick) do
>> you still want me to respin this series?
>
> The commit still is NEEDSWORK and shouldn't be in 'next' in its current
> shape.

Oh, I think you meant the "NEEDSWORK -- we limit to depth 2 when we
guess" and that has been with us ever since we added subtree merge, and it
is no reason to block the topic.  I had the sq-then-eval stuff in mind
when I wrote above.

Sorry for the confusion.
