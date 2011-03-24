From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Convert read_tree{,_recursive} to support struct
 pathspec
Date: Thu, 24 Mar 2011 12:58:20 -0700
Message-ID: <7vhbas8f4z.fsf@alter.siamese.dyndns.org>
References: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
 <1300977675-6243-1-git-send-email-pclouds@gmail.com>
 <1300977675-6243-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 20:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2qgA-00042v-BQ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 20:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090Ab1CXT6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 15:58:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934011Ab1CXT6b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 15:58:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF91D423E;
	Thu, 24 Mar 2011 16:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IzUzTepQQ0aO
	tNwmg6giXiye5gs=; b=GbOrHeKY+RG+fjxBlUB0QiBb5IByvzhnhOpt4krNGnY1
	EG80EKABpJ3Kg/yWYo5MZPNJNC24j5pltr0IT0BYjSvxODQplnt2oQKTuvrnIqXz
	rQXvRKOkqNiJ5bKP8IHLXlvRX9wXgOTZ3dctvMpUH2fTR1sfh17vjeJMYS8LO0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JNkTvV
	CKGtFUgdAPHrgvgVSXETocpHQrF2XbWVXRSJWdQDNnXIWL+imrHU+K2BS/WYMn37
	Tkq+CurRT/ZQmeAw36Xcly9aOtaT9CNDQ7C6kLr5mD6J7neN6j3NWmqsmHsQzh3Z
	Xm+qUDxX8cWKjbpiuWl7bU7jhC1DUkemHx/Wc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E183423A;
	Thu, 24 Mar 2011 16:00:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D4E74238; Thu, 24 Mar 2011
 16:00:04 -0400 (EDT)
In-Reply-To: <1300977675-6243-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 24 Mar
 2011 21:41:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51C9F1BE-5651-11E0-AFF4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169940>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This patch changes behavior of the two functions. Previously it does
> prefix matching only. Now it can also do wildcard matching.

The most important in this change is that it finally starts passing
pathspec, not "char **", down the callchain.

Except that variables should be called pathspec not pathspecs, I think
this is basically in very good shape.

Thanks.
