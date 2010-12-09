From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 18:53:35 +0700
Message-ID: <AANLkTikc_ROE5uiEOnwOi64zV8w5X17U7vjsGsfuu=gN@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012090144.19858.jnareb@gmail.com> <AANLkTin1SjEzBnLd-HK9fANShLezAKHAOai9MyF-cuoT@mail.gmail.com>
 <201012091243.44824.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 12:54:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQf4f-00064w-DJ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 12:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab0LILyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 06:54:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34826 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab0LILyH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 06:54:07 -0500
Received: by wwa36 with SMTP id 36so2360618wwa.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gCNj/Vm+KU30Ly7Bz2SJcazNaHZqFi40/h1dnTZIvvE=;
        b=M2Bh7/LgAdnhId4X/yfyocIURQodJT4z+jGK2IFY+j4gmz2oU5Yelw0PaD01nxyMSq
         6qHYxGf8GCiWTrW5F0uZ7ms552fPHRsLvksaItiAClZdRfWYWGXlJ4nqITzhYMaBmkkq
         WHNaWa0NPYEOLmEApn2auL/GJA5B/qaTYmgYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k9td/+tQeQjy5kBWe0wiy8NmoWKowH7qrIjEcuAAZ61zXzCxC1GNMEEG/Q1YAyomeT
         QbAztiHfdhlQLu/uhm+MFwsp6vYjqf0Jv/MwlANnVQ/av2AT5K0t31vk2uKoqPmseT+F
         NrNNK7Aj6S62HCVAkhPKWj70q5AJVusV3349U=
Received: by 10.216.162.70 with SMTP id x48mr479492wek.4.1291895645917; Thu,
 09 Dec 2010 03:54:05 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 9 Dec 2010 03:53:35 -0800 (PST)
In-Reply-To: <201012091243.44824.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163277>

On Thu, Dec 9, 2010 at 6:43 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
>> On Thu, Dec 9, 2010 at 7:44 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>> On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
>>>> 2010/12/9 Jakub Narebski <jnareb@gmail.com>:
>>>
>>>>> I wonder if it would be possible to make :/<regex> (which looks a=
 bit
>>>>> like searching the index) to be an alias to --all^{/<regex>}...
>>>>
>>>> It looks a bit strange to my eyes to merge normal option name with
>>>> revision syntax. But I think it's possible. Do we allow branch/tag
>>>> name with leading '-'?
>>>
>>> Well, with below proposal it would simply be
>>>
>>> =C2=A0--all ^{/<regexp>}
>>
>> This hardly works with range and may conflict with "--all" being
>> already used by some commands.
>
> It is '--all' like in "git log --all".
>
> The proposed semantics for ^{/foo} (i.e. not attached to revision)
> would be that it acts on all positive revs on the left of it, replaci=
ng
> them. =C2=A0But that might be not easy to do, and it feels a bit
> overengineered.

Yes, maybe.

>> I think we can move '/' out of {}, the space between '/' and '{' can
>> be used for optional parameters: ^/{foo}.
>
> Do you mean using e.g. ^/:i{foo} for :ignorecase, instead of ^{:i/foo=
}
> or ^{i/foo}?

Yes. I find "^/" easier to read than "^{/". But "^{/" is more
consistent to the rest.
--=20
Duy
