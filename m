From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] tag: support --sort=<spec>
Date: Tue, 25 Feb 2014 09:42:52 -0800
Message-ID: <xmqqa9df6qcj.fsf@gitster.dls.corp.google.com>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
	<1393330935-22229-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 18:43:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIM24-0003pR-5o
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 18:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbaBYRm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Feb 2014 12:42:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbaBYRm7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 12:42:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06FDF6D84B;
	Tue, 25 Feb 2014 12:42:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WlY0XTMFG56b
	r3U1hD27akR/usA=; b=aIpwICezraaxJ+WIEbk+hFXKDWUFsaj2qlAw9RqUCbZc
	8i3oCrWKHVTe8o8akmnQo3mmdWT6zIeYmblfB4LtsgGp8iahNsH/+zeUys7Khxs1
	+1RMncWHnp9kQSbxSAFQ2wwdS+1wroMWlGxcqWjAYaw+Lj8nF+fQRIietc7JV9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=irx7mi
	rL/pCj+nkS26fqP06WUUH3x+k1T4vsK/ylbUd9yKHTXhQZUXx8Lp7xm/ULliPGfO
	3ot5f6K7O7H8esGQ0W3hY/WuLr88RwhPz9OqoqD10m4XhMFsRD4XasEPglRI6W3C
	m8iElqiAW+a6pGT33ikAkLRdMaa93y+rc1x2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E49516D84A;
	Tue, 25 Feb 2014 12:42:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C6356D843;
	Tue, 25 Feb 2014 12:42:55 -0500 (EST)
In-Reply-To: <1393330935-22229-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 25
 Feb 2014 19:22:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41FBFA5A-9E44-11E3-B604-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242676>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> versioncmp() is copied from string/strverscmp.c in glibc commit
> ee9247c38a8def24a59eb5cfb7196a98bef8cfdc, reformatted to Git coding
> style. The implementation is under LGPL-2.1 and according to [1] I ca=
n
> relicense it to GPLv2.

I'd propose this trivial change squashed in to record the above
in the file in question.

Thanks.

diff --git a/versioncmp.c b/versioncmp.c
index 18a9632..8f5a388 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,6 +1,13 @@
 #include "git-compat-util.h"
=20
 /*
+ * versioncmp(): copied from string/strverscmp.c in glibc commit
+ * ee9247c38a8def24a59eb5cfb7196a98bef8cfdc, reformatted to Git coding
+ * style. The implementation is under LGPL-2.1 and Git relicenses it
+ * to GPLv2.
+ */
+
+/*
  * states: S_N: normal, S_I: comparing integral part, S_F: comparing
  * fractionnal parts, S_Z: idem but with leading Zeroes only
  */
