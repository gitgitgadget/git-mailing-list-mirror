From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/12] pretty: save commit encoding from
 logmsg_reencode if the caller needs it
Date: Mon, 01 Apr 2013 11:10:10 -0700
Message-ID: <7v4nfqjf5p.fsf@alter.siamese.dyndns.org>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 20:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMjBt-0003Ig-NP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 20:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab3DASKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 14:10:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab3DASKM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 14:10:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F7DB11907;
	Mon,  1 Apr 2013 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O6iQPtBvs4dn
	/aPbl4xCHIuE3Bc=; b=RIf6t1c5CWJcSVa241rUsD3y5Fwzbwx9p0nhawLAcChy
	1HX20lO7dw4KPz8GdlHbDY/BEJ/3isXaylXs0Q/wRz0knq4sxBz63hBRLLJH7oz6
	QXSj/Dq5xuAfCISMfhfr0/LaiJLWxVZkk4HJPnLLcep0EtIghSUVMR+3EL2ZlD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S3WGxa
	hFiPAzkYgWcaC/aD+1oOEACh4tJ/Jp6yzHXzkBjsyaISWKDueb4xhM4ReM8GjpwG
	ziom1g1ePl5gyuQfYbHYtyqzp0TkDC5M2mO0TgCB2qyYf+rP91EpYWdN0Izl/r80
	hg8ubEyyNTmViVGvSEk1m6/veYI2PVh+QIvks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 313B811906;
	Mon,  1 Apr 2013 18:10:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A966C11905; Mon,  1 Apr
 2013 18:10:11 +0000 (UTC)
In-Reply-To: <1364636112-15065-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30 Mar
 2013 16:35:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6505989A-9AF7-11E2-AF96-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219697>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The commit encoding is parsed by logmsg_reencode, there's no need for
> the caller to re-parse it again. The reencoded message now has the ne=
w
> encoding, not the original one. The caller would need to read commit
> object again before parsing.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This and 06/12 look like a fix independent from the remainder of the
series.  Can they be moved a lot earlier in the series?
