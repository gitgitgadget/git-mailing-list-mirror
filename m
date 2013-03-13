From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] status: show more info than "currently not on any
 branch"
Date: Wed, 13 Mar 2013 09:25:01 -0700
Message-ID: <7v620v468y.fsf@alter.siamese.dyndns.org>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoUm-0007nL-26
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152Ab3CMQZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 12:25:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933124Ab3CMQZE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 12:25:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D343CBBA5;
	Wed, 13 Mar 2013 12:25:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EsVQPxoSWXW6
	iTAKQUMeaJ4/KpI=; b=ucCNny3ktUsUlhnVq1ZxQKhrQ9FpjXy2HMHVTcH8rzuo
	qYZ9ADGScN8K3NoZzt0r9OmpSgwD9YSUaOpUUyGwsnUtbbwoz3Sazk66113GV7+1
	Uoj0hqGx6igBieyDRi2xoTFmrF2ZBT3Fjnxp0cx12Gz505RKcBLyEazYy9Kl2GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GsCKM0
	+ZHSbiUPBEqmX0Y9EvlIOS+CptBRsXykNUMSeM947FmT9UdxjVTIj8Lg8CoLp/Yx
	yjJxjEFE/q9qjOw6+VpBIJhVwadFy3u2v2+ePRDa01iUCtHdC3RE4DymVQRo61yK
	CE3w17kQITJssBqLtzNVfSbdrrm/HWjYserSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7AA5BBA4;
	Wed, 13 Mar 2013 12:25:03 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F72CBBA0; Wed, 13 Mar 2013
 12:25:03 -0400 (EDT)
In-Reply-To: <1363174973-17597-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13 Mar
 2013 18:42:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F040228-8BFA-11E2-8391-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218068>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When a remote ref or a tag is checked out, HEAD is automatically
> detached. There is no user-friendly way to find out what ref is
> checked out in this case. This patch digs in reflog for this
> information and shows "HEAD detached from origin/master" or "HEAD
> detached at v1.8.0" instead of "currently not on any branch".
>
> When it cannot figure out the original ref, it shows an abbreviated
> SHA-1. "Currently not on any branch" would never display (unless
> reflog is pruned to near empty that the last checkout entry is lost).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

It does look like using the for_each_in_reverse() does make the
caller less error prone (by the way, I'd love to see people review,
poke holes and plug them in the implementation of reading the reflog
file in reverse; I am not sure if it covered all the corner cases
right).

Thanks.
