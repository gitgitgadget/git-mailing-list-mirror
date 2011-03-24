From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Thu, 24 Mar 2011 11:33:44 -0700
Message-ID: <7vtyes8j1z.fsf@alter.siamese.dyndns.org>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org>
 <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
 <AANLkTikjN_90UApfD2rRksDk8qXyE6pJHhd00Aw-Qe7Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:34:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2pM8-0000d4-EM
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 19:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400Ab1CXSdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 14:33:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933288Ab1CXSdx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 14:33:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5100748CF;
	Thu, 24 Mar 2011 14:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5sdw7WtIPk8i
	+IlmJHQ/qcrE7B0=; b=WS6IVcj6TbsO1u0U82yNAQ2aJe8tGFs5MaBGbaKdX2/r
	dkaRlK7aHQkzM5wJHsz8GVqbL/AxHmWCwyHkREcNrwI/sS6h0IE4K+iSMmRACiJr
	IpIwPJj8QafXDvnIPocW1FrEHUh2yUh/aBB+UKK1wm+LdbmpPkcgzwkgrrbgO/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l02Lnr
	i+PjbJPj8lT3gJfesF1O1C6NXrxqIKhXCyTiMBmQUb0jy4LQyBGRFs+idIQWBCtT
	nZg2EMC84cb9Y5dR+jAg9Xtgjiflsu1f3DC7TpfmeUs7TubgUbFvZgx9YwttvV1P
	tNvRf3cKPFf5cwiYWKB65Ghwv27KaoQcBTr/o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17BC948CD;
	Thu, 24 Mar 2011 14:35:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 04D7B48CC; Thu, 24 Mar 2011
 14:35:28 -0400 (EDT)
In-Reply-To: <AANLkTikjN_90UApfD2rRksDk8qXyE6pJHhd00Aw-Qe7Y@mail.gmail.com>
 (Jay Soffian's message of "Thu, 24 Mar 2011 14:11:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FEC3680-5645-11E0-9BF9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169937>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Mar 23, 2011 at 5:45 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> ... this is not consistent ...
>
>> The new code does not issue a warning against "git diff ..B" that is=
 used
>> as a shorthand for "git diff HEAD B", and "git diff A.." that is use=
d as a
>> shorthand for "git diff A HEAD", respectively. =C2=A0These are short=
er to type
>> and are often useful.
>
> ...with this.

I already _know_ it is not consistent.  My verdict is that shoter-to-ty=
pe
and being useful trumps that minor consistency argument and that is why
the patch is like so, and that is why the proposed commit log message
clearly describes the choice.

> I use diff A..B all the time, because I've often just used log A..B,
> or I'm about to, and it's one less part of the command line to change=
=2E

OK.  I hereby designate you as the official cluebat wearer responsible =
for
explaining things whenever new people get confused and say that the out=
put
from "git diff A..B" does not match what they expect from "git log A..B=
",
(and "git diff A...B" vs "git log A...B") on this list.

Thanks ;-).
