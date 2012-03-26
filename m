From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 26 Mar 2012 22:25:59 +0700
Message-ID: <CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
 <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
 <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
 <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com> <87iphrjv23.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: elton sky <eltonsky9404@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 26 17:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCBob-0004DS-8m
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 17:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733Ab2CZP0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 11:26:31 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43858 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659Ab2CZP0a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 11:26:30 -0400
Received: by wibhr17 with SMTP id hr17so3887659wib.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gnga7XeHLuvnsD/1Vz9R96HPj22rGDullZ0siqOSfbo=;
        b=nmAG0Kg6TlkZEYcfXtp4LqjWxvBIo9QDbANd8S0Jx2usCwi1l+3l34fcmJloTIh7CR
         a2owIo4AJxMf5yD57Jd6t7X+tineJOC5L26dd3xqMDPJDxc0oMKRpX1MPW51Wmnwg7IC
         j1JcWMqxY0eebjLvavZziX6p+gNj5vsEco9UEbbIl8Un+hpV4zFhDySj6z15AKdt4uW8
         yGEEJqleCbH1I2S27RaIbIAHdUlDBiDE0Pdkrz4PXwGK+6pqLcMcnVMpuKIQ/wlDHxCd
         lnKSDFMtpvBzdDVx6C95OYGSO0yYMRbLybtigCU5iu94GM9tqcmo+ydHa6Bi97m6gS3g
         m3Gw==
Received: by 10.180.102.102 with SMTP id fn6mr19598524wib.10.1332775589672;
 Mon, 26 Mar 2012 08:26:29 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 26 Mar 2012 08:25:59 -0700 (PDT)
In-Reply-To: <87iphrjv23.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193918>

On Mon, Mar 26, 2012 at 9:28 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> elton sky <eltonsky9404@gmail.com> writes:
>
>> On Mon, Mar 26, 2012 at 12:06 PM, Nguyen Thai Ngoc Duy
>> <pclouds@gmail.com> wrote:
>>> (I think this should be on git@vger as there are many experienced d=
evs there)
>>>
>>> On Sun, Mar 25, 2012 at 11:13 AM, elton sky <eltonsky9404@gmail.com=
> wrote:
>>>> About the new format:
>>>>
>>>> The index is a single file. Entries in the index still stored
>>>> sequentially as old format. The difference is they are grouped int=
o
>>>> blocks. A block contains many entries and they are ordered by name=
s.
>>>> Blocks are also ordered by the name of the first entry. Each block
>>>> contains a sha1 for entries in it.
>>>
>>> If I remove an entry in the first block, because blocks are of fixe=
d
>>> size, you would need to shift all entries up by one, thus update al=
l
>>> blocks?
>>
>> We need some GC here. I am not moving all blocks. Rather I would
>> consider merge or recycle the block. In a simple case if a block
>> becomes empty, I ll change the offset of new block in the header poi=
nt
>> to this block, and make this block points to the original offset of
>> new block. In this way, I keep the list of empty blocks I can reuse.
> [...]
>
> Doesn't that venture into database land?
>
> If we go that far, wouldn't it be better to use a proper database
> library? =C2=A0All other things being equal, writing such complex cod=
e from
> scratch is probably not a good idea.

If there's a library that fits our needs (including linking
statically). I think we've come close to sqlite file format [1]. But
sqlite comes with sql engine, transactional updates... that we don't
need. Another obvious source for inspiration is file systems, but I
dare not go that way.

[1] http://www.sqlite.org/fileformat2.html
--=20
Duy
