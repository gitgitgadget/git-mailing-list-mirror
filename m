From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Collocate strings to simplify translation
Date: Thu, 24 May 2012 14:34:01 +0200
Message-ID: <4FBE2AB9.6010502@lyx.org>
References: <1337845288-7656-1-git-send-email-vfr@lyx.org> <4FBDF21F.1010807@in.waw.pl> <4FBE0593.7070205@lyx.org> <4FBE2797.80505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 24 14:34:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXXF8-0007V5-Gm
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 14:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab2EXMeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 08:34:06 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48186 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2EXMeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 08:34:04 -0400
Received: by bkcji2 with SMTP id ji2so6894531bkc.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 05:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=rn7J6UR7Kfs0Pb3dCESqTAQY14Zw/ximE1s45fFvrOs=;
        b=bwdj6QlShY8NsQYrzkPDB0A5DjgfEIxTrDdnhl5ONzE287AUc9OE9KC0YKJLAd2hv8
         7klQICS19SlGM6MDtHOInp2qTqdjkmwudLOA692Us6OBOlGlddywjyRo3OmewjyxgYIi
         8vI1adcR29eb7N0ut9/ggPjTlXJb7eR+AbbZQujynRZ4EJaxV8Fm5+iIImnO92V+TOtm
         HTuAxsu9F6a9w3B43WjKMhgQk25dJSBDEtcdgZRaaYNKAU1BQGOLThg1pC/F/H0zk3nj
         BbI0tcJqkGqV4xn72ZQnDoI9D3hcV1+75J0cwMu/YqBr+6bqNx1LBdCYNJCPWcQXM7Ip
         12RQ==
Received: by 10.204.148.72 with SMTP id o8mr12333825bkv.127.1337862843413;
        Thu, 24 May 2012 05:34:03 -0700 (PDT)
Received: from [145.94.170.237] (wlan-145-94-170-237.wlan.tudelft.nl. [145.94.170.237])
        by mx.google.com with ESMTPS id m2sm2638780bkm.2.2012.05.24.05.34.02
        (version=SSLv3 cipher=OTHER);
        Thu, 24 May 2012 05:34:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FBE2797.80505@viscovery.net>
X-Gm-Message-State: ALoCoQkq8cpMpeo13j5FDDUfIjUVQem8w+qd6LkuPzHeI3EalIE2cEKMVWsJ76AmIKXlCdQ6cvrB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198370>

Op 24-5-2012 14:20, Johannes Sixt schreef:
> Am 5/24/2012 11:55, schrieb Vincent van Ravesteijn:
>> Op 24-5-2012 10:32, Zbigniew J=C4=99drzejewski-Szmek schreef:
>>> On 05/24/2012 09:41 AM, Vincent van Ravesteijn wrote:
>>>> -    status_printf_ln(s, c, _("%s files:"), what);
>>>> +    status_printf_ln(s, c, _("%s:"), what);
>>> How can "%s:" be translated? _() should be removed here.
>> Some languages might use a character different from ':'. For example=
,
>> Chinese uses a full-width character ':' (unicode 0xFF1A) instead of =
a
>> half-width character. Maybe this is taken care of by the system/shel=
l or
>> whatever, maybe not. Other examples are languages that read from rig=
ht to
>> left. I guess it should then be translated by ":%s".
>>
>> This will probably be a matter of convention.
> Shouldn't you then move the colon with the "files"? That is, here we =
have:
>
> -	status_printf_ln(s, c, _("%s files:"), what);
> +	status_printf_ln(s, c, "%s", what);
>
> and elsewhere we use _("Untracked files:") and _("Ignored files:").

I would avoid having too many 'decorations' in the strings themselves,=20
because it is annoying to have to translate "Untracked files",=20
"untracked files", "untracked files:", "  (untracked files)" etc.

Besides, the translation of "%s:" can be reused numerous times.

Just my opinion.

Vincent
