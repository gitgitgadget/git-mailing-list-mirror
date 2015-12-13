From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: fix completing unstuck email alias
 arguments
Date: Sun, 13 Dec 2015 02:00:38 +0100
Message-ID: <20151213020038.Horde.rlO28-SYLxFX00yK-iahGJs@webmail.informatik.kit.edu>
References: <1449879498-1516-1-git-send-email-szeder@ira.uka.de>
 <CA+P7+xrHhWHp8WA8EF7jzsit50uW13=-NEzf0DwNfMyu2dckhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:01:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7v2S-0002EL-8G
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 02:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbbLMBAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Dec 2015 20:00:46 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52013 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187AbbLMBAp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 20:00:45 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1a7v1l-00054l-Gh; Sun, 13 Dec 2015 02:00:41 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1a7v1i-0004Mf-DK; Sun, 13 Dec 2015 02:00:38 +0100
Received: from x590c0945.dyn.telefonica.de (x590c0945.dyn.telefonica.de
 [89.12.9.69]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 13 Dec 2015 02:00:38 +0100
In-Reply-To: <CA+P7+xrHhWHp8WA8EF7jzsit50uW13=-NEzf0DwNfMyu2dckhA@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1449968441.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282316>


Quoting Jacob Keller <jacob.keller@gmail.com>:

> On Fri, Dec 11, 2015 at 4:18 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> Completing unstuck form of email aliases doesn't quite work:
>>
>> $ git send-email --to <TAB>
>> alice   bob     cecil
>> $ git send-email --to a<TAB>
>> alice   bob     cecil
>>
>
> Woops. Is it possible to add a test for this case? I honestly don't
> know how the tests for the completion works.

It's possible, but I'm not sure we should.

It's a common pattern throughout the completion script to call
__gitcomp() (or __gitcomp_nl()) this way, out of the almost 200
callsites many look like this one.  We don't test all those, because
it would require a lot of tests for not that much gain in coverage
in my opinion.  The interesting thing that's definitely worth testing
is what happens inside the command substitution that supplies the
possible completion words, but your tests added to the send-email
testsuite already cover that thoroughly.

G=C3=A1bor
