From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: always report ignored tracked directories
Date: Mon, 07 Jan 2013 09:50:40 -0800
Message-ID: <7v4niskhlb.fsf@alter.siamese.dyndns.org>
References: <20130105230303.GA5195@sigill.intra.peff.net>
 <1357510179-22852-1-git-send-email-apelisse@gmail.com>
 <50EB0409.1090307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 18:51:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsGqm-0006Id-QN
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 18:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab3AGRup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 12:50:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab3AGRuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 12:50:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3A6B2BF;
	Mon,  7 Jan 2013 12:50:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TiN9DY2LfixW
	MlYmdmte17VGJVs=; b=Bvhdgxhb3qww+wQC56MkHVujJ2qIVIYryyjsXkMO0gEc
	4NVBcdB/qwJNwhb97swXVavJyY/FGiQTfErK/8TtbMDbfhHGYOqu3brJkWqgcDAq
	msfMZorGhdPqUw8AX/XrI2YYjpLuIeHHLLmXrgd8xw26sYtXr4QGy8/QqNqMmrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c561nI
	Jv0LZCMUeSdg7XUVPpM76deoqiAahepHWBAbQC0mv/NRhmoqlHcOQT3OYNAHA86c
	rteaWXZfY8FHmGxvfsyIi1ADNNyixlU4mCmgVN00aTABkmR+UqKi8nNUVaigwOmK
	Ytgpsm9YmBRUT7Do6v2OUVFIuVJulhcjERvW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DDCAB2BD;
	Mon,  7 Jan 2013 12:50:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88014B2BA; Mon,  7 Jan 2013
 12:50:42 -0500 (EST)
In-Reply-To: <50EB0409.1090307@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Mon, 07 Jan 2013 18:21:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C176DF40-58F2-11E2-9AD6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212907>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The bad news: the patch does not apply.

Huh, isn't this already queued as 22ccf86 (status: always report
ignored tracked directories, 2013-01-06)?

> The good news: t7061 passes on pu,
> and dir.c seems to be changes as needed:
>
> commit 1f4e17c6c9833f17dc6bbf045f8a8d6378dcb417
> Merge: dee1fa4 cc37e5b
> Author: Junio C Hamano <gitster@pobox.com>
> Date: Sun Jan 6 23:46:29 2013 -0800
>
> Merge branch 'nd/parse-pathspec' into pu
>
> which comes from Duy:
>
> commit cc37e5bf18ca11d9a884bddfebcdff61df3e6279
> Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Date: Sun Jan 6 13:21:08 2013 +0700
>
> Convert more init_pathspec() to parse_pathspec()

Yes, it needs conflict resolution with other topics in flight, but
the thing to test is to see if the result of merging 22ccf86 into
the 'master' branch does what we want; the newer topic is still in
flux and we know it will be rerolled before it gets into testable
shape.
