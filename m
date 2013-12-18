From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] Add and use skip_prefix_defval()
Date: Wed, 18 Dec 2013 09:51:40 -0800
Message-ID: <xmqq38lqjbde.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<1387378437-20646-4-git-send-email-pclouds@gmail.com>
	<20131218162746.GA15334@sl4mmy.zerosphere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Kent R. Spillner" <kspillner@acm.org>
X-From: git-owner@vger.kernel.org Wed Dec 18 18:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLHi-0001ul-FU
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 18:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab3LRRvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 12:51:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542Ab3LRRvp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 12:51:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1FF59D17;
	Wed, 18 Dec 2013 12:51:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vFaMY6WPJmdF
	KikeK7iDP8zqFvM=; b=ZkTFwaXqHeF6rzxpTiCcPbjEdZhwrkcTVqZ1X+CLtBXU
	96b9MaLP4C3+a2VB8Yjj5WnepUAKT4avRbqTzjKLk39qKGGtVmTp7esb7BIzNs2e
	k83bG5t2juVKwKBWbBflbplLaIpkLXn6OJDBMUOT31dCVA8QWJAQUqBqNZRtyu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=saANj+
	B7Ze1mKXJZ6hu1HaC85VtoxmJkHXwGvaLOYtDBi+SRRjxi6nU9cfzk5HrjmrPtFL
	PZyt/7SXBxM0M35Y0dUvonYEZxE0bpXSTT6eHm0ck6LDyRJBfGum5Q+IK+UG+LSd
	r95yMNizIzfw/bEqWGk4ODyoFgLfZzkPmogUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4017559D16;
	Wed, 18 Dec 2013 12:51:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E64659D13;
	Wed, 18 Dec 2013 12:51:42 -0500 (EST)
In-Reply-To: <20131218162746.GA15334@sl4mmy.zerosphere.org> (Kent
	R. Spillner's message of "Wed, 18 Dec 2013 10:27:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E0AA4E8-680D-11E3-8232-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239463>

"Kent R. Spillner" <kspillner@acm.org> writes:

> On Wed, Dec 18, 2013 at 09:53:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> This is a variant of skip_prefix() that returns a specied pointer
>> instead of NULL if no prefix is found. It's helpful to simplify
>>=20
>>   if (starts_with(foo, "bar"))
>>     foo +=3D 3;
>>=20
>> into
>>=20
>>   foo =3D skip_prefix_gently(foo, "bar", foo);
>
> Should this be skip_prefix_defval instead of skip_prefix_gently?

Yes.
