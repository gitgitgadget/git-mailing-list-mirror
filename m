From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Tue, 15 Nov 2011 23:18:29 -0800
Message-ID: <7vmxbwr0vu.fsf@alter.siamese.dyndns.org>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
 <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
 <7v1ut9uglb.fsf@alter.siamese.dyndns.org>
 <CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 08:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQZlW-0004Ul-ME
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 08:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab1KPHSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 02:18:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab1KPHSd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 02:18:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6432EB1;
	Wed, 16 Nov 2011 02:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5C72xR/eDeN/
	FpGDn1IKj/m99lM=; b=l4hOFZV5aWzmgPNvU3rzpDXr+6FRMx2cVxZKuqK6Ro0/
	itutfqiG9tX5pbcCYHRRZaXAfpPGSo39HjGO7zYzAea3H4gcoJ4bubabxObMvIVT
	pXNLI6f+y4ihs/0/VlXGs5b9miz2FRrIONds0RX1kSAZsBqoaJGvqTo2Zqd76rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h0TBxe
	8etbHB1A7i2Oyi3S5s2FtBtvZd7/+7o+pb1xh1gqkdzxIKk4nD5/8Oudi+/e3TiI
	7VklfrlVbXTcVK6PxYYajvBDZn8pr2MR4iCXF98Srdkn8NrpnVHA2e282rXm37OT
	8p2yyD8aZ1nyt99zDaZxKqkLmIZX3SeDJscPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75D5B2EB0;
	Wed, 16 Nov 2011 02:18:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2D4A2EAF; Wed, 16 Nov 2011
 02:18:30 -0500 (EST)
In-Reply-To: <CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com> (Dmitry
 Smirnov's message of "Wed, 16 Nov 2011 11:11:23 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FD28E86-1023-11E1-A543-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185516>

Dmitry Smirnov <divis1969@gmail.com> writes:

> 2011/11/16 Junio C Hamano <gitster@pobox.com>:
>> $ git ls-remote https://git.kernel.org/pub/scm/git/git.git |
>> =C2=A0grep -e HEAD -e master
>
> in my case this command produce no output.
>
> What if problem is caused by curl or TLS lib (libcurl-gnutls?) which
> is used by my git?

Yeah, this is sounding very likely that this is an issue at the SSL/TLS
layer underneath whatever Git speaks.
