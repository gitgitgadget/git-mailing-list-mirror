From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Wed, 8 Dec 2010 01:27:56 +0100
Message-ID: <AANLkTi=y8NnCqzB28iHxWqUU0byVu7QUiApM0FYswOLj@mail.gmail.com>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
	<AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
	<AANLkTinuD2ze_mn5QMLqFaoftwZvTsz-DKv1ojAizg7P@mail.gmail.com>
	<4F33DA75-D095-415D-99F8-5236D6F93EE1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Kyle <scott@appden.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Dec 08 01:35:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ80W-0001BH-UB
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab0LHAfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 19:35:23 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:39951 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab0LHAfV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 19:35:21 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 19:35:21 EST
Received: by fxm18 with SMTP id 18so492515fxm.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 16:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PJxT59cb8EwRhY73C3L8wB447cYwhzVYqwkkOgyEhzI=;
        b=ZWwGcMgGVDqvy+0G2Fp0oS3SlM9QblzSW88VzxFx53h7pe+NDioqVnXsuZNuURyTV3
         yO+3hg9t9RxHZlE/SWIdQRCTHwYAJkcd6UFK19zPEBz2TgHY9geUMxD2UZim2kQTldf6
         NUvwwRWMAoAPYEP8Y6+zInFk86xTglRClzyyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wNg7Z/f1vJbebFWOFSM82mzozNiZX8KjtMpGeol4z1UdWOT9z+pp0PhkxddVv6S97q
         AmzWO7IozY6KPmsDcYvjB7EeuJb+cxBxZo8bJ3l5AWmvo9ahuhXJ+0rXjHpAgoN4+0V1
         yIcJRKuwhp2wHvMtBhnokou4zuW15KlAhT70o=
Received: by 10.223.86.130 with SMTP id s2mr7787619fal.66.1291768076946; Tue,
 07 Dec 2010 16:27:56 -0800 (PST)
Received: by 10.223.74.207 with HTTP; Tue, 7 Dec 2010 16:27:56 -0800 (PST)
In-Reply-To: <4F33DA75-D095-415D-99F8-5236D6F93EE1@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163156>

On Tue, Dec 7, 2010 at 21:41, Kevin Ballard <kevin@sb.org> wrote:
> On Dec 7, 2010, at 12:37 PM, Scott Kyle wrote:
>
>> On Tue, Dec 7, 2010 at 4:15 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
>> <avarab@gmail.com> wrote:
>>>
>>> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
>>>> For those who often work on repositories with submodules, the dirt=
y
>>>> indicator for unstaged changes will almost always show because dev=
elopment
>>>> is simultaneously happening on those submodules. The config option
>>>> diff.ignoreSubmodules is not appropriate for this use because it h=
as larger
>>>> implications.
>>>
>>> Wouldn't it be a lot better to instead add support for showing
>>> submodule dirtyness as distinct from the main tree's dirtyness? The=
n
>>> you could easily spot if you had either your tree / submodule tree
>>> changes, without just ignoring them.
>>
>> I considered that, but thought it to be a rather disruptive change,
>> and one that conceptually didn't work. =C2=A0The way I see it, eithe=
r
>> somebody thinks of their repo as dirty when the submodules are dirty=
,
>> or not. And I think since this behavior has perpetuated for so long,
>> most users are content with how it currently works. =C2=A0I, however=
, was
>> not, and so that is why I added an option for people like me.
>
> The big win for such a change, from my perspective, is it tells me if=
 I need
> to do a `git submodule update --recursive`, or if I actually have dir=
ty changes.
> Because of that, if nobody else picks this up, I'll probably write a =
patch
> to introduce such a config at some point in the future. But as I said=
 before,
> that's something that can be done later and doesn't need to affect th=
is patch.

Yeah. I didn't mean to imply that the current patch wasn't useful. It
also is for people like Scott that just want to ignore submodules, but
most of us care about them being dirty.

So having support for both (ignoring and tracking) in __git_ps1 would
be great. It would be very useful if you or someone else could pick
this up.
