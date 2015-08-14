From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 16:55:03 -0400
Message-ID: <CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <xmqqbne9ivry.fsf@gitster.dls.corp.google.com> <CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
 <xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:55:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQM0g-0004HM-7R
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbbHNUzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:55:25 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34141 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbHNUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:55:24 -0400
Received: by iodb91 with SMTP id b91so96905655iod.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lu6S1J+0qGOJwh0dF4yDQ6g7KpSHPLEOTy+HE42dsiU=;
        b=iX4Ag5kPjMGW4JfdUNFzgOCon+0FgEi74Z0xoj5wNdGvEykpfDapf4r2tgHaZ3Zb4r
         ePNx/pLhp6oqrgbK1N2hEdZkuqxqOdcsLd5tj777alBp9qfer6wdFAzxphfDkHpabi8j
         nv4DWas++y+xeveKPjFO5cEME4AXQXLh7ONHBnhPcy4aJVcKkuoBwM1J83KwgoZuFLH2
         RgmFR8HuiBoKlMVv80tZZrXTNnt4j5cYXZbZrrtOm4+A3FRhV7L+bySfBgEwVumvFKqB
         ASKxdDKuzThvlBnwC5GDHqB7a91mgp2hvqyb7Qy8MkeVSUDc5Orx7ZFFca9mGPDNF3Dr
         Ag3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Lu6S1J+0qGOJwh0dF4yDQ6g7KpSHPLEOTy+HE42dsiU=;
        b=Gr2AcdGOJaF3oTtdhZSm9reabONMA4MIq8BGaqtvKBbD/r8/kj5IWAnGKpI/y1I5Qy
         b4m2iy6lQKWu8fWbKrO6hUmQIkL15WJtaLZ1oqMnZea+bm0LFCpWAKOXJzkq0LXBELOy
         nC0sMFcfIggXHo9bDJZYluqWYuPUB8jEZiHmFL3Lgjku/ZRQi7ckDpGmwyO3HhP55NRS
         YIzakRpRv0pK4dZH3u6yfPcUJpsh9SQLVteAmhOUpqV2tppDbqiWT/Isg+d1Maf6H2zv
         yslRb66FDbuhIvjTZpnjEeLB6mJEXhxKEZYGahgL2seSkKyti0aikCoW71noDwTMYa3q
         e0FA==
X-Gm-Message-State: ALoCoQnz4d75v6bjzxTq8d6v+3Y2Wj4g5ONpEzVkOFyDhCOnlHbNQOnhBlDvQAntYUuBKseyjirL
X-Received: by 10.107.160.197 with SMTP id j188mr51149955ioe.194.1439585723272;
 Fri, 14 Aug 2015 13:55:23 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Fri, 14 Aug 2015 13:55:03 -0700 (PDT)
In-Reply-To: <xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275950>

On Fri, Aug 14, 2015 at 4:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> On Fri, Aug 14, 2015 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Yes, it looks somewhat strange.
>> ... The straw-man
>> strangeness is that two of them are the traditional boolean values
>> "true/false" and the third is "file not found^W^W^Wif-possible" :)
>
> It actually is not uncommon for a Git configuration variable to
> start its life as a boolean and then later become tristate (or more)
> as we gain experience with the system, so don't worry about it being
> "strange".  A tristate, among whose choices two of them are true and
> false, is not "strange" around here.

Ok, so let us bikeshed a bit further.

Bikeshed 1.
Option A: --signed/--no-signed--signed-if-possible
Option B: --signed=true|false|if-possible, "--signed" alone implies "=true".

Bikeshed 2.

Option A: if-possible

The possibly confusing thing is one might interpret missing "gpg" to
mean "impossible", i.e. "if gpg is not installed don't attempt to
sign", which is not the behavior we want.

I don't have another succinct way of saying this.
"if-server-supported" is a mouthful. I think Jonathan mentioned
"opportunistic", which is fairly opaque.


> By "strange", I was referring to the possible perception issue on
> having a choice other than yes/no for a configuration that allows
> you to express your security preference.
>
> Thanks.
