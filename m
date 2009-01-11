From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline 'Subject:'
 header
Date: Sat, 10 Jan 2009 17:54:14 -0800
Message-ID: <7veizatxo9.fsf@gitster.siamese.dyndns.org>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090108100813.GA15640@myhost>
 <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
 <7vy6xm42l3.fsf@gitster.siamese.dyndns.org>
 <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
 <20090108231135.GB4185@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Potashev <aspotashev@gmail.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sun Jan 11 02:55:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLpYI-0004Tp-Nw
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 02:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZAKByX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 20:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbZAKByW
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 20:54:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZAKByW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2009 20:54:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDDFB8F5E3;
	Sat, 10 Jan 2009 20:54:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D4E098F5E2; Sat,
 10 Jan 2009 20:54:16 -0500 (EST)
In-Reply-To: <20090108231135.GB4185@roro3> (Kirill Smelkov's message of "Fri,
 9 Jan 2009 02:11:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C36138D4-DF82-11DD-9C49-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105152>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

>     [but I'm not sure whether testresult with Nathaniel Borenstein
>      (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =D7=99=D7=9C=D7=98=D7=A4=D7=
=A0) is correct -- see rfc2047-info-0004]
> ...
> diff --git a/t/t5100/rfc2047-info-0004 b/t/t5100/rfc2047-info-0004
> new file mode 100644
> index 0000000..850f831
> --- /dev/null
> +++ b/t/t5100/rfc2047-info-0004
> @@ -0,0 +1,5 @@
> +Author: Nathaniel Borenstein =20
> +     (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =D7=99=D7=9C=D7=98=D7=A4=
=D7=A0)
> +Email: nsb@thumper.bellcore.com
> +Subject: Test of new header generator
> +

That does look wrong.  If you can fix this, please do so; otherwise ple=
ase
mark the test that deals with this entry with test_expect_failure, unti=
l
somebody else does.
