From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 03/10] t4209: factor out helper function test_log_icase()
Date: Mon, 24 Mar 2014 22:45:18 +0100
Message-ID: <5330A76E.7060907@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de> <1395508560-19893-4-git-send-email-l.s.r@web.de> <xmqqa9cfqwwp.fsf@gitster.dls.corp.google.com> <20140324211006.GA13728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCh6-0003dA-KI
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbaCXVqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:46:03 -0400
Received: from mout.web.de ([212.227.15.14]:56335 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbaCXVqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:46:02 -0400
Received: from [192.168.178.27] ([79.250.180.170]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Mgwee-1WfUNr1QKO-00M7Bu; Mon, 24 Mar 2014 22:45:43
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140324211006.GA13728@sigill.intra.peff.net>
X-Provags-ID: V03:K0:8Bn++T4KnoWLpUcK/iFQh+2bhDv6z2fVoUAhYV/PMQWjeZBH6aO
 XRBM3GAdML14HnzJeViHc4SqCrMYaILP69P2/BHcKAW6CkdmqPJpvV8TVy86EqcIfoMP2LW
 yvJPmYCKA6idpEqIsi/hIX9dR7NVVfux1cC8M2YNnkmVTxkVO0AOZh1uXgUli+HdPHPu+op
 8Ag7FEVxzwRe1O3Gmh2PQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244882>

Am 24.03.2014 22:10, schrieb Jeff King:
> On Mon, Mar 24, 2014 at 11:22:30AM -0700, Junio C Hamano wrote:
>
>>> +test_log_icase() {
>>> +	test_log $@ --regexp-ignore-case
>>> +	test_log $@ -i
>>
>> &&-cascade broken?  Will squash in an obvious fix.
>
> I don't think so. This is happening outside of test_expect_success,
> which is run by test_log. So adding a && means that if the first test
> fails, we do not bother to run the second one at all, which is not wh=
at
> we want.

Right; this function runs two independent tests and && is left out=20
intentionally.

Ren=C3=A9
