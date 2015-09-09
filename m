From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Wed, 9 Sep 2015 23:07:03 +0530
Message-ID: <CAOLa=ZS5bM_h7CLJD+Nj1h1qi3FCfjVYX0ZBGCX6PDXt+9XQyw@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
 <xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
 <vpqfv2qqq7y.fsf@scolette.imag.fr> <xmqqd1xs93iu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 19:37:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZjJT-00025v-4a
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 19:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbIIRhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 13:37:34 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35860 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbIIRhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 13:37:33 -0400
Received: by obqa2 with SMTP id a2so14007119obq.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rMmDDlcpV6ACysdbKLxqoQl46V7aZu4TKwCnlpHwDUg=;
        b=ETnEbpOBKK3zP+3J0Nw6v6C/Ir1+6skXLL3phOkod8WhXqNXGBB+06a3tdkm9WkRQX
         tl5XmW+326sRwr66fv7XjCr2CMypx6pC3bHCUzvd7VW2u8ORjMO5fxtnZTKAJyXRltaE
         xblmdkUTWLTzWUCmBfw1n78LDRmm1yripewFVSFPFdO4wBP2izhwoMaru6groxeJeFo2
         wAEkpZsP+9ld2vxoNvbjq9FYSoLc+7NbpQ7F3iSKozAdA8S6Dn8Zc0odGggxfvSMljpL
         9CrVam7nXzdj2TF2GzzzyMy/iF2r1nB9TwZyV3xMGTLyO/ymSkZxMsITs18t2/kMcyxv
         k+cQ==
X-Received: by 10.60.65.68 with SMTP id v4mr27233251oes.84.1441820253047; Wed,
 09 Sep 2015 10:37:33 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 9 Sep 2015 10:37:03 -0700 (PDT)
In-Reply-To: <xmqqd1xs93iu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277560>

On Tue, Sep 8, 2015 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>>> This line still looks overlong.  Would it help to stop spelling this
>>>> as a double "a = b = overlong expression" assignment?
>>>>
>>>
>>> I'm not sure, I get what you mean.
>>
>> I guess
>>
>> format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>>                  filter->lines);
>> to_free = format;
>>
>> (still 83 columns + indentation, but that's a bit shorter than your
>> version).
>
> Sure.  This may also be possible
>
>         xstrfmt("%s %%(contents:lines=%d)",
>                 "%(align:15,left)%(refname:short)%(end)", filter->lines);
>
> and highlights that the only thing that is variable is the number
> of lines, which might be better.

Yeah looks better, thanks.

-- 
Regards,
Karthik Nayak
