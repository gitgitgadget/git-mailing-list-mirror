From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/25] worktree lock, move, remove and unlock
Date: Thu, 14 Apr 2016 18:21:57 -0700
Message-ID: <CAPc5daWHxyb5viwabR1-Tmx+7FNH4yxQJL7Oqd1FU9XXs4bNog@mail.gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
 <xmqqfuuoi35o.fsf@gitster.mtv.corp.google.com> <CACsJy8DK863+rgseeYrQJ1db+xSeFfm8WsNvGBmJwD_pr1yMJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 03:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqsSl-0005Xz-0r
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 03:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbcDOBWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 21:22:18 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36672 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcDOBWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 21:22:17 -0400
Received: by mail-yw0-f194.google.com with SMTP id i125so13139576ywe.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 18:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lc4uYzLJyzMcUBjSyHl33PqaQpWoRoQGfLS4xY93kGQ=;
        b=CJjQya6JmPS4Op+Fha0Jkfa+sQ3EiuS3cYrF9k7HMcTcjjQB+85bytdJ2rEtiSW9Nx
         TcOkpMCWy72/eciYxjuIFiEtEU3DHjSK5+skz+6GDqX7fmDTHukWVfPpAZiii1IuTQvH
         +BtScVzrpdjyRf5WmDJvLEJBCyMQVshzjH5Yfr5qNcPOcYkXKY2b2SP7Ayf5bj4WgIfq
         lwCv9GuTKwLozYOZaPsYrNab1UXmJ2MjQbeYfA94xdve8ZiqExt5aov55NecSUW34pmZ
         /Y5SiftWY1rENRpEQfGXokTtA9dTJIHWyn7k81N5EhnfbnvnIcz0lXDtrO5YoVggtCU0
         hyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lc4uYzLJyzMcUBjSyHl33PqaQpWoRoQGfLS4xY93kGQ=;
        b=lCzdkABaVuzOlqzxrjrZS1vjRib8pO+CO8YyN0VM8ExRk1zTio6mpgmH8dV0Kd1+Im
         q+p5BMF/WBu5DYuoZX2+GhMHQghrcWPvUOzEuUECg1HXlctGF7hHmt4vyqAs8eJ8okne
         hFd7WOmby0/k2azsefzdhMEi46hzmAtLZROyzfWT9SxrDYGWscARNvQ0fDWOCiTJVoU9
         YGYgiv2/3J5r07K102IGJjNqVwadTAK+4/3eAQGvLCXXOi2VpbxE4xgGzfgCuX+rtj/h
         Yvzse9oXIcWKB7qqPg8KYVA/Fdh9CnXL3Ozq1QnM8P29QCxGK1yPN8FBisMVTVzVc/ko
         szUQ==
X-Gm-Message-State: AOPr4FX4ED/xQzzzdqi7PT8ymwBlAFCgWTqhU1kulG03CWgHn4VNa5sfL4hPEfcV+KxD9XeUn0RttJcQu3MFhw==
X-Received: by 10.37.118.6 with SMTP id r6mr6882276ybc.80.1460683336862; Thu,
 14 Apr 2016 18:22:16 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Thu, 14 Apr 2016 18:21:57 -0700 (PDT)
In-Reply-To: <CACsJy8DK863+rgseeYrQJ1db+xSeFfm8WsNvGBmJwD_pr1yMJQ@mail.gmail.com>
X-Google-Sender-Auth: N_Ittarwf4bz7CCvjo2IsgcPCyk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291587>

On Thu, Apr 14, 2016 at 5:40 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Apr 14, 2016 at 11:08 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> This is basically a resend from last time, which happened during rc
>>> time.
>>
>> It would have made them a much more pleasant read if you re-read
>> them during that time and added the missing "why" to many of the
>> commit log message.
>
> Hmm... I thought I didn't receive any comments last time.

I think you've been here long enough to know that absense of comments
does not mean anything more than that: lack of interest at that moment =
in time.

>> This looks parallel to die_errno(); isn't error_errno() a better nam=
e?
>
> To me, no. Duplicating the "err" looks weird. error_no() does not loo=
k
> good either. Though there's a couple of warning(..., strerror()),
> which could become warning_errno(). Then maybe error_errno() makes
> more sense because all three follow the same naming convention.

So in the end error_errno() would be a better name to you after all ;-)
I agree the stuttering sound coming from repeating error twice feels
somewhat odd, but warning_errno() would be so natural and obvious
future direction, so...

>>>   [03/25] copy.c: import copy_file() from busybox
>>>   [04/25] copy.c: delete unused code in copy_file()
>>>   [05/25] copy.c: convert bb_(p)error_msg to (sys_)error
>>>   [06/25] copy.c: style fix
>>>   [07/25] copy.c: convert copy_file() to copy_dir_recursively()
>>
>> Somewhere among these, there needs to be a single overview of why we
>> want "cp" implementation of busybox, e.g. what part of "cp" we want?
>> the whole thing?  or "because this is to be used from this and that
>> codepaths to make copy of these things, we only need these parts and
>> can remove other features like this and that?"
>
> We need directory move functionality.

Yeah, I know all that but you do not want to explain that to me only wh=
en
I asked in a mailing list response. You want to get into the habit of h=
aving
that in the log message to help reviewers, not just me, before they ask=
 such
a question.

>> But such judgement is better done when we know what are the final
>> elements that are to be listed, i.e. closer to where new things are
>> introduced.  This is especially true, as the log messages of patches
>> leading to 21 are all sketchy and do not give the readers a good
>> birds-view picture.
>
> Well. I think all the commands are there now at the end of this
> series. So we have add, list, prune, move, remove, lock and unlock. I
> guess we can group list/add/move/remove together and the rest as
> support commands. I might add "git worktree migrate" for converting
> between worktree v0 and v1. But it's not clear yet.

Just so that there is no confusion, I am not opposed to reordering.
I was just saying that the decision on what the right ordering is can
be easier to make when the readers more or less know what the final
set of things in the set are, and because that becomes only clear when
they start reading 21, and because the log messages of patches
leading to 21 do not show the direction clearly enough, it is hard to
make that judgment at this point so early in the series.
