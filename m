From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Tue, 4 Jun 2013 08:31:29 +0200
Message-ID: <CALWbr2w+Rvf07MGhj7YaYea7fwjE-ikgf+2OrNvmZKcGsu1uJA@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 08:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjkmO-0000xQ-1N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 08:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295Ab3FDGbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 02:31:32 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:54272 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab3FDGbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 02:31:31 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so4316154lab.9
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xAF2282h4zgF34yzz3nv2xbbbzFvQ7kdKCir7jT7kLk=;
        b=zuT54DUS4yrludAi6tvQ2nCZJNACX1ZyvSyXdlT4aDcd06amCKQZXT4R02NZrMzar9
         /izJVF4QobU8IUtHxjsJz4GkrAsjnSTrvq03cAm5HBu1eDJPOvIb+9ls4F/PjaCdDBru
         qLvMGaA8C7D892EeFlJ3pmnMOYXeoaOAwCD5otp+3b4e4/KNk9CKcvSXYITOHkh/LLmU
         kfN27sDVsJ3dc/eIGFMkrMY99nrFeT53YZYEXQI0krowcRcyJC0F5ZTxC3msugZ3nl0n
         MVHzD1aoLccTCSHoUQHod2kVPctxoPkBT8eJHab/+qFrBwZ1IlNlF8sqyZJI9PxjFfFP
         HoeQ==
X-Received: by 10.112.169.37 with SMTP id ab5mr12238519lbc.25.1370327489725;
 Mon, 03 Jun 2013 23:31:29 -0700 (PDT)
Received: by 10.112.61.8 with HTTP; Mon, 3 Jun 2013 23:31:29 -0700 (PDT)
In-Reply-To: <CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226320>

On Mon, Jun 3, 2013 at 11:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jun 3, 2013 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Pretty much what it says on the tin.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  Documentation/git-cherry-pick.txt   |  3 +++
>>>  builtin/revert.c                    |  2 ++
>>>  sequencer.c                         |  6 ++++++
>>>  sequencer.h                         |  1 +
>>>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>>>  5 files changed, 25 insertions(+)
>>>
>>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
>>> index c205d23..fccd936 100644
>>> --- a/Documentation/git-cherry-pick.txt
>>> +++ b/Documentation/git-cherry-pick.txt
>>> @@ -129,6 +129,9 @@ effect to your index in a row.
>>>       redundant commits are ignored.  This option overrides that behavior and
>>>       creates an empty commit object.  Implies `--allow-empty`.
>>>
>>> +--skip-empty::
>>> +     Instead of failing, skip commits that are or become empty.
>>
>> Not quite sure.  Is this "instead of recording an empty commit,"
>> (which may or may not fail depending on the allow-empty settings)?
>
> We are explaining --skip-empty, not --allow-empty.

By the way, I guess both options are incompatible ? I think it would
be nice to fail if both are specified.

Antoine,
