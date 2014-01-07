From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3] stash: handle specifying stashes with spaces
Date: Tue, 07 Jan 2014 23:17:30 +0100
Message-ID: <87ob3nphc5.fsf@thomasrast.ch>
References: <1389082935-16159-1-git-send-email-oystwa@gmail.com>
	<xmqq7gabeiqo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0exz-0004Up-1u
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbaAGWRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 17:17:38 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:60952 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbaAGWRi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 17:17:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E59094D659A;
	Tue,  7 Jan 2014 23:17:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id P-qyYJcXMorw; Tue,  7 Jan 2014 23:17:31 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id E69F14D6590;
	Tue,  7 Jan 2014 23:17:30 +0100 (CET)
In-Reply-To: <xmqq7gabeiqo.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jan 2014 10:42:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240174>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=98ystein Walle <oystwa@gmail.com> writes:
>
>> +	git stash &&
>> +	test_tick &&
>> +	echo cow > file &&
>> +	git stash &&
>> +	git stash apply "stash@{Thu Apr 7 15:17:13 2005 -0700}" &&
>
> This is brittle.  If new tests are added before this, the test_tick
> will give you different timestamp and this test will start failing.
>
> Perhaps grab the timestamp out of the stash that was created [...]

Hmm, now that I stare at this, why not simply use something like

  git stash apply "stash@{ 0 }"

It seems to refer to the same as stash@{0} as one would expect, while
still triggering the bug with unpatched git-stash.

--=20
Thomas Rast
tr@thomasrast.ch
