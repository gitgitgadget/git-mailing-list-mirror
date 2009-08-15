From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: Give friendlier errors when there is nothing
 to apply
Date: Fri, 14 Aug 2009 18:50:50 -0700
Message-ID: <7vmy616e11.fsf@alter.siamese.dyndns.org>
References: <200908111409.04506.trast@student.ethz.ch>
 <4a81787d.0e0f660a.5238.4c8b@mx.google.com>
 <7v3a7ujhqb.fsf@alter.siamese.dyndns.org>
 <20090815063956.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ori Avtalion <ori@avtalion.name>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 03:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc8QC-00017d-6k
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 03:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbZHOBu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 21:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbZHOBu4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 21:50:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650AbZHOBuz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 21:50:55 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21A7AB383;
	Fri, 14 Aug 2009 21:50:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E91CB382; Fri, 14 Aug
 2009 21:50:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 133A7752-893E-11DE-B50E-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125974>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
> ...
>> A tangent; we might want an analogue to "shortlog -s -n" but based o=
n
>> "blame".
>
> I'm sorry, I don't understand what you mean.

I often use shortlog to find whom to CC to, but sometimes blame output
gives us a much better picture.

$ git shortlog -s -n git-stash.sh | head -n 6
    22	Junio C Hamano
     4	Brandon Casey
     2	Jeff King
     2	Johannes Schindelin
     2	Nanako Shiraishi
     2	SZEDER G=C3=A1bor

$ git blame -w git-stash.sh |
  sed -e 's/^[0-9a-f]* (\(.*\) *200[7-9]-..-.. .*/\1/' |
  sort | uniq -c | sort -n -r | head -n 6
    110 Nanako Shiraishi   =20
     86 Junio C Hamano     =20
     55 Stephen Boyd       =20
     33 Brandon Casey      =20
     20 Abhijit Menon-Sen  =20
     16 Johannes Schindelin=20
