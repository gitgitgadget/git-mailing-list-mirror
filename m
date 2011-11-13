From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Convert many resolve_ref() calls to read_ref*() and
 ref_exists()
Date: Sun, 13 Nov 2011 12:30:55 -0800
Message-ID: <7vk473ojcw.fsf@alter.siamese.dyndns.org>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <1321179735-21890-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 21:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPghk-0000ox-3y
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 21:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab1KMUa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 15:30:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab1KMUa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 15:30:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7BD66E20;
	Sun, 13 Nov 2011 15:30:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HGFc7nq6aVIq
	mOI8V0yiMRIuj0I=; b=WFXcrKKPgUHPbqA5ksCQpUX/jJbd9cyuH//J+43m3Jd9
	orme8qQYBn/ghjzljlFkIRqPIuTXocFSqKN98Icbrf1tB/jw/ZuJTsJfXIQARmmW
	zueillldoqKZOo1R5qu4v+TN5JfO4fHwerdlo6ZJICYabItO2IEfD/BD3Iw6D7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oAorCE
	41nesRbRG1Cyd22PwXaJixkEVwZljHGZ/J18ifGKwzzqKzbrPEo8Uas5CQQFk7fR
	EXjRPwAb8BBS94ZzeIaJhWMgToG6sLr0xYNgotRqAjr2J0IFB8Gm8876ILrgD5ql
	rde5vgK7CxqFpMYnNEYHByu2ASHhoO02+THOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C333A6E1E;
	Sun, 13 Nov 2011 15:30:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59A606E1B; Sun, 13 Nov 2011
 15:30:57 -0500 (EST)
In-Reply-To: <1321179735-21890-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13 Nov
 2011 17:22:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 646E1050-0E36-11E1-B9A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185346>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Convert all these call sites to new wrappers to reduce resolve_ref()
> calls from 57 to 34. If we change resolve_ref() prototype later on
> to avoid passing static buffer out, this helps reduce changes.

Indeed the result is very nice and it is almost trivial to see that the
result does not change any behaviour without looking outside the contex=
t.

Thanks.
