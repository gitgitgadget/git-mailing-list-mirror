From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH v3 1/2] merge-recursive: option to disable renames
Date: Wed, 17 Feb 2016 01:16:12 -0200
Message-ID: <CALMa68peGr3TsS8bTpsG3Xt5U5VtbLhKryhOSLEYaNZyjRuSgQ@mail.gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
	<1455671495-10908-2-git-send-email-felipegassis@gmail.com>
	<CAPig+cRCKQ8Vpr11XB-MSNsjDXjMHstaEAz333nMZxuKC8xmEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 04:16:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVsbi-0002rT-N1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 04:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbcBQDQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 22:16:14 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33816 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbcBQDQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 22:16:13 -0500
Received: by mail-ig0-f181.google.com with SMTP id g6so48504218igt.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 19:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nn1nKYLx6xlZZAzTjxnOEwUGd1qOpLtpDdGcKBORxac=;
        b=yRTY7XgRUMhoyjfih7zticZhHTpSaxNdkkrK/LjN5yaZZc1QmP/QTTF9qvDc6OVubJ
         wnBJbZ2CsRrFLG2qQWRUlLUQr+2zU4+a7MKe/U9QbPl8llQy2FqQf35NbigvjLcFEkvy
         mhKY/UzG2qjmIfX35WXQCf2KXj/2z/HCrfh8Gx8HvrWCgvEWbZCshvL2exWAetnTazP/
         Eo/GiPGuuVRy+NqNGVSIlHmHW/PUC6h2klQJfw/oive8XMC3qkNTx4uG96bIxIHpTdH+
         5UhD8C4Q72wIrWydfLjPYNChwOlkiNzuJXk+HcbrhiFJDjkqIuAAp7tu6UCTAuM2UPwS
         vdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nn1nKYLx6xlZZAzTjxnOEwUGd1qOpLtpDdGcKBORxac=;
        b=AGIfE2MbB0MmJksPN+JtreqCxhxtIrJyYh8z6lIyFC7ziX9Wqq5VPtaTbUxasTsQId
         yadFUNIH17x/YWAR5O63PM3SwQU8Za48NCfA0xG+NqCWl1ECx5NvJuxwo8p3Y1U13+2W
         U+9o5jVq/WzEaYfZ3GbZWBbMt2PRw6cZZgVESgazaz+T+3eNE2IFRDJqD7Llrjf4WBeZ
         37PJ1YRpbNVfnV27bhYj5yprJ91i0W0mLulzzXo6Lk3UbyMhLoJJlA8M4DegoabI4u1p
         KzCKE7aejm/eK7bmkoiIQYfr4JHI7CEUMSaU+1CfVtEnW2nLe2nnlFM5Q9wnIqDl/WKA
         p6HQ==
X-Gm-Message-State: AG10YORxYjxLjpPEwLpy/teyjmDwxwOwvpDqzavTdD8YJFEGShkOzoB6NbX2rMABlUI6OUoPfB8DEbJrlvcKxA==
X-Received: by 10.50.33.20 with SMTP id n20mr21786047igi.17.1455678972797;
 Tue, 16 Feb 2016 19:16:12 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Tue, 16 Feb 2016 19:16:12 -0800 (PST)
In-Reply-To: <CAPig+cRCKQ8Vpr11XB-MSNsjDXjMHstaEAz333nMZxuKC8xmEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286476>

On 16 February 2016 at 23:41, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> On Tue, Feb 16, 2016 at 8:11 PM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> The recursive strategy turns on rename detection by default. Add a
>> strategy option to disable rename detection even for exact renames.
>>
>> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
>> ---
>> diff --git a/Documentation/merge-strategies.txt b/Documentation/merg=
e-strategies.txt
>> @@ -81,8 +81,14 @@ no-renormalize;;
>> +no-renames;;
>> +       Turn off rename detection.
>> +       See also linkgit:git-diff[1] `--no-renames`.
>> +
>>  rename-threshold=3D<n>;;
>>         Controls the similarity threshold used for rename detection.
>> +       Re-enables rename detection if disabled by a preceding
>> +       `no-renames`.
>
> I'm not sure that it is necessary to mention the "last one wins" rule
> here, but if you do so, does --no-renames documentation deserve
> similar treatment?
>

It is not so much about the "last one wins" rule, but about the fact
that, given the sub-optimal name, it is not obvious that this option
even enables renaming. The wording is just the best way I found to
explain that without creating additional confusion.

I will apply your suggestion on the second commit. Please see the next
patch proposal and tell what you think.

Thanks,
=46elipe
