From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff too slow for a file
Date: Tue, 20 Apr 2010 00:40:37 -0700
Message-ID: <7vd3xuinbe.fsf@alter.siamese.dyndns.org>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx>
 <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 20 09:40:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O484j-0004Zp-Jf
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 09:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab0DTHks convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 03:40:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0DTHkr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 03:40:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72C0BA42EC;
	Tue, 20 Apr 2010 03:40:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=rVZ5Sfg8g9ha29ii3Ach+wPLN
	uQ=; b=c4SuCH4TlT8OIhhO8SQkS/1Z6bE4voJLxy6QLutrsEDFFzpOfOwf2NEMP
	NT0qukLAEx2ttY1glEfwU9UUExywC319TB+iDLRVFJ1V7GUsiA5d9vjToPmPyZ/M
	KPHU2yZqJX1nW3oWCFFlMQi0r9FydX7nRhG8nxxrq5bdW2Ok8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=qfQXm5EJSTG9ZoJWmVU
	kOu7/k9I87q36421XE2mlzthG+yZSQv2ElKM7W1Wi8xRPZr3/q28ud4QJUbtcTk8
	WM9cQ9xzXpkgl5Mt0tKEu3p7qs6NTu7M4DeF6oQ34Ur+Ma3L5hM7kOA6k5q4clPd
	XRLMF6/4p/bC2SD/v+h8VIqg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E46DA42E6;
	Tue, 20 Apr 2010 03:40:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D18A42DA; Tue, 20 Apr
 2010 03:40:38 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05C43420-4C50-11DF-9E4D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145354>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> For Linux, these 161 out of 178107 commits are affected:
>
>   90d49b4f  83f3c715  3b5dd52a  e97bd974  4e092d11  96b3c83d  4c96e89=
3
>   ...
>   22e2c507  e9edcee0  303b86d9  47b5d69c  2d7edb92  cb624029  f4f051e=
b
>
> I have briefly looked at a few of them.  They were big and not obviou=
s
> with or without XDF_NEED_MINIMAL, but the flag clearly helped to cut
> them down a bit.

Thanks.

I am getting the same impression after staring some output.

Probably we should at least try to get rid of the use of MINIMAL
immediately after 1.7.1 and if nobody finds large discrepancies, aim to
ship 1.7.2 (and possibly 1.7.1.1) without even --quick/--slow options.

I expect that there will also be some differences in the blame output.
