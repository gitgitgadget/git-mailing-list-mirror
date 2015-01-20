From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <notro@tronnes.org>
Subject: Re: Git messes up =?UTF-8?B?J8O4JyBjaGFyYWN0ZXI=?=
Date: Tue, 20 Jan 2015 22:23:40 +0100
Message-ID: <54BEC75C.3090207@tronnes.org>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de> <54BEB7ED.2050103@tronnes.org> <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:23:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgH7-0002bo-10
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbATVXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 16:23:44 -0500
Received: from asav22.altibox.net ([109.247.116.9]:34612 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbATVXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 16:23:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by asav22.altibox.net (Postfix) with ESMTP id 70E0020096;
	Tue, 20 Jan 2015 22:23:40 +0100 (CET)
Received: from asav22.altibox.net ([127.0.0.1])
	by localhost (asav22.lysetele.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PUDlD261-kfP; Tue, 20 Jan 2015 22:23:39 +0100 (CET)
Received: from [127.0.0.1] (48.81-166-104.customer.lyse.net [81.166.104.48])
	by asav22.altibox.net (Postfix) with ESMTP id 1E3652014C;
	Tue, 20 Jan 2015 22:23:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
X-Antivirus: avast! (VPS 150120-1, 20.01.2015), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262692>

Den 20.01.2015 21:45, skrev =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Tue, Jan 20, 2015 at 9:17 PM, Noralf Tr=C3=B8nnes <notro@tronnes.o=
rg> wrote:
>> Den 20.01.2015 21:07, skrev Torsten B=C3=B6gershausen:
>>> On 2015-01-20 20.46, Noralf Tr=C3=B8nnes wrote:
>>> could it be that your "=C3=B8" is not encoded as UTF-8,
>>> but in ISO-8859-15 (or so)
>>>
>>>> $ git log -1
>>>> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
>>>> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
>>> What does
>>> git config -l | grep Noralf | xxd
>>> say ?
>>>
>> $ git config -l | grep Noralf | xxd
>> 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoralf
>> 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.
>>
>> $ file ~/.gitconfig
>> /home/pi/.gitconfig: ISO-8859 text
> What's happened here is that:
>
>   1. You've authored your commit in ISO-8859-1
>   2. Git itself has no place for the encoding of the author name in t=
he
> commit object format
>   3. git-format-patch has a --compose-encoding which I think would so=
rt
> this out if you set it to ISO-8859-1, but it defaults to UTF-8
>   4. Your patch is actually a ISO-8859-1 byte sequence, but is
> advertised as UTF-8
>   5. You end up with a screwed-up commit
>
> You could work around this, but I suggest just joining the 21st
> century and working exclusively in UTF-8, it makes things much easier=
,
> speaking as someone with 3x more non-ASCII characters their his name
> than you :)
>

Ok, then the question is: How do I switch to UTF-8?

To me it seems I'm already using it:
$ locale charmap
UTF-8
