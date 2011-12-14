From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Make commit_tree() take message length in addition
 to the commit message
Date: Wed, 14 Dec 2011 10:12:06 -0800
Message-ID: <7v8vmfqayx.fsf@alter.siamese.dyndns.org>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 19:12:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RatJQ-0004OZ-2d
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 19:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871Ab1LNSMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 13:12:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1LNSMJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 13:12:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0A654A35;
	Wed, 14 Dec 2011 13:12:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QD7PYUcGAg6b
	FhSPxIeXcxVCwZo=; b=QnrtVX2+HXEfJ1P0wm4eP23gMg+vbjx1tafs+kwa6GCX
	gVbuMYVTNoratH4uLYv8wsWdFP6sgxU6oNFmvYbstlE91ubCHbar+BdfPKlslbhC
	38kNZNKm70/23gGPIQNG9lj/H0pEMPNgiTeRdgKIzKqsC/mz625KsL4U9subzzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jgiRAK
	IDXb/M5fnVkTVLl7mGke1gaVXC9m0cr4S8Bf6rW1MZHnluy78LTz6RXQe+b+QtQD
	zC9iOgLZty4rKm9Savt7KGCpjzphijhBgHty97+wfX4cK2ZfGKj+RxBcoo3qtwy9
	9XXudH42ruqq/3UXH5Vk2g5EyoW9C+reaEyDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A79F34A34;
	Wed, 14 Dec 2011 13:12:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 242BE4A33; Wed, 14 Dec 2011
 13:12:08 -0500 (EST)
In-Reply-To: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 14 Dec
 2011 21:08:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22A27088-267F-11E1-91E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187159>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Justification?

As all 3 primary users of this API feed strbuf.buf to the function, it
would make more sense to change the first parameter to a pointer to a
strbuf, no?
