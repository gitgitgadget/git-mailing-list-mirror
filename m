From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t0000-basic.sh: Don't run a passing TODO unless
 TEST_PASSING_TODO=1
Date: Tue, 17 Aug 2010 12:12:57 -0700
Message-ID: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
References: <1282038234-1880-1-git-send-email-avarab@gmail.com>
 <AANLkTimx_kOr6UptsVOCdMHjxQqcde4oaDgrN2amnuYe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 21:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlRcJ-00042U-Kl
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 21:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab0HQTOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 15:14:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0HQTO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 15:14:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 826A1CE4D6;
	Tue, 17 Aug 2010 15:14:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ml0C8G//CxLsHdnMSMJk/7OwmZE=; b=EbZM4B
	9QTs5Z0ls/QsaS7SG7Uv4t/YbLGv3mcDKELkSP4aaR6Lt7/HX2lJU8iOOc8Mxr9g
	Fgeu+5n21wk42TXR4JZLat8BqoyGqcPmPWKQlczlLNPx6jT4bRiD099RKKh5gXj3
	K5hOdKaAjyusjafsdiJ/AGV4DVpV6K5pEeths=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9lzgdyuKj8LkmqCgN+JOMWVTgYTUSzB
	E4psGxa1Q3Msobshr0EAtcBTeNMjNSYqeNn+5jUacx/vI135TctY+om1rvHfx2Rx
	688hfDKkeeSFDFFtn3+llZHQxJC7hPxp5Qfj/7juxPA4111qVCG1Iq4H88rLcTGZ
	6/qSdh6tQH8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E01CE4D5;
	Tue, 17 Aug 2010 15:14:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D918CE496; Tue, 17 Aug
 2010 15:12:59 -0400 (EDT)
In-Reply-To: <AANLkTimx_kOr6UptsVOCdMHjxQqcde4oaDgrN2amnuYe@mail.gmail.com>
 (Sverre Rabbelier's message of "Tue\, 17 Aug 2010 12\:57\:01 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A59385C8-AA33-11DF-888C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153774>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> E.g., something like:
>
> test_in_new_harness 0 1 0 0 '
>     test_expect_failure 'pretend we have fixed a known breakage' '
>            :
>      '
> '

Now the question becomes who tests "test_in_new_harness" ;-)

I'd rather prefer not to touch this one.  Isn't whatever the outer wrapper
used flexible enough to be taught about this kind of thing and filter it?
