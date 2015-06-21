From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 20:27:53 +0200
Organization: gmx
Message-ID: <3faa92b10274ce8cfebe340761f73505@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq1th77829.fsf@gitster.dls.corp.google.com>
 <95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
 <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
 <558643CA.6000303@alum.mit.edu>
 <xmqqioahj849.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 20:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6jyR-00031j-3x
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbbFUS2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 14:28:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:64354 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbbFUS2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:28:00 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MKYpv-1Z4opQ1gUZ-001vxs; Sun, 21 Jun 2015 20:27:55
 +0200
In-Reply-To: <xmqqioahj849.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:8wXMrOTR9cFeLzbd8Ot6TaDqdQt3ipoUGzgcRPRUPFxk3xkf4ho
 bwZ4CPmVhI+Ogg4sbvfgI3RRtumHIdpjNVrEFfkwAgMAtsVkJKgXH8ji90yyCoyjhVhNFnK
 lxFbo55PHz+SQHWHUV1o2xM6uCzLobtEHy4wTOyH4gEQBdw0JywEx8IexM/TQtWgLkRQtB6
 P4TOIXylimSMoMA8DFesw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TQJGG7JFJP8=:RluTPZ0TCNGMr7QARzAXp4
 pibgtkykGjlRsE3wuES/53VQohRe6C7FJJ4nIeQJLFjCvBCI/QKKc7A+ldjlq5MzjBgJUK+M3
 II7I22keRO0zYc7fuiGnAhrcLW4MJAwoCwced352ffPBP/36V+CvwTHOvLeruraOCHRRp9O11
 FgRNLhmdipG1UXj4P+zP6DFC8ATIUDUujuHC2CculVFNKBdpe/TnaxqdMvMG1iwqIubKCeYO6
 i/8IJOVGZe1h7DIZZs5hkV0/CYz9pfxQDCg64cJKIyM+pqlPKoMSAxDwdibf56uln/atRTFYJ
 EzM97wfiWV8VkMzurT9vkjTkMsHcA9ax+xrm13dbAvbGYLpJMgXHm/MJYcvlI1fTJaXtwv341
 yk3Z04Mb8Lv4uPq0x6p+wk/mavE1V3H+Hl2OOudMAyMcnnaDx5gIpxBKubCEDEPYBSmDwwfYb
 X6p+E7Ultq9PER5xqriMDMY7D3XM3sbJrWKpevoMCsm+H7VRkNTia9Yymh1nbPo6gLWd3gfr5
 c3hHGacuB3kbdkCiIYbSdjoloLaP41G8KhmF4taeHGnq08ghVLybbAQ2Apq051HuxRLrUjKIg
 PaIKHY+xhDzSm6ySAYC5MmN+L9ISTPptgt6gzc3L4XqrifsjtArzkjyHh58AmsygXjVPk60CO
 nJxfREvO4/rMDausWEqBAhRsXHKQfPGt79rB+kjTGQ+E5bI1jdG2KMq5mRJM3Cb8Vdfg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272277>

Hi Junio,

On 2015-06-21 19:15, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> But now that I'm writing this, a silly question occurs to me: Do we need
>> an overall option like this at all? If I demote all blob-integrity
>> checks to "ignore" via the mechanism that you have added, then shouldn't
>> fsck automatically detect that it doesn't have to open the blobs at all
>> and enable this speedup automatically?
> 
> That's brilliant.
> 
> Just to make sure I am reading you correctly, you mean the current
> overall structure:
> 
> [...]

The way I read Michael's mail, he actually meant something different: if all of the blob-related errors/warnings are switched to "ignore", simply skip unpacking the blobs. If I read this correctly, I would like to point out that introducing a future blob-related check would require scripts to be changed to benefit from the speed-up, unless the `--quick` option is *also* introduced.

The way I read your suggestion, however, was to introduce *yet another* message ID: BAD_BLOB. If that one is turned to "ignore", we simply won't look at blobs' contents at all.

I like that idea, together with:

>> --quick: Skip some expensive checks, dramatically reducing the
>>     runtime of `git fsck`. Currently this is equivalent to
>>     `--no-check-blob-integrity`.

... where this would become `-c fsck.badBlob=ignore`.

>> In the future if we invent other expensive checks we might also add them
>> to the list of things that are skipped by `--quick`.
> 
> Yes, that is doubly brilliant. Taken together with the auto-skipping
> of the checks based on the report settings, it makes it unnecessary
> to even introduce --[no-]check-blob-integrity or any other new
> knobs.
> 
> Very well analysed.  I am happy with the "--quick" with that
> definition.

Did I understand you correctly? If so, I will gladly implement this tomorrow and send out v7.

Ciao,
Dscho
