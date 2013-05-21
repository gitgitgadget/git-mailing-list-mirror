From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Tue, 21 May 2013 10:21:48 -0700
Message-ID: <7vd2skp7tf.fsf@alter.siamese.dyndns.org>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 19:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqG4-0007yu-Ij
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3EURVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 13:21:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970Ab3EURVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 13:21:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E240720E33;
	Tue, 21 May 2013 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6h0ALRj4O5/p
	NVBTr1z4mfBBSJM=; b=ovFOtKVqEZE1nCgLgyyDCjUJgPkc51C4IKcbYIRZJ3zG
	vJQ2LgrnTLyccJYhiuKw9YuBIk+SGR/oy7JZqxi1HlitcdkkMPp0J1t4blFrAluK
	pzvcC/T5POE1N+aJz0n3Z0pEeNlX6KEQ40m3PVnRsFOdlYv3kA9nwReVlKc/g0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JW4gSR
	RWJd1q2M06O6AB2QQ8DH+gKCvlT78aSAh4P0gacMmW5rCLCpdg2CzG1qTeu+gQZt
	1H2SndTxXLZDz7iVM2NILyc+OW+zPiYi33ttiSlQT38l52xBBboChnF7LAM3mY2P
	jIpWvYRGkUoeRpcnGG96DHvftXNwEkMPO/vTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5FC520E32;
	Tue, 21 May 2013 17:21:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55C5B20E2D;
	Tue, 21 May 2013 17:21:50 +0000 (UTC)
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 19
 May 2013 17:27:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC57CEAC-C23A-11E2-A5EA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225045>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This series introduces:
>
>  - %(current), which either shows "*" if the ref is pointed by HEAD
>    or a space. Junio called it %(headness). I don't like that.
>    I don't like %(current) either but we have to start somewhere.
>    Name suggestion? %(marker)??

"marker" will paint us into a corner we cannot get out of when we
want to mark refs with different criteria later.  At least "current"
tells you what kind of marker we are talking about and is 1000 times
better.
