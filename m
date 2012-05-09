From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff: remove unused functions
Date: Wed, 09 May 2012 14:14:51 -0700
Message-ID: <7vipg5qcok.fsf@alter.siamese.dyndns.org>
References: <4FAAD6F2.9050600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 09 23:15:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEDt-0008Ff-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761189Ab2EIVO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 17:14:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758678Ab2EIVOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 17:14:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 220686EE3;
	Wed,  9 May 2012 17:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TpoFd3IYGZZM
	KXcowMBORmzS10Y=; b=vzuomWqySB2WfL7bWBZydaGYOaVcWMdxmQGN/VeipjW3
	CA8TtoVdtVQ7m+lakfaB/5en7Up85bcuUdJH9AyoN+LatSEkUT8DLBj9suJ7fjPt
	Uy96AbuSwbeue9ujY38jYdokvpdsZ9fD4VUHFT2r6zfcx71OPHpiu/2fdhht604=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sR4plM
	KB0QWS5dNJ7eEV/XCP4kuM1YFRT0gAS7DSN39/ZwjCLXmwGKmfroO50w+2a8GIQf
	Rupajq6yejehaKV8gINz1XecCFHDvw1fmVlWsegsi2Brd/P8TCY7GVSdS6aa9YpW
	zUVeVQC5Jc66/at2dEqhF2pW1CT/7HBRg/UO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 196E86EE2;
	Wed,  9 May 2012 17:14:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A92F76EE1; Wed,  9 May 2012
 17:14:52 -0400 (EDT)
In-Reply-To: <4FAAD6F2.9050600@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 09 May 2012 22:43:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04BC4312-9A1C-11E1-BF7C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197514>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The functions xdl_cha_first(), xdl_cha_next() and xdl_atol() are not =
used
> by us.  While removing them increases the difference to the upstream
> version of libxdiff, it only adds a bit to the more than 600 differin=
g
> lines in xutils.c (mmfile_t management was simplified significantly w=
hen
> the library was imported initially).  Besides, if upstream modifies t=
hese
> functions in the future, we won't need to think about importing those
> changes, so in that sense it makes tracking modifications easier.

I was of two minds wondering the exact pros-and-cons you described abov=
e,
but OK, let's shrink it.
