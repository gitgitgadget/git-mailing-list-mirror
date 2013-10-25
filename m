From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] merge-base: "--reflog" mode finds fork point from
 reflog entries
Date: Fri, 25 Oct 2013 10:17:03 +0200
Message-ID: <526A28FF.4000207@viscovery.net>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com> <1382641884-14756-1-git-send-email-gitster@pobox.com> <1382641884-14756-3-git-send-email-gitster@pobox.com> <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com> <xmqq61smmkc0.fsf@gitster.dls.corp.google.com> <CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com> <xmqqwql2l3ln.fsf@gitster.dls.corp.google.com> <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com> <526A19CA.9020609@viscovery.net> <20131025080923.GG10779@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Oct 25 10:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZcaG-0007sz-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 10:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3JYIRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 04:17:10 -0400
Received: from so.liwest.at ([212.33.55.16]:64434 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab3JYIRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 04:17:09 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VZcZr-0001Bz-HQ; Fri, 25 Oct 2013 10:17:03 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 69AF116613;
	Fri, 25 Oct 2013 10:17:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20131025080923.GG10779@serenity.lan>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236696>

Am 10/25/2013 10:09, schrieb John Keeping:
> On Fri, Oct 25, 2013 at 09:12:10AM +0200, Johannes Sixt wrote:
>> You could put the loops into a function from which you 'return', but that
>> is obscure in this case. The first iteration was better, IMO.
> 
> Wouldn't it be simpler to just return from the test?  That is, replace
> the "break" in the above patch with "return 1".

Good catch! We explicitly have

test_eval_ () {
	# This is a separate function because some tests use
	# "return" to end a test_expect_success block early.
	eval </dev/null >&3 2>&4 "$*"
}

to protect this use of return.

-- Hannes
