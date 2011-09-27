From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 10:01:56 +0100
Message-ID: <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org>
 <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
 <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 11:02:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8TYF-000852-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 11:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab1I0JCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 05:02:00 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:47464 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456Ab1I0JCA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 05:02:00 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id E8D2EC060C;
	Tue, 27 Sep 2011 10:01:58 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 2C8BE36A831;
	Tue, 27 Sep 2011 10:01:58 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wNFp9YBLWF03; Tue, 27 Sep 2011 10:01:57 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 71C4636A6DD;
	Tue, 27 Sep 2011 10:01:56 +0100 (BST)
In-Reply-To: <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182223>

On Tue, 27 Sep 2011 10:20:29 +0200, Sverre Rabbelier wrote:
> Heya,
>
> On Tue, Sep 27, 2011 at 01:26, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
>> Back when I made that change, I failed to notice that get_ref_dir=20
>> was
>> recursive for subdirectories ... sorry ...
>>
>> Hopefully this should speed things up. =C2=A0My test repo went from =
~17m=20
>> user
>> time, to ~2.5s.
>> Packing still make things much faster of course.
>
> Can we perhaps also have some tests to prevent this from happening=20
> again?

Um ... any suggestion what to test?

It has to be hot-cache, otherwise time taken to read the refs from disk=
=20
will mean that it is always slow.  On my Mac it seems to _always_ be=20
slow reading the refs from disk, so even the "fast" case still takes=20
~17m.

Also, what counts as ok, and what as broken?

--=20
Julian
