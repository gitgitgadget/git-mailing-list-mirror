From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix git format-patch --cc=<email> format
Date: Sat, 28 Feb 2009 09:29:58 -0800
Message-ID: <7vy6vqfp0p.fsf@gitster.siamese.dyndns.org>
References: <1235824944-4967-1-git-send-email-bergwolf@gmail.com>
 <76718490902280815if1c3fa7o790112b410d52224@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peng Tao <bergwolf@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 18:31:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdT2L-0004SW-Fw
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 18:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZB1RaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 12:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbZB1RaN
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:30:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbZB1RaM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 12:30:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA7399DDC4;
	Sat, 28 Feb 2009 12:30:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0A7A59DDC1; Sat,
 28 Feb 2009 12:30:04 -0500 (EST)
In-Reply-To: <76718490902280815if1c3fa7o790112b410d52224@mail.gmail.com> (Jay
 Soffian's message of "Sat, 28 Feb 2009 11:15:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 729ADB9C-05BD-11DE-AD86-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111778>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Sat, Feb 28, 2009 at 7:42 AM, Peng Tao <bergwolf@gmail.com> wrote:
>> If there are multiple --cc=3D<email> arguments, git format-patch wil=
l generate
>> patches with cc lines like:
>> =C2=A0Cc: <email>,
>> =C2=A0 =C2=A0 =C2=A0<email>
>> which git send-email fails to parse.
>> git send-email only accept formats like:
>> =C2=A0Cc: <email>
>> =C2=A0Cc: <email>
>> So change git format-patch to generate patches in a proper format.
>
> This is fixed in next, but we fixed send-email instead to handle the
> messages that format-patch generates, as they should be valid.

Per RFC2822 3.6 (pp 19-20), "cc" is to appear at most once (same is tru=
e
for "to" and "bcc").  I think fix to format-patch is necessary regardle=
ss
of what send-email does.
