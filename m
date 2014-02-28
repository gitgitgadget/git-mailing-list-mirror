From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] OPTION_CMDMODE should be used when not accept an argument, and OPTION_NUMBER is of special type. So change the mode to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 12:02:04 -0800
Message-ID: <xmqqsir3t39f.fsf@gitster.dls.corp.google.com>
References: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com>
	<CAJr59C1qHrQ9qPdDWfGzj9QX3L-EwEcP+updu0SDn24r4i7UMQ@mail.gmail.com>
	<CACsJy8BM=m6=tv2P6F3EAcVPupovSTKC3s+5gkus3V+GZ4owRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5a2Z6LWr?= <sunheehnus@gmail.com>,
	git <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 21:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTdP-0005mw-0Q
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 21:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbaB1UCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 15:02:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaB1UCJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 15:02:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 177F470882;
	Fri, 28 Feb 2014 15:02:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r+c3v5+VqBBx
	+S1a/lOqnOS8OgA=; b=F/Yh7XZ7SD9LlHlpAgrmJnnBDieD0ZCMNuphHSapRqbC
	J4CFASaOXgk0yNimnl2k1p1mpiV/yLVYV0l3wTf/ykVftFTaLYQTPAIFjqI24EIg
	pGVE+ip0Ujj8WesULW2+LjHZk4Ky2093KRq1t83SmJa2rzSEbKws4S4AvsEDVwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ybeu1K
	IwuHuuGpJc9eQ5QLNHALJ2uZm7r9W0Ya4sTs15KMiFcmuzTBCrDPoBe+OuI29npZ
	WD73Y4LMDHk3ShtQd3eem2LQtaKGCPZ+WSib8h0Cf+4H5Hj0TCO874FirLw10SIS
	8Omt8jjsqyiqt6T7zxejwmmXaAVhCOjGtvrRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F003D70880;
	Fri, 28 Feb 2014 15:02:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66BAE7087B;
	Fri, 28 Feb 2014 15:02:07 -0500 (EST)
In-Reply-To: <CACsJy8BM=m6=tv2P6F3EAcVPupovSTKC3s+5gkus3V+GZ4owRw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 28 Feb 2014 21:42:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3379C590-A0B3-11E3-A13B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243012>

Duy Nguyen <pclouds@gmail.com> writes:

> Way too long subject line. Keep it within 70-75 chars. The rest could
> be put in the body.
>
> On Fri, Feb 28, 2014 at 9:32 PM, =E5=AD=99=E8=B5=AB <sunheehnus@gmail=
=2Ecom> wrote:
>> I am not sure if this is a bug.
>> I need your help to find out it.
>
> Tip:git has a wonderful history (most of it anyway). Try "git log
> --patch parse-options.[ch]" to understand parse-options evolution. Ad=
d
> -SOPTION_NUMBER (or -SOPTION_CMDMODE) to limit to only commits whose
> diff contains that keyword.

Also, I do not think this should be done in a single patch.  What if
it turns out that explicitly making sure that CMDMODE does not take
any argument is a good idea, but the other change is a bad one?
