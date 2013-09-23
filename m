From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 07/15] contrib/git-credential-gnome-keyring.c: ensure
 buffer is non-empty before accessing
Date: Mon, 23 Sep 2013 10:21:28 -0700
Message-ID: <CA+sFfMc9xzPvR55gxriFd_dxPra4kvB6+2MRnq5haQTwPwUnLw@mail.gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
	<1379912891-12277-8-git-send-email-drafnel@gmail.com>
	<523fd4f6965ad_b79d67e786506@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, pah@qo.cx
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 19:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO9pG-0004MV-7L
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 19:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab3IWRVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 13:21:30 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:65530 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3IWRV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 13:21:29 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so3441482wgh.14
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ksZY9WYIdcCl+EdVFbIwIIm8XesMhJycFFgmL2XIkX0=;
        b=O9HYhsgIeD+1nlxwWdjoCONKAeiYqzzjUZytrQ+AOy5NwH/XVgVwVqzKk53nr+VCag
         apoa9pm02ZF9zFw1IOpQEJT7hpp56b4Is1bRX5dcelP/GGvGoo8x8t9mY5VYP05ib6rm
         fffwKS/AwCeM793BP5CBZ86FGb7oMpIcY4WQlqz6l5kZyZZrtlg1cAEE7pz7B6FY/dHc
         IVyfvY78Z08XQ6uOo6DTU4ZqdBJp6+Toid6ZuSmKdKr9V0dVUdkjJmBMQS5tNmpTJtxF
         NoRJtJxTcrVuBzEaZu+xYbTnnlX2TLuOEyknXT7CJkCsEfxNjVUsUjYjdKqPAFrUHGL3
         1YHw==
X-Received: by 10.180.160.178 with SMTP id xl18mr14497496wib.61.1379956888625;
 Mon, 23 Sep 2013 10:21:28 -0700 (PDT)
Received: by 10.194.85.168 with HTTP; Mon, 23 Sep 2013 10:21:28 -0700 (PDT)
In-Reply-To: <523fd4f6965ad_b79d67e786506@nysa.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235208>

Thanks.

On Sun, Sep 22, 2013 at 10:43 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Brandon Casey wrote:
>> Ensure buffer length is non-zero before attempting to access the last
>> element.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>>  contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
>> index 1081224..8ae2eab 100644
>> --- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
>> +++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
>> @@ -315,7 +315,7 @@ static int credential_read(struct credential *c)
>>       {
>>               line_len = strlen(buf);
>>
>> -             if(buf[line_len-1]=='\n')
>> +             if(line_len && buf[line_len-1] == '\n')
>
> The style is if ().
>
> --
> Felipe Contreras
