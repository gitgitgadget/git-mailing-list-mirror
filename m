From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 6 Feb 2008 10:44:53 +0100
Message-ID: <EA30530E-B917-48CA-A43B-FAAF9721A9ED@wincent.com>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> <7v3as6321y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>, srp@srparish.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgql-0007t6-2k
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760232AbYBFJpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 04:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760079AbYBFJpS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:45:18 -0500
Received: from wincent.com ([72.3.236.74]:60437 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759819AbYBFJpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 04:45:16 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m169isvq016297;
	Wed, 6 Feb 2008 03:44:55 -0600
In-Reply-To: <7v3as6321y.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72785>

El 6/2/2008, a las 9:46, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> This fails with the "remote end hung up unexpectedly" error:
>>
>>   # /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah
>>
>> Drop the --inetd option and it works with no errors:
>
> Do you mean you run the above from your command line and it
> fails?

Yes.

> I do not think --inetd mode is supposed to work as a daemon that
> accepts connections.  Wouldn't it be talking with a single peer
> via its stdin/stdout?

I don't know exactly what it does under the covers (will look now). =20
Perhaps it detects that its running from an interactive login and =20
modifies its behaviour. But all I can confirm is that in 1.5.3.8 (and =20
before 511707d42b3b3e57d9623493092590546ffeae80) "git daemon" works =20
from the command line both with and without the --inetd option, and in =
=20
1.5.4 (from that commit onwards) "git daemon" doesn't work for me with =
=20
the --inetd option but it does without it. The testing from the =20
command line is really only a diagnostic thing (perhaps misguided), =20
but it does exhibit the same behaviour as issuing the same command =20
within xinetd.

Cheers,
>

Wincent
