From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix a bunch of pointer declarations (codestyle)
Date: Fri, 01 May 2009 15:59:57 -0700
Message-ID: <7veiv8v382.fsf@gitster.siamese.dyndns.org>
References: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
 <780e0a6b0905011220g42d9784dp186cc7ff7669081e@mail.gmail.com>
 <20090501203910.GA15549@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 02 01:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M01iO-0007pi-Tv
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 01:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbZEAXAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 19:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbZEAXAL
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 19:00:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbZEAXAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 19:00:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C43813ED8;
	Fri,  1 May 2009 19:00:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 72D8C13ECB; Fri, 
 1 May 2009 19:00:00 -0400 (EDT)
In-Reply-To: <20090501203910.GA15549@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 1 May 2009 16:39:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1CACBE2-36A3-11DE-897F-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118106>

Jeff King <peff@peff.net> writes:

> On Fri, May 01, 2009 at 12:20:08PM -0700, Stephen Boyd wrote:
>
>> On Fri, May 1, 2009 at 2:06 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 *argv =3D xmalloc(sizeof(char*) * size);
>> > + =C2=A0 =C2=A0 =C2=A0 *argv =3D xmalloc(sizeof(char *) * size);
>> >
>>=20
>> I don't think this is what the coding guidelines is talking about. A
>> pointer isn't being declared here plus there isn't any variable the
>> star should be sticking to.

I think either way is fine although I personally prefer the way the pat=
ch
did.  The "prefer sizeof(var) over sizeof(type)" principle is good, but
that should be a follow-up patch, as it is very likely such a conversio=
n
will introduce a silly mistake, perhaps like this one.

> Besides that, don't we usually prefer sizeof() on the actual variable
> instead of the type, which is less error prone? IOW,
>
>   *argv =3D xmalloc(sizeof(**argv) * size);
