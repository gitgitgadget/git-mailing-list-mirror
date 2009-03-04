From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow
 clone may work
Date: Wed, 04 Mar 2009 02:45:54 -0800
Message-ID: <7vvdqp5zx9.fsf@gitster.siamese.dyndns.org>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com>
 <1236080017-13987-1-git-send-email-dato@net.com.org.es>
 <49AD1B22.6050201@viscovery.net> <20090303120856.GB15003@chistera.yi.org>
 <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com>
 <20090304101939.GA7142@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Leodc-0001qG-IX
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbZCDKqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 05:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZCDKqL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:46:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbZCDKqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 05:46:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EF7A9EDD5;
	Wed,  4 Mar 2009 05:46:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 367969EDD4; Wed,
  4 Mar 2009 05:45:57 -0500 (EST)
In-Reply-To: <20090304101939.GA7142@chistera.yi.org> (Adeodato =?utf-8?Q?S?=
 =?utf-8?Q?im=C3=B3's?= message of "Wed, 4 Mar 2009 11:19:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA285578-08A9-11DE-BC7D-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112201>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

>> Wy not just say "pushing into a shallow repository is not supported"
>> instead of "pushing into a shallow repository won't work."
>
> I don't think such a wording is enough (adjusted, of course, to be ab=
out
> pushing from, not to, which is the case at hand).
>
> But I'll try to stay silent, and see if Junio has an opinion on the
> matter.

I would be a terrible judge for things like this; I lost my git virgini=
ty
long time ago.

If I have to say something on this...

 * I think "is not supported" is a succinct way to give good enough
   information, but it would only work for intelligent people.

 * Not everybody is intelligent; some try it out themselves, see that t=
he
   operation _seems to_ work for their limited number of trials, and wo=
uld
   conclude it would work most of the time.  And they congratulate thei=
r
   own intelligence for saying "most of the time", not "always".  And t=
hey
   get upset when they see it does not work, even though they have been
   warned.

 * Hence, I do not think "is not supported" is a statement that is a bi=
t
   too weak.  At least you need to say "it may seem to work, but no
   guarantees", _if_ your objective is to cover the backside of "shallo=
w".

But I do not think that is what we should be aiming for to begin with.

It is not like nobody can precisely answer when "pushing from shallow"
works and when it doesn't.  It would be true for a hack that was not we=
ll
designed but merely was meant to be "good enough for most of the time",
but I do not think "shallow" is that horrible a hack.

Isn't the rule more or less like:

    If your shallow repository's history does not extend long enough an=
d
    the other repository forked before your truncated history, wyou can=
not
    compute the common ancestor and you cannot push out.
