From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] Add MSVC porting header files.
Date: Tue, 18 Aug 2009 03:42:26 -0700
Message-ID: <7v4os5jtd9.fsf@alter.siamese.dyndns.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
 <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
 <1976ea660908171915v62fb6c40j17f750cac9836433@mail.gmail.com>
 <alpine.DEB.1.00.0908181140460.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 12:42:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdM9J-00084L-KY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 12:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbZHRKmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 06:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbZHRKmc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 06:42:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZHRKmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 06:42:32 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1DC6F649;
	Tue, 18 Aug 2009 06:42:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0975F648; Tue, 18 Aug
 2009 06:42:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908181140460.4680@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Tue\, 18 Aug 2009 11\:47\:46 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5B0794C-8BE3-11DE-A470-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126371>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 18 Aug 2009, Frank Li wrote:
>
>> >> Add unix head file, dirent.h, unistd.h =C2=A0and time.h
>> >
>> > These are copied from somewhere. =C2=A0From where? =C2=A0What is t=
he license?
>>=20
>> It comes from msys,  which used to build msysgit.
>
> I know.  After reading the patch.  But it would be better if everybod=
y=20
> knew after reading the commit message...  _Especially_ in this=20
> increasingly lawsuit-defined business, it is very nice to see early t=
hat=20
> the files you are including here are in the public domain, and come f=
rom=20
> MSys.

And there was this line in the snarfed file:

    * No warranty is given; refer to the file DISCLAIMER within the pac=
kage.

but there no DISCLAIMER file (perhaps a separate patch added it, but I
somehow doubt it).

> As I said earlier, there are common flags, but as I also said, it is=20
> probably better to keep the #define's in a header file for better=20
> visibility and editability, albeit in logically clustered blocks (i.e=
=2E all=20
> the NO_* and other #define's that affect what source code is=20
> compiled, all default paths in another cluster, #define's to bow befo=
re=20
> Microsoft's C runtime's decision to deprecate the C99 standard functi=
on=20
> names, etc)

=2E.. and that can live in a separate header file to reduce clutter and
shield people who do not need to look at MSC related code, no?
