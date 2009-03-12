From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #03; Wed, 11)
Date: Thu, 12 Mar 2009 13:43:52 -0700
Message-ID: <7viqmejwtz.fsf@gitster.siamese.dyndns.org>
References: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
 <49B96F1A.3060001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Mar 12 21:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhrmW-0000QO-SY
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 21:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZCLUoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZCLUoA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 16:44:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZCLUn7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 16:43:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2558E5EE1;
	Thu, 12 Mar 2009 16:43:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 879295EE0; Thu,
 12 Mar 2009 16:43:54 -0400 (EDT)
In-Reply-To: <49B96F1A.3060001@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Thu, 12 Mar 2009 21:22:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8208CE80-0F46-11DE-967F-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113122>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> Tonight's 'pu' does not pass its self-test and it is expected; I won=
't be
>> fixing it and I'm going to bed now.
>
> This fixes a segfault:

Oops, you're right.


> diff --git a/remote.c b/remote.c
> index 68c1a84..ea1841e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -655,9 +655,9 @@ struct remote *remote_get(const char *name)
>  	struct remote *ret;
>  	int name_given =3D 0;
> =20
>  	read_config();
> -	if (name || strcmp(name, "-"))
> +	if (name && strcmp(name, "-"))
>  		name_given =3D 1;
>  	else {
>  		name =3D default_remote_name;
>  		name_given =3D explicit_default_remote_name;
