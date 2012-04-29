From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Sun, 29 Apr 2012 14:28:34 -0700
Message-ID: <7vsjfmxm65.fsf@alter.siamese.dyndns.org>
References: <20120426223422.GC22261@camk.edu.pl>
 <1335518725-19728-1-git-send-email-zbyszek@in.waw.pl>
 <xmqqaa1x9mdi.fsf@junio.mtv.corp.google.com> <4F9B1F38.8040406@gmail.com>
 <4F9BCFD9.8020005@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Lucian Poston <lucian.poston@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sun Apr 29 23:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SObfl-0000QR-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 23:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab2D2V2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Apr 2012 17:28:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab2D2V2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2012 17:28:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1827F5E;
	Sun, 29 Apr 2012 17:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aqQgZOm7G37k
	N9ElMAYRgtbOBv4=; b=ADiPBXdGNfWLG4z/OpQvvSTj1QgLfLjSBXZhNKtqaCna
	vy8sG7HUlsR9VTuC3jciBun4TtdOd0N4flv0/2102kdQwihG8o1PoGIJ77tz0uyJ
	qk7tDgFgW43m1r7PZYqc2lm0S6dEn1EejqVTgj6aG2sZB7cITb58L857CiTMqJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HCdOYN
	3cMR2a9DpcoNDr2lnK/tyviGvpqKd+9VM4EFWGkmJRUq4INaqQFnyj7bxcry8QTI
	QCfuWgZaHG9smyNGBDDzXsaXa/c6uLBK1LkGNMXWNURiHsINW9GkyogQHFBRoCoH
	tgaYNRlgz+YDl6aupNwAIDQoHz4Tb1Hf9hW28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1F687F5D;
	Sun, 29 Apr 2012 17:28:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F8CA7F5C; Sun, 29 Apr 2012
 17:28:36 -0400 (EDT)
In-Reply-To: <4F9BCFD9.8020005@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Sat, 28 Apr 2012 13:09:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 479B4AA2-9242-11E1-A320-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196515>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> This approach with 'env COLUMNS=3D1 git ...' looks nicer, and works w=
hen
> invoked directly, but doesn't work when run under the test harness,
> because bin-wrappers/git uses !/bin/sh, which resets COLUMNS. So this
> simpler approach doesn't look feasible.

Sigh... That shell seem to be infinitely broken X-<.
