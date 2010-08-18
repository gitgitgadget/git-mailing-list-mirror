From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 18 Aug 2010 09:52:09 -0600
Message-ID: <4C6C01A9.4080306@workspacewhiz.com>
References: <cover.1281985411.git.j6t@kdbg.org>	<513deaf9e8915473f7fc7f32401b17e383cb7d3a.1281985411.git.j6t@kdbg.org>	<AANLkTi=mH9WPbJMKXRrgvdcuqZfHj1kC49M0jKUhaYeS@mail.gmail.com> <AANLkTi=V1-vNjA36BXC5OD+ek-S_1RLVBFt==atxtJk5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 17:52:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlkwC-0006fP-Cu
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 17:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0HRPwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 11:52:16 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:46270 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab0HRPwP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 11:52:15 -0400
Received: (qmail 25866 invoked by uid 399); 18 Aug 2010 09:52:12 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@70.201.215.179)
  by hsmail.qwknetllc.com with ESMTPAM; 18 Aug 2010 09:52:12 -0600
X-Originating-IP: 70.201.215.179
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=V1-vNjA36BXC5OD+ek-S_1RLVBFt==atxtJk5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153864>

  ----- Original Message -----
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
Date: 8/18/2010 6:53 AM
> On Wed, Aug 18, 2010 at 12:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
<avarab@gmail.com>  wrote:
>> On Mon, Aug 16, 2010 at 19:38, Johannes Sixt<j6t@kdbg.org>  wrote:
>>> +       return fnmatch(pattern, string, flags | (ignore_case ? FNM_=
CASEFOLD : 0));
>> On Solaris 10:
>>
>> dir.c: In function `fnmatch_icase':
>> dir.c:34: error: `FNM_CASEFOLD' undeclared (first use in this functi=
on)
>> dir.c:34: error: (Each undeclared identifier is reported only once
>> dir.c:34: error: for each function it appears in.)
> Actually, reading the fnmatch manpage it's not just Solaris, but all
> non-GNU systems:
>
>         FNM_CASEFOLD - If this flag (a GNU extension) is set, the pat=
tern is matched case-insensitively
Well, that's no good.  :(

Thanks for the research.  It helps tremendously.

One easy way out of this situation would be to duplicate the GNU=20
fnmatch() into fnmatch_icase().  I have not looked at the source code,=20
so it may not be possible.  If it can be copied in, does anyone object?

I'll also look for a non-GNU function that may work.

Josh
