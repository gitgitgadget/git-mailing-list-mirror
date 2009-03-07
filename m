From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 06 Mar 2009 23:18:37 -0800
Message-ID: <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
References: <cover.1236377358.git.jaysoffian@gmail.com>
 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com> <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com> <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com> <7vr61aqngu.fsf@gitster.siamese.dyndns.org> <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com> <7v63imqhcz.fsf@gitster.siamese.dyndns.org> <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 08:20:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfqpy-0004l6-5Z
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 08:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbZCGHSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 02:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbZCGHSt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 02:18:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbZCGHSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 02:18:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FC2F9F720;
	Sat,  7 Mar 2009 02:18:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F0B379F71D; Sat,
  7 Mar 2009 02:18:39 -0500 (EST)
In-Reply-To: <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com> (Jay
 Soffian's message of "Fri, 6 Mar 2009 20:56:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31459FD0-0AE8-11DE-A956-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112516>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Fri, Mar 6, 2009 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> I think it would be much better if you did not introduce a new
>> configuration merge.options which is not consistent with everything =
else
>> to begin with.
>>
>> Instead, if your addition was literally to allow saying things like =
this,
>> it would be much easier to understand.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[branch "*"]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mergeoptions =
=3D ...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D or=
igin
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =3D tr=
ue
>
> Okay. That's probably a more invasive patch, because a lot more code
> paths look at [branch ...], but I'll look into it.

Note that you do not have to cover branch.*.remote and other things in =
the
same patch.  The first one could just handle branch.*.mergeoptions and =
you
can let later patches to implement the fallbacks for other variables.
