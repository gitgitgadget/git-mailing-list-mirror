From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Fri, 18 Apr 2008 23:51:08 -0700
Message-ID: <7vfxtiibhf.fsf@gitster.siamese.dyndns.org>
References: <87od88eslq.dlv@maison.homelinux.org>
 <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
 <6b8a91420804170844t2776e8a7sf735e3f87a95298b@mail.gmail.com>
 <7vskxjj9rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0804181135540.2779@woody.linux-foundation.org>
 <6b8a91420804181513m139baf06x41d8efeb7acd49a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 17:55:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn6w2-0005cy-2f
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 08:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYDSGv1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Apr 2008 02:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYDSGv1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 02:51:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYDSGv0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 02:51:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 58AEA1CBA;
	Sat, 19 Apr 2008 02:51:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5CF611CA2; Sat, 19 Apr 2008 02:51:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79895>

"R=C3=A9mi Vanicat" <vanicat@debian.org> writes:

> 2008/4/18, Linus Torvalds <torvalds@linux-foundation.org>:
>>
>>
>>  On Fri, 18 Apr 2008, Junio C Hamano wrote:
>>  >
>>  > -             (echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
>>  > +             (printf '%s\n' "$SUBJECT" ; echo ; cat "$dotest/msg=
") |
>>
>>
>> Well, get rid of the superfluous second 'echo' then too, replacing i=
t
>>  with another '\n'. IOW:
>>
>>         ( printf '%s\n\n' "$SUBJECT" ; cat "$dotest/msg" ) |
>>
>>  instead.
>
> This work for me: no more test failure on my computer

Thanks for confirmation.  I reproduced the breakage and the fix myself
with "make SHELL_PATH=3D/bin/dash" myself, too.
