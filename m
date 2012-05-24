From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Collocate strings to simplify translation
Date: Thu, 24 May 2012 11:55:31 +0200
Message-ID: <4FBE0593.7070205@lyx.org>
References: <1337845288-7656-1-git-send-email-vfr@lyx.org> <4FBDF21F.1010807@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu May 24 11:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXUlg-0002Jh-L7
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 11:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab2EXJzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 05:55:36 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40335 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab2EXJzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 05:55:35 -0400
Received: by bkcji2 with SMTP id ji2so6762485bkc.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 02:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=ZkloOm25TPEUnp3KB5k2A84rx0Row4HH7iAf+PFcPQE=;
        b=a8e6uGRhahP4lfvLnhED+rqPxyViop3DEDIe9pwwm1llJa8pIsNZj2OfuU1wXNTM2a
         GCrNJ4J9hGO5S6vp7g4TvchvAqhYpqLMdnGVz8FLQBNQ1IJzwo5ZXWFGWxCLoxPhJ+qC
         JxQ3aGnH8XU0U0buTQtJy8g2E+gL7HjTAz/CUS5VAqv/3BMql0G955lm1XpNDOMLX5cR
         sM+QKCS6ntDIfaVV9GBzPOcz1GIEDw6dWCT6VUjgIxjqHufEwW5/+sJoCcdGPss2DoxB
         VWMYeIrVvbIhmuS6NpYHaZLIW2m+VOReEWmtuHHICcySiROAx0FCb4ejFzePGkDn6Xyo
         gpAg==
Received: by 10.204.151.81 with SMTP id b17mr13192933bkw.52.1337853333855;
        Thu, 24 May 2012 02:55:33 -0700 (PDT)
Received: from [145.94.170.237] (wlan-145-94-170-237.wlan.tudelft.nl. [145.94.170.237])
        by mx.google.com with ESMTPS id fw10sm1837841bkc.11.2012.05.24.02.55.32
        (version=SSLv3 cipher=OTHER);
        Thu, 24 May 2012 02:55:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FBDF21F.1010807@in.waw.pl>
X-Gm-Message-State: ALoCoQnbPY2HnZuL8rqU5ZQW40OeVKiEdO6vVIz2ecIwwtnvilzg8aqwZ9QyHEEQ/HhQ9iIXwVEi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198364>

Op 24-5-2012 10:32, Zbigniew J=C4=99drzejewski-Szmek schreef:
> On 05/24/2012 09:41 AM, Vincent van Ravesteijn wrote:
>> The translation of 'Untracked' and 'Ignored' might depend on the fol=
lowing
>> word. To help the translator, this patch collocates the term 'files'=
=2E
>>
>> Signed-off-by: Vincent van Ravesteijn<vfr@lyx.org>
>> ---
>>   wt-status.c |    6 +++---
>>   1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/wt-status.c b/wt-status.c
>> index dd6d8c4..9b65a8c 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -185,7 +185,7 @@ static void wt_status_print_other_header(struct =
wt_status *s,
>>   					 const char *how)
>>   {
>>   	const char *c =3D color(WT_STATUS_HEADER, s);
>> -	status_printf_ln(s, c, _("%s files:"), what);
>> +	status_printf_ln(s, c, _("%s:"), what);
> How can "%s:" be translated? _() should be removed here.

Some languages might use a character different from ':'. For example,=20
Chinese uses a full-width character ':' (unicode 0xFF1A) instead of a=20
half-width character. Maybe this is taken care of by the system/shell o=
r=20
whatever, maybe not. Other examples are languages that read from right=20
to left. I guess it should then be translated by ":%s".

This will probably be a matter of convention.

Vincent
