From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [git-users] Highlevel (but simple to implement) commands provided by default for git
Date: Wed, 29 May 2013 11:58:14 -0700
Message-ID: <7vtxllsjeh.fsf@alter.siamese.dyndns.org>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Br=C3=A1ulio?= Bhavamitra <brauliobo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:58:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlZl-0006D4-VE
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965797Ab3E2S6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 14:58:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759396Ab3E2S6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 14:58:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FDCA23392;
	Wed, 29 May 2013 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9wgDqxlH/zH5
	IVfBL0qYJSwgeTQ=; b=L9fWCBM12OJW+dQR6O0twfUPKFEhxNEkW3YY8qPBSvvK
	gljK8r28Hb169wevreBZnHINaRskXtxayNzTyCW2Vxx04SFopsh7kjb1myTM57vh
	CFPuvw+ZJrsjDXhwWQEw+f0nEi+quu5aQAVgPXZSl5WTfu0zDXb1eSXou7MLvgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wza78e
	9fcK8D4+bjIKHJU/DIAV2UwHBZUkg9JV0q88tNAzwn/gJZvzpPtvp+0rGmgdDAtd
	HfrbICfHKfFEOsq6mXeQO1Psqpm0PvTveAKcqqxVavnxNa6RROhA+OlvMWdSL7Dh
	m4j7uodAJCgSp3M69aFnzkEnlSrrgp72udxNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8747F23391;
	Wed, 29 May 2013 18:58:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CB5A2338F;
	Wed, 29 May 2013 18:58:15 +0000 (UTC)
In-Reply-To: <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	(=?utf-8?Q?=22Br=C3=A1ulio?= Bhavamitra"'s message of "Wed, 29 May 2013
 15:11:25 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8318F48-C891-11E2-9545-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225867>

Br=C3=A1ulio Bhavamitra <brauliobo@gmail.com> writes:

>   root =3D rev-parse --show-toplevel

Hmm, part of my "cdup" shell function looks something like

     cdup () {
	... error detection etc...
	d=3D$(git rev-parse --show-toplevel)
        cd "$d"
    }

so I can quickly go up to the top-level.  With "root", I could
replace that rev-parse call with "git root", but I'd keep typing

	$ cdup

after doing so anyway.  I am not sure how much value it adds.

You would need to handle error cases like "you are not in a working
tree", you cannot expect to be able to say

	$ cd "$(git root)"

anyway.
