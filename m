From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH 1/2] remote: Remove -v/--verbose option from git remote
 show synopsis
Date: Fri, 9 Jan 2015 02:32:35 +0600
Message-ID: <CANCZXo5KT9OZHtJm3HUUncRgaBdY35nsvfGz8z-6WdMQ0ALQyw@mail.gmail.com>
References: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
	<54AED7C3.8010604@web.de>
	<xmqqoaq9do7i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Jl2-0002md-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbbAHUcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2015 15:32:36 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51844 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbAHUcg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2015 15:32:36 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so9992164obb.12
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wzAFHQhNUxg0oOiGkhRpiVh0UVQb6ButwJmVIw+3QAs=;
        b=0yjz2gId8N80V9arFBY1eL4qzhUuxzlx1micPinBqLqbTV5RFnAIGxIg+mB0OobsHv
         /CcKW9u/NPjUEnfhHOqz+BlobCyToUitH7hteiGuYdrr7KnCF4sBYnGUaVzRKY0cFdMZ
         gUy+uOWKcTwOaDbWH1GdqEmqEbym0VUixUJ5i/TEWbV/ri1opchGEHHpFwp/n5OCyCDC
         zWT7oa5+jQBmJfCAlBmy6Gpl8YgMOsXWzSGiTsyrqyZF9sfIN025ulVSr1Ir/cGcJta9
         9XkfzlUh1vdBm5KEQLKXSvJtoX1XOEKwgs5AoizSTlxgRnO3ipZXCEW9lbn4e1cefL8R
         vlzA==
X-Received: by 10.202.220.85 with SMTP id t82mr6485149oig.43.1420749155684;
 Thu, 08 Jan 2015 12:32:35 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 8 Jan 2015 12:32:35 -0800 (PST)
In-Reply-To: <xmqqoaq9do7i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262223>

What if move -v/--verbose after commands? Like:

git remote show [-v | --verbose] [-n] <name>

and etc...?

2015-01-09 2:14 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 08.01.2015 um 18:57 schrieb Alexander Kuleshov:
>>> git remote show doesn't use -v/--verbose option
>>
>> Hmm, but it does?
>>
>>       $ git version
>>       git version 2.2.1
>>       $ git remote show
>>       origin
>>       $ git remote -v show
>>       origin  git://git.kernel.org/pub/scm/git/git.git (fetch)
>>       origin  git://git.kernel.org/pub/scm/git/git.git (push)
>>
>> Perhaps you meant the following variant?  The changed line documents
>> the one above, though (-v before show).
>>
>>       $ git remote show -v
>>       error: unknown switch `v'
>>       usage: git remote show [<options>] <name>
>>
>>           -n                    do not query remotes
>
> Ahh, I misread the patch.  Thanks.
>
>>> diff --git a/builtin/remote.c b/builtin/remote.c
>>> index 46ecfd9..978c645 100644
>>> --- a/builtin/remote.c
>>> +++ b/builtin/remote.c
>>> @@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] =
=3D {
>>>      N_("git remote rename <old> <new>"),
>>>      N_("git remote remove <name>"),
>>>      N_("git remote set-head <name> (-a | --auto | -d | --delete |<=
branch>)"),
>>> -    N_("git remote [-v | --verbose] show [-n] <name>"),
>>> +    N_("git remote show [-n] <name>"),
>>>      N_("git remote prune [-n | --dry-run] <name>"),
>>>      N_("git remote [-v | --verbose] update [-p | --prune] [(<group=
> | <remote>)...]"),
>>>      N_("git remote set-branches [--add] <name> <branch>..."),
>>>
>
> I however have a bit larger question.  Does it make sense to have
> [-v/--verbose] in front of some but not all of the subcommands?
>
> For example, the above snippet gives me an impression that
>
>     $ git remote -v prune -n origin
>
> should not work, but that does not seem to be the case.



--=20
_________________________
0xAX
