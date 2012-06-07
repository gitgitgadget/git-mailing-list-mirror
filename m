From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] exclude: reuse last basename comparison
Date: Thu, 07 Jun 2012 11:28:13 -0700
Message-ID: <7vipf3geo2.fsf@alter.siamese.dyndns.org>
References: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
 <1339055617-23028-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SchRa-0003ZN-GK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab2FGS2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 14:28:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755153Ab2FGS2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 14:28:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD358A56;
	Thu,  7 Jun 2012 14:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hRUuthzkRL7F
	aq1PfvMCYaNKiww=; b=isu4tH0Qa56/2N3Hkrx2VPQQ+V+ypMsKSukgjwB6Cm7O
	+kWTC1AhW3lirAveZ7uA0ZvVs/mSjX1kw+yhmyVeKp2sV3RfYBERotsMpQSRWJvc
	+t6MVl7KqBX+BSRFFwhHr3i1SG/c4gXrJXF83wTnk9k5xh+mouDAlJ7U/aphkD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mpBLu2
	xlfBYpVCZzTiORAZXi+tDz0gTEtJpc3iAT3pm1SzO8Eb6fbbXnrKDAt8EUg3DGqt
	qMHry/qusrNfjR9fmjzO5AKRMyfUpijXBVDz0dVjrQxAS5spj1ffWLKvzXElEzzS
	LRW8J0rsFgEtQ1glruhKK85OuHXxndV0lXwnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C78E58A55;
	Thu,  7 Jun 2012 14:28:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61FA28A54; Thu,  7 Jun 2012
 14:28:15 -0400 (EDT)
In-Reply-To: <1339055617-23028-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 7 Jun
 2012 14:53:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BDD45DA-B0CE-11E1-8A09-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199434>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> If two consecutive patterns share the same "base" and we just compare=
d
> base against pathname last time, we can just reuse the last compariso=
n
> result.
>
> This optmization is made with read_directory() in mind. Notice that

s/optm/optim/; just in case you need to reroll this one later.
