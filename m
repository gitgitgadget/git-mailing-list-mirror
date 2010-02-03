From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk translation updates needed?
Date: Wed, 03 Feb 2010 14:20:12 -0800
Message-ID: <7v636ec677.fsf@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
 <201002031113.11212.barra_cuda@katamail.com>
 <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
 <201002032156.16101.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:20:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnaJ-0004eT-Jo
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621Ab0BCWU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 17:20:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab0BCWUY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 17:20:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B647496BF2;
	Wed,  3 Feb 2010 17:20:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ALurHDLmtFxy
	Wd0sea7EBq9GayE=; b=ZmUgzmtvy/iL6TFZFJMT9hwrgxListRmH0PBcB9ZAO1T
	EkVK6jlw34asw6eHUH9VYYRf4CFtOnm/S2N0htH4OEpSTCMnoiM/8JnkajY6T8T7
	hI6Vnaz7OAYVZJNtY6Sdlb19XwL40VAUul4C8esY803uutR3ngYrRvyNl/ebssw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZQeEYm
	b6eXycBNzZIKdzdA3yXvGuwrXVyTsh6k2AnNoevn9UCUFLfWWLhdrL6Ooz/HduOe
	SfTDQZV2ZtZpApwSGWqSJu6C6Oic2H7ZPSG1mg7Mo6dgjxd34b4c42KdqUSqPiY4
	OPJyfA8zABYDQfWTUUp0g709sW2krpaJCif+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 826C696BF1;
	Wed,  3 Feb 2010 17:20:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8308796BEC; Wed,  3 Feb
 2010 17:20:14 -0500 (EST)
In-Reply-To: <201002032156.16101.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Wed\, 3 Feb 2010 21\:56\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F7C8C12-1112-11DF-9E9F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138908>

Michele Ballabio <barra_cuda@katamail.com> writes:

>>  $ make po/gitk.pot
>>  $ msgmerge -U po/it.po po/gitk.pot ;# and for other languages...
>>  $ make po/it.msg
>
> Yes, with these steps it.po now contains:
>
> #: gitk:2782
> #, fuzzy
> msgid ""
> "\n"
> "Gitk - a commit viewer for git\n"
> "\n"
> "Copyright =C2=A99 2005-2009 Paul Mackerras\n"
> "\n"
> "Use and redistribute under the terms of the GNU General Public Licen=
se"
>
> The "fuzzy" attribute is bogus but is understandable, because
> the msgid changed: "=C2=A9" became "=C2=A99". What I don't get is:
> why "=C2=A9" became "=C2=A99"? Was it a needed change or just an over=
sight?

Very interesting.

The last commit that touched the copyright line in gitk was aa43561 (gi=
tk:
Don't compare fake children when comparing commits, 2009-09-10) that
updated the years.  But the commit did not change the circle-c symbol a=
t
all:

    $ git show --format=3D'%H' -U1 aa43561a | head -n 10 | tail -n 2 | =
od -cx
    0000000   -   #       C   o   p   y   r   i   g   h   t     302 251=
   =20
            232d 4320 706f 7279 6769 7468 c220 20a9
    0000020   2   0   0   5   -   2   0   0   8       P   a   u   l    =
   M
    ...
    0000100   +   #       C   o   p   y   r   i   g   h   t     302 251=
   =20
            232b 4320 706f 7279 6769 7468 c220 20a9
    0000120   2   0   0   5   -   2   0   0   9       P   a   u   l    =
   M

"make po/gitk.pot" which is "xgettext -kmc -LTcl -o po/gitk.pot gitk"
however produces this:

    $ grep Paul po/gitk.pot | od -cx
    0000000   "   C   o   p   y   r   i   g   h   t     302 251   9    =
   2
            4322 706f 7279 6769 7468 c220 39a9 3220
    0000020   0   0   5   -   2   0   0   9       P   a   u   l       M=
   a
    ...

Notice that "302 251 9"?

Is this a bug in "gettext", perhaps?
