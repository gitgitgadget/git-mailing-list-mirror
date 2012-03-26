From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 26 Mar 2012 09:08:12 -0700
Message-ID: <CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
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
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	elton sky <eltonsky9404@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 18:08:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCCTM-0003cH-9H
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901Ab2CZQIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 12:08:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37893 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab2CZQIc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 12:08:32 -0400
Received: by pbcun15 with SMTP id un15so6141925pbc.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=48ClBDb93Glk5PV/5uniOLcCxvZTrOa0kaRamFnMmxA=;
        b=Fg9/ZJxVDSAiZb6TKKJ2N/BwN2BDWLlWgZnSeaxDFh7F/RTsln9i3igrG2Pu5dzrcl
         cJzCZ2qitX65NClq/DfP7nMmhVVWeQwND/GqDsAIsVuAmJgnJWgA1Zljmvwn3qndxzi1
         AW8DmvN+wDYyfGIF+BBBgyBtVeeIoH93O0dO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=48ClBDb93Glk5PV/5uniOLcCxvZTrOa0kaRamFnMmxA=;
        b=gGoAI1kRJISvjK0H6JyKpC8hBBrzPgJ0PPwqmjBaUDlnYaX/ClO3bXGh0950m6RZEt
         LuiCpptfkRCD1mtz8tS747LvdjObBzG+YEVhDql4xlUVJz5wmL1OoZ2Em7WOTlC9NaEk
         W+3O5Ty9KDpUth+W3hR/BByArqI04lr6OoStOOf9W9z1rNOPwhS4GvhdOQDL0HfLSc8p
         Hy1IHtu1wlQraNwMELl93mMAExi8DC5ofTVoWnJBWNqspRfZa79wwJsRjKcPhsPRn9w1
         nDW5ANaF4B0ttkV0fFS/371t/0f4uGfesfEUJT5IzXSM2VaoXZfKPCtNK+7JO0IPQfnN
         gV+A==
Received: by 10.68.234.106 with SMTP id ud10mr43016899pbc.128.1332778112184;
 Mon, 26 Mar 2012 09:08:32 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Mon, 26 Mar 2012 09:08:12 -0700 (PDT)
In-Reply-To: <CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
X-Gm-Message-State: ALoCoQl3ID59krzmVEB7zhjcVKWAxybZF64ER5/N+T2TlSiS888Mnson8p+YtOmgRpJTEQTB9t3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193921>

On Mon, Mar 26, 2012 at 08:25, Nguyen Thai Ngoc Duy <pclouds@gmail.com>=
 wrote:
> On Mon, Mar 26, 2012 at 9:28 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> elton sky <eltonsky9404@gmail.com> writes:
>>
>>> On Mon, Mar 26, 2012 at 12:06 PM, Nguyen Thai Ngoc Duy
>>> <pclouds@gmail.com> wrote:
>>>> (I think this should be on git@vger as there are many experienced =
devs there)
>>>>
>>>> On Sun, Mar 25, 2012 at 11:13 AM, elton sky <eltonsky9404@gmail.co=
m> wrote:
>>>>> About the new format:
>>>>>
>>>>> The index is a single file. Entries in the index still stored
>>>>> sequentially as old format. The difference is they are grouped in=
to
>>>>> blocks. A block contains many entries and they are ordered by nam=
es.
>>>>> Blocks are also ordered by the name of the first entry. Each bloc=
k
>>>>> contains a sha1 for entries in it.
>>>>
>>>> If I remove an entry in the first block, because blocks are of fix=
ed
>>>> size, you would need to shift all entries up by one, thus update a=
ll
>>>> blocks?
>>>
>>> We need some GC here. I am not moving all blocks. Rather I would
>>> consider merge or recycle the block. In a simple case if a block
>>> becomes empty, I ll change the offset of new block in the header po=
int
>>> to this block, and make this block points to the original offset of
>>> new block. In this way, I keep the list of empty blocks I can reuse=
=2E
>> [...]
>>
>> Doesn't that venture into database land?
>>
>> If we go that far, wouldn't it be better to use a proper database
>> library? =A0All other things being equal, writing such complex code =
from
>> scratch is probably not a good idea.
>
> If there's a library that fits our needs (including linking
> statically). I think we've come close to sqlite file format [1]. But
> sqlite comes with sql engine, transactional updates... that we don't
> need. Another obvious source for inspiration is file systems, but I
> dare not go that way.
>
> [1] http://www.sqlite.org/fileformat2.html

Or use LevelDb[2]. Its BSD license. Uses an immutable file format, but
writes updates to new smaller files and eventually collapses
everything back together into a bigger file. This can be a
dramatically simpler approach than dealing with your own free block
system inside of a single file. Its only real downside is needing to
periodically pay a penalty to rewrite the whole index. But this
rewrite is going to be faster than the time it takes to rewrite the
pack files for the same repository, which git gc or git repack
handles. So I don't think its actually a problem for the index.

You might even be able to take a two level approach to compacting the
LevelDb database (or something like it). In a minor compaction you
compact all of the files except the huge base file, leaving you with 2
files. A huge base file that contains the first tree the user checked
out, and a second smaller file containing any differences they have
since the initial checkout (this may just be updated stat data for a
handful of files that differed across two branches as they switched
back and forth). During a git gc or git repack, add a new stage to
collapse the base file and everything else into a single new base file
as a major compaction.

[2] http://code.google.com/p/leveldb/
