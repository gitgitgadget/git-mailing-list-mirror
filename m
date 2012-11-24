From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] nd/unify-appending-of-s-o-b
Date: Fri, 23 Nov 2012 18:05:12 -0800
Message-ID: <7vtxsfzrfr.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
 <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 03:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc5CG-0003Xo-0A
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 03:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab2KXCFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2012 21:05:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756783Ab2KXCFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2012 21:05:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B6189F22;
	Fri, 23 Nov 2012 21:05:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dSWfh2RYbKfn
	6mSwz9LSHGhDBko=; b=MGxkjLLXP38sM4Xl7BktHDT1XOLBpP2jm1LlgRI62WOD
	cypyk0v6rgqW5WKgBMFAwbkuGBX4Q0RlPoou2RvLd0TO9fhUgGkYbewrwgGueY5j
	ULrNKSIdR4o/JdrC4OAe4CzHtkywzuvf2pCsyEvxxWeSAvF5WJR9The0Es2wlnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ve25ZI
	3F/+PESAyLU5cEyPb/1ncWehMAbvYmK3qw3b7VTKrvJVrq+iiVKDT5xUWvzyaejI
	LUjCXR4kCwJJ8BqHUb2GDatrvatFV0tY2wzTPm8HQSklNUw82g+lltkgDWXg5E/2
	WEUnoUTMHLfRk7KxL/lIcujHbaR7D7ubsMn4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C6A9F21;
	Fri, 23 Nov 2012 21:05:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E85369F20; Fri, 23 Nov 2012
 21:05:13 -0500 (EST)
In-Reply-To: <1353602289-9418-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 22 Nov
 2012 23:38:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62677080-35DB-11E2-84A4-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210281>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This round cherry-pick and commit only skip S-o-b if the last one is
> the same...

That sounds sensible.  When the user asks us to add sign-off, we
should honor it, unless it is known that adding one is absolutely
unnecessary, which is "it already exists as the last one".  Ignoring
all other cases will lose information.

Among the non-merge commits in the kernel history, you see about 500
such commits where the same contributor signs off the patch more
than once, recording the flow of the patch; 106a4ee258 seems to be
the most recent example.

Thanks.
