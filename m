From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 4/5] t6006: add two more tests for the case i18n.commitEncoding is not set
Date: Fri, 05 Jul 2013 01:09:56 -0700
Message-ID: <7v1u7da0mj.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
	<7vk3l5a3nh.fsf@alter.siamese.dyndns.org>
	<20130705074644.GA32072@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv15q-0002ff-6l
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab3GEIKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:10:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162Ab3GEIKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:10:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8DF52815F;
	Fri,  5 Jul 2013 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/g3qyI3mpZV7q9mvUxse7Mq2Dy4=; b=jGrXnH
	ZBWILKNsj9mpeSORhpgirRPeni8HmpcSeo1TfWcTLpU+jkFW7XgCJG3I9FMN0JDv
	8M2vfkLP7R8ZD+jPtdTqG21NQCTzhCouXwZuNReLAg+84VsQAIHMtu4ZpPZCA9ca
	i0CcEPYTViqwWVh7X4vV5nshDkXx+ZvOk3YFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=axacwCAqeXish7wxW7Ya0eunAgSC7EOe
	WhuW0J8+mzqKOVgLdD8mZg6aVviuL3WVkcs7ZM5Hw0s/V/25iBMiHtqqovVo5XEE
	E0ek1yVRlKTGNi28crpTc646IoywLerQher2PcwnZexH8J2k4ISOYz0bhcIbgBtF
	hbvHQzSEnqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC3F62815E;
	Fri,  5 Jul 2013 08:09:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B0E52815C;
	Fri,  5 Jul 2013 08:09:58 +0000 (UTC)
In-Reply-To: <20130705074644.GA32072@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Fri, 5 Jul 2013 11:46:44 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48D71318-E54A-11E2-A795-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229634>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> Perhaps we should update test_format so that we can feed a quoted
>> input, e.g.
>> 
>>     +include an iso8859-1 character: <A1>bueno!
>> 
>> or something?
> We could use this file whole in UTF-8 but just make a conversion of
> expected output as it's done a few lines above with a commit message
> (stored to a file 'commit-msg' before the test 'setup complex body').
>     +iconv -f utf-8 -t iso8859-1 > commit-msg <<EOF
>     +Test printing of complex bodies

That is way better than my <A1>bueno!.

Thanks.
