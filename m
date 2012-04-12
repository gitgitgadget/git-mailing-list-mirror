From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Thu, 12 Apr 2012 10:43:33 -0700
Message-ID: <7vmx6g6e2i.fsf@alter.siamese.dyndns.org>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2Ug91_sQ-XR3ck2k+x+eQRt9PNRRBOUnkrnNRhY6fEpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 19:43:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIO3c-00079Z-0y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 19:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2DLRnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 13:43:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757896Ab2DLRnh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 13:43:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F88665D;
	Thu, 12 Apr 2012 13:43:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a0WlMPrZle8A
	pEZanl2akHXy6Fo=; b=Q6uB2O2onFNZEqKZWcb3LZHBEK/4hSCuT7zW4ctrBJGf
	7+56jiyvhlIZUY+sZRpPXV8lGd+Y9GaJRGDh72Q/LGE9FEF8KwtZG35CYYTSkgAg
	DnMfnBxop3wzET3mrRFo/7D3btzjqJ3pP8ukm4Yfw+RYpsNaHHHN4U7Vq5uVr+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wvdafq
	myCyRDjREO1m83x6hJ2VjYH8OaVGYl/12vX/DMd+n7qYUsEs6fGqmXiXOHduCyB/
	IrJnPA2hrLj/KBTd2a9zxmtxoP/eRwcmniReG9EmE1V73tct6DoL3giyU0bydRKy
	L29YvsliSmRctzFa9jzfHZABFmNNWvraiRAhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796AD665C;
	Thu, 12 Apr 2012 13:43:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01BF3665B; Thu, 12 Apr 2012
 13:43:36 -0400 (EDT)
In-Reply-To: <CAMP44s2Ug91_sQ-XR3ck2k+x+eQRt9PNRRBOUnkrnNRhY6fEpw@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 12 Apr 2012 19:15:40 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 084D6278-84C7-11E1-9389-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195350>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 12, 2012 at 12:57 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> +test_expect_success 'double dash' '
>> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-\EOF &&
>> + =C2=A0 =C2=A0 =C2=A0 --paginate
>> + =C2=A0 =C2=A0 =C2=A0 --no-pager
>> + =C2=A0 =C2=A0 =C2=A0 --git-dir=3D
>> + =C2=A0 =C2=A0 =C2=A0 --bare
>> + =C2=A0 =C2=A0 =C2=A0 --version
>> + =C2=A0 =C2=A0 =C2=A0 --exec-path
>> + =C2=A0 =C2=A0 =C2=A0 --html-path
>> + =C2=A0 =C2=A0 =C2=A0 --work-tree=3D
>> + =C2=A0 =C2=A0 =C2=A0 --namespace=3D
>> + =C2=A0 =C2=A0 =C2=A0 --help
>> + =C2=A0 =C2=A0 =C2=A0 EOF
>> + =C2=A0 =C2=A0 =C2=A0 test_completion "git --"
>
> There's a mistake here ^.

Yeah, good eyes!  ... ah, wait, it is your bug ;-)

Thanks.

I wonder if it may make more sense to have this as two separate tests,
though...

> --- b/t/t9902-completion.sh
> +++ a/t/t9902-completion.sh
> @@ -96,7 +96,7 @@ test_expect_success 'double dash' '
>         --namespace=3D
>         --help Z
>         EOF
> -       test_completion "git --"
> +       test_completion "git --" &&
>
>         sed -e "s/Z$//" >expected <<-\EOF &&
>         --quiet Z
