From: David Barr <davidbarr@google.com>
Subject: Re: GSoC - Designing a faster index format
Date: Tue, 27 Mar 2012 14:34:44 +1100
Message-ID: <CAFfmPPM_GOkOp6-tE2=YxdrZq6TL3s4EgOjXdRKf8+ffMD29xg@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
	<CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
	<CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
	<CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
	<CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
	<87iphrjv23.fsf@thomas.inf.ethz.ch>
	<CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
	<CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
	<CAKTdtZngYaTCwd5cri=XjUu3-o44ECjDotrDBNxqYL-Kcsosnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 05:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCNBK-000386-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 05:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab2C0Deq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 23:34:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54093 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab2C0Dep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 23:34:45 -0400
Received: by yhmm54 with SMTP id m54so4353875yhm.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=BV2vAGZkF7V/HtPrFUIsDPfFSwy6kNgDi0n2GT0C6W0=;
        b=j06rfHT7iMAIg9tctZRPVYgs7fwyoSksfGKA0i0CvPOsAW2c0A5WiAv3lebcm3Uelx
         d/b9CcbTKvJB7oUtOjfjWUIiQumNwdBot4K4pdjohzCi+DUMJzdvTiFH+u1+1pM3NaOu
         VHYifWQEeMnhhPLuXGzo/muyBgHpgc7rhtNBF3C4uoBP0+FizjaH+z1SLGaTmyStwblT
         teNLanPoRHnafvmF4gT8DIWeu1Ti93aQJo8i0QCMfapREIWUgEiQfwyyE6hdtIeWQSkl
         bpgqgRzKttUT0DLi535qUwEzsV+HaaevsXZKeycUfoPEjBd+9QsHz9I7Yw/9MN2YvKJF
         aa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=BV2vAGZkF7V/HtPrFUIsDPfFSwy6kNgDi0n2GT0C6W0=;
        b=NkUFUKlE46gbOiUyw8q/EKq9IAENnd48JLePcO2SldsvCrwqENtozH09VwnFd7/1c2
         skrNeNH6Qqr5hN9TmqwGqhl6ZN2Bq6m0yI/rSr8276nAl5EziQPZTTH4GMnpmXUN1aRl
         4Eh0ENoAtJUyrEZ1RQuZmGzWmBJQTASxsfS9soLbi2mJhPw9KP+oBv8iztFESZkFN0az
         hxylJD/p7Lz3WeKeT+MmPRvxt+nLrqM15zvF26q0DTZaQs1HjRzMUVAnJ5SvyL1naQTZ
         iBxdK7aQEdL8Zcx4fNRCJEDxf3erpt0bepJULoTWk9fK/lREFO97nsy7hTlA63Swfp5L
         BX1Q==
Received: by 10.236.193.1 with SMTP id j1mr7859186yhn.40.1332819284659;
        Mon, 26 Mar 2012 20:34:44 -0700 (PDT)
Received: by 10.236.193.1 with SMTP id j1mr7859180yhn.40.1332819284563; Mon,
 26 Mar 2012 20:34:44 -0700 (PDT)
Received: by 10.101.154.34 with HTTP; Mon, 26 Mar 2012 20:34:44 -0700 (PDT)
In-Reply-To: <CAKTdtZngYaTCwd5cri=XjUu3-o44ECjDotrDBNxqYL-Kcsosnw@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQn0PlxI+rblvOhYuPuwLp3FKAfs08vAXqmrb0zMpxLd7T0sd7y4NtiapIgpuM4kVmnFvk2addF9D4IXTAiDxETIYMknt53JFlga5V52Nqm/p84c1Yb89n+AztjfbfWZUCYvc1JxgFAWYPPlokDXPKwpXN/RrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194001>

On Tue, Mar 27, 2012 at 1:49 PM, elton sky <eltonsky9404@gmail.com> wrote:
> Thanks Shawn,
>
>> Or use LevelDb[2]. Its BSD license. Uses an immutable file format, but
>> writes updates to new smaller files and eventually collapses
>> everything back together into a bigger file. This can be a
>> dramatically simpler approach than dealing with your own free block
>> system inside of a single file. Its only real downside is needing to
>> periodically pay a penalty to rewrite the whole index. But this
>> rewrite is going to be faster than the time it takes to rewrite the
>> pack files for the same repository, which git gc or git repack
>> handles. So I don't think its actually a problem for the index.
>>
>> You might even be able to take a two level approach to compacting the
>> LevelDb database (or something like it). In a minor compaction you
>> compact all of the files except the huge base file, leaving you with 2
>> files. A huge base file that contains the first tree the user checked
>> out, and a second smaller file containing any differences they have
>> since the initial checkout (this may just be updated stat data for a
>> handful of files that differed across two branches as they switched
>> back and forth). During a git gc or git repack, add a new stage to
>> collapse the base file and everything else into a single new base file
>> as a major compaction.
>>
>> [2] http://code.google.com/p/leveldb/
>
> I don't know leveldb, but like to have a look.
> Just realize this solution is kinda popular. HDFS also uses the
> similar image file with edit file format for its file block index.

Another implementation in this general class is TinyCDB[1].
It is <1600 lines of plain C. Too few to be complete?
It is a derivative of DJB's CDB[2].

[1] http://www.corpit.ru/mjt/tinycdb.html
[2] http://cr.yp.to/cdb.html
--
David Barr
