From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 10:36:02 +0100
Message-ID: <995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org> <7voddv6fxz.fsf@gitster.siamese.dyndns.org> <buozlxfeu0z.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isb9u-0006As-L9
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbXKOJg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 04:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756421AbXKOJg2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:36:28 -0500
Received: from wincent.com ([72.3.236.74]:39312 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283AbXKOJg1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 04:36:27 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAF9a3bI015478;
	Thu, 15 Nov 2007 03:36:04 -0600
In-Reply-To: <buozlxfeu0z.fsf@dhapc248.dev.necel.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65099>

El 15/11/2007, a las 10:29, Miles Bader escribi=F3:

> Junio C Hamano <gitster@pobox.com> writes:
>> We do not need to pipe "echo" to "sed" only to strip refs/heads/
>> from the beginning.  We are assuming not-so-ancient shells these
>> days.
>
> What's wrong with sed?

Nothing, but using it means forking a new process unnecessarily, and =20
the shorter form without sed is arguably more readable:

-		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
+		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"

Cheers,
Wincent
