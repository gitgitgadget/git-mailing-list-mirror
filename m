From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] wildmatch: correct isprint and isspace
Date: Fri, 16 Nov 2012 11:19:32 +0700
Message-ID: <CACsJy8AnghB1F8pwHbZpZJKoCZqbQ-TWpV9x_+49ZEJdE0bW2g@mail.gmail.com>
References: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
 <1352981983-22005-1-git-send-email-pclouds@gmail.com> <50A522B5.7080206@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	rene.scharfe@lsrfire.ath.cx, Johannes Sixt <j6t@kdbg.org>,
	torvalds@linux-foundation.org
To: =?UTF-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 05:20:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZDPi-0002na-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 05:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab2KPEUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 23:20:05 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59911 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab2KPEUD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2012 23:20:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2437009obb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 20:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AxzAJphSguxcDXOw/VeNDxr/zgTJ7mFHTJ6yrzfPyoU=;
        b=HuoKan1EawfJQBLC10kCY+rFqoP4+qkFQMnQjtFblj6eIN9rOsb0xMWEigG80PpVja
         cWAMUdcYd45pz6rab7QO5FduSKSekXshpOZs6Zn88s0J+8dtlVOnF78WmNDn2V4U0J1c
         B6uH0Itz8YPpvWNpYrWGPVbId3KL9A3IqC/PFmgnMqbxzCgSk2w5oAWvkU9zmzWQO2fH
         1yEIOf6wV6SRqk+vFPY0jCxuHb6yPp/9mLcTCwu32PM5erQ0NwFDcYrdx5aABx7anl6M
         QS2Y0EDh28lxXn2ZyDhHXTytXohN+x/IVWUhSCQgqeBKl0Snr+T7PU6gmpo7keEbtZXW
         LiuA==
Received: by 10.182.38.101 with SMTP id f5mr2871247obk.80.1353039602663; Thu,
 15 Nov 2012 20:20:02 -0800 (PST)
Received: by 10.182.40.163 with HTTP; Thu, 15 Nov 2012 20:19:32 -0800 (PST)
In-Reply-To: <50A522B5.7080206@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209861>

On Fri, Nov 16, 2012 at 12:13 AM, "Jan H. Sch=C3=B6nherr"
<schnhrr@cs.tu-berlin.de> wrote:
>>  #define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPAC=
E | \
>>               GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
>> -             GIT_PATHSPEC_MAGIC))
>> +             GIT_PATHSPEC_MAGIC) && \
>> +             (x) >=3D 32)
>
> May I suggest the current is_print() implementation in master:
>
> #define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)
>
>
> To summarize my opinion:
>
> I no longer see a reason to correct isspace() (unless somebody with a=
n actual
> use case complains), and a more POSIXly isprint() is already in maste=
r.
>
> =3D> Nothing to do. :)


Yeah. I remember to remind myself to check "the implementation in
master" you mentioned but I probably failed at that. Just checked that
isprint() is already in master, and your comment about isspace() use
in wildmatch.c makes sense too. So I'm all for doing nothing.
--=20
Duy
