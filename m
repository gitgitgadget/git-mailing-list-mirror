From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] diff: add option to show context between close 
 chunks
Date: Tue, 21 Oct 2008 00:12:17 -0700
Message-ID: <7vskqqzajy.fsf@gitster.siamese.dyndns.org>
References: <48FB757B.9030105@lsrfire.ath.cx>
 <7vabcy3k9l.fsf@gitster.siamese.dyndns.org> <48FD781C.2000103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 09:13:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsBRC-0005TB-1a
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 09:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbYJUHMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 03:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbYJUHMi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 03:12:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbYJUHMh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 03:12:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02ED172C89;
	Tue, 21 Oct 2008 03:12:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7844972C87; Tue, 21 Oct 2008 03:12:25 -0400 (EDT)
In-Reply-To: <48FD781C.2000103@viscovery.net> (Johannes Sixt's message of
 "Tue, 21 Oct 2008 08:35:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0C4AA14-9F3F-11DD-9D98-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98762>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>=20
>>> I think it makes sense to make 1, or even 3, the default for this
>>> option for all commands that create patches intended for human
>>> consumption.  The patch keeps the default at 0, though.
>>=20
>> I think defaulting to 1 would make sense, or alternatively, just
>> hardcoding that behaviour without any new option.  That would give y=
ou
>> more information with the same number of patch lines, iow, upside wi=
thout
>> any downside.
>
> Are you sure about the "without any downside" part? The extra context=
 line
> inhibits that the patch applies cleanly to a version of the file that=
 has
> that very line modified (including a different number of lines).

Yeah.  Ren=C3=A9 wanted this for _human consumption_, not mechanical pa=
tch
application, so "hardcoding" literally there in the very low level of t=
he
diff callchain is not quite right (it would affect format-patch which i=
s
primarily for mechanical application).

I guess you could make the hardcoded value 1 for everybody else and 0 f=
or
format-patch.
