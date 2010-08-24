From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fetch-pack: use args.shallow to detect shallow
 clone instead of args.depth
Date: Tue, 24 Aug 2010 09:31:08 -0700
Message-ID: <7vlj7wx99v.fsf@alter.siamese.dyndns.org>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
 <1282565304-3122-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 18:31:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnwPF-0002jg-Qi
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 18:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0HXQbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 12:31:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab0HXQbT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 12:31:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 821C7D05C1;
	Tue, 24 Aug 2010 12:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FZ0rXc45zS8c
	px6QfJ9o78QcOTg=; b=acpyXo2SqkyOBJp6N/OcNMsrZIYxM6inx7QTDlONoGUO
	dA/UsVDgm6WdEkqWEDlNUx0yJwLwDKuKVASwKynMN4C083WwKx3a+FLYCOn9UZ7E
	vpKj4QFCPv2HizD81iqvsBwlDfnf834A4hBik/U5sFI7PQMTrrFJtIYt8sejxn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sd0K60
	m3lHCkewmltILDTxubTSanaALliOPHRyM09TeqAtem4+S7z7HKV9a11z+dAPW50X
	GD+Ng7vHbrzR8WRHNKykK07Kf9mYEnfmPlbkxBO4hPVEKA3P/mmVAOqWTsg0FYcE
	LOrQEMT+3VjTdC/8tM96fT0uN49s55iV3GRvA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3EED05BF;
	Tue, 24 Aug 2010 12:31:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFD12D05AF; Tue, 24 Aug
 2010 12:31:09 -0400 (EDT)
In-Reply-To: <1282565304-3122-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 23 Aug
 2010 22\:08\:23 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02DFB2C4-AF9D-11DF-AEB6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154321>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Isn't there any rationale for this change?  "args.depth > 0 does not
necessarily mean we are in a shallow clone situation, because ..." or
"using args.depth > 0 to check if we are in a shallow clone breaks unde=
r
such and such conditions and here is a test case to reproduce the bug"?
