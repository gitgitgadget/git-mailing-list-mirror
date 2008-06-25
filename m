From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Wed, 25 Jun 2008 02:14:37 -0700
Message-ID: <7vzlp93mgy.fsf@gitster.siamese.dyndns.org>
References: <m31w2mlki4.fsf@localhost.localdomain>
 <7vod5qa0tu.fsf@gitster.siamese.dyndns.org> <20080625022610.GB20361@mit.edu>
 <200806251058.54319.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Jeske <jeske@google.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBR6a-0004OL-68
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbYFYJPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 05:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754358AbYFYJPA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 05:15:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbYFYJO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 05:14:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCC8218149;
	Wed, 25 Jun 2008 05:14:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9D1C818148; Wed, 25 Jun 2008 05:14:46 -0400 (EDT)
In-Reply-To: <200806251058.54319.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 25 Jun 2008 10:58:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E7F79AC-4297-11DD-844C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86260>

Jakub Narebski <jnareb@gmail.com> writes:

> On Wed, 25 Jun 2008, Theodore Tso wrote:
>
>> The reason why I've been thinking that I should change my shell scri=
pt
>> from:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git checkout integra=
tion
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git reset --hard <fo=
o>
>>=20
>> to:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git update-ref ref/h=
eads/integration HEAD
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git checkout integra=
tion
>
> Hmmmm.... Wouldn't it be easier on fingers to use
>
>           git reset --soft integration

That does not do anything close to what Ted is doing, does it?

Anyway, here is how I conclude my git day:

	git checkout next
        ... merge more and test
        ... be happy that next is in very good shape ;-)
        git branch -f pu
        git checkout pu
        git merge ... merge other topics to rebuild pu
        git merge ...
        ...

which is probably a bit less error prone then update-ref, if you type f=
rom
the command line like I do.
