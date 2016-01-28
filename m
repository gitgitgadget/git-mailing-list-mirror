From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH 2/2] stash: use "stash--helper"
Date: Thu, 28 Jan 2016 23:28:42 +0000
Message-ID: <CAFY1edZGvdmESLdax1ErTdgyj+A7B+K9zKHsmF0Qb6d_XEk_mA@mail.gmail.com>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	<0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
	<CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
	<BLU436-SMTP572EDBE67B8D37ECADD616A5DA0@phx.gbl>
	<CAGZ79kYVRY+6zFnHe8LPp2E_W_gAs--Vog-HoqXW-Do_WgHGXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:28:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOvzd-0003UD-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbcA1X2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 18:28:46 -0500
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36588 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcA1X2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 18:28:43 -0500
Received: by mail-ig0-f195.google.com with SMTP id o2so2861526iga.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CWvSRriJnRT/WNXgyHfvYPCXcL9RsZn58qaUTkngoE0=;
        b=US6M1KRHTUZDwYZ4e6toIvM7uAFqmkAHF/lbZ2Aj0Q9ZtPRIWu0TcNdGYPTyK50rpz
         CgWp2k7nNrO2xu1+hayiw1xh3neYgBxEISCJ8VMl1U174IKlbqIFXRY6fJH4yx6igzXS
         LO5K0aqZLfDieJRuquNUNNfFChXei0Z4ZZdeg3kvILLgn9ufbY9ZM0FLC/fsLxLGANRn
         xpWdEVsXHGxKPfc+nhVAWpZc8/KXmsI9r1nsvf3w8g8NiRJjrM3Xka5stBitZD8vs1bg
         aYyVlhtGCQuhsWsQTBjv/q2gUbrPHVHLanswrDd3migwjlF88dYPLLSJDpPjDZjNHFq2
         ShDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CWvSRriJnRT/WNXgyHfvYPCXcL9RsZn58qaUTkngoE0=;
        b=KF6q0uhiykJrLN71G0zLZ3wRwAhBCVtZo32+Sbjh69ZuEHWVpCthIDYBcm19D9fSOk
         pUgwWaqoePUBzdqL01DbVfsxZ9nawFczeUzRv0KrRfsT0B2HoJh1XchM96wchj9PhKtr
         8/lp+lwngXA9qjHvrlqucbx5mSBSyuJ/ScNgE9WyVNs3T2WDkWo3oVRv+7tJtU00mYOo
         8FXad5lMjT6C+Q1np5hntUzqv08i2aNez2MaIyha187BAyaXhLoTY7D2EVu/u4n+njjn
         uPElH8qSdmc0rBj0uF1CdgWxLm/DrwrGu2mioa7UKurEGoH6eA/bG7Zv37mVcYwmPv8D
         ORxg==
X-Gm-Message-State: AG10YORvmSJR+/Rmb5z5O9uK95gJy9xOkKNHLE1hSEXxBlKf0YlGkeUc0P6ovvGuipWR55lW2zye2wdn3tsPnA==
X-Received: by 10.50.138.5 with SMTP id qm5mr6758487igb.53.1454023722779; Thu,
 28 Jan 2016 15:28:42 -0800 (PST)
Received: by 10.79.90.198 with HTTP; Thu, 28 Jan 2016 15:28:42 -0800 (PST)
In-Reply-To: <CAGZ79kYVRY+6zFnHe8LPp2E_W_gAs--Vog-HoqXW-Do_WgHGXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285044>

On 28 January 2016 at 21:41, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jan 28, 2016 at 1:25 PM, Matthias A=C3=9Fhauer <mha1993@live.=
de> wrote:
>>>> https://github.com/git/git/pull/191
>>>
>>> Oh I see you're using the pull-request to email translator, cool!

Yay!

>> Yes, I did. It definitly makes things easier if you are not used to =
mailing lists, but it was also a bit of a kerfuffle. I tried to start w=
orking on coverletter support, but I couldn't get it to accept the amaz=
on SES credentials I provided. I ended up manually submiting the coverl=
etter. It also didn't like my name.

Apologies for that - https://github.com/rtyley/submitgit/pull/26 has
just been deployed, which should resolve the encoding for non-US ASCII
characters - if you feel like submitting another patch, and want to
put the eszett back into your GitHub account display name, I'd be
interested to know how that goes.

> Not sure if Roberto, the creator of that tool, follows the mailing
> list.  I cc'd him.

I don't closely follow the mailing list, so thanks for the cc!

Roberto
