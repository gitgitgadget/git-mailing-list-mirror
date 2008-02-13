From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Wed, 13 Feb 2008 14:14:43 -0800
Message-ID: <7vk5l8o65o.fsf@gitster.siamese.dyndns.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
 <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
 <76718490802120840r4a45c016k4cccf321f68893ce@mail.gmail.com>
 <200802130755.20884.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jay Soffian" <jaysoffian@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPPt2-0001xu-8L
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYBMWOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYBMWOx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:14:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYBMWOw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 17:14:52 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F34C83E5B;
	Wed, 13 Feb 2008 17:14:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 293503E5A; Wed, 13 Feb 2008 17:14:45 -0500 (EST)
In-Reply-To: <200802130755.20884.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed, 13 Feb 2008 07:55:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73821>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le mardi 12 f=C3=A9vrier 2008, Jay Soffian a =C3=A9crit :
>> On Feb 10, 2008 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Also I wonder why the check for SECURITYSESSIONID your original
>> > had is not good enough for this Mac specific customization?
>>
>> Christian,
>>
>> Any thoughts on Junio's patch vs the original?
>
> I think the original was good and Junio's patch is a good improvement=
 on top=20
> of yours.

I think the original that only checked SECURITYSESSIONID was
short, sweet and inexpensive.

Unless somebody comes up with a good reason that the environment
check for SECURITYSESSIONID would misidentify (my understanding
is that it is a MacOS specific hack^Wenvironment variable and
nobody else would have it, but I haven't found authoritative
source), I think the original from Jay is good and I can apply
it to 'master'.

I very much had trouble with the $(uname -s) thing which
unconditionally penalized everybody else, and that was the
primary reason I suggested an alternative to make it cheaper.
