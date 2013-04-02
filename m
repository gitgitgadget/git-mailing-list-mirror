From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Tue, 02 Apr 2013 22:55:07 +0200
Message-ID: <515B45AB.5030503@gmail.com>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>	<vpq8v5uueug.fsf@grenoble-inp.fr> <513E3190.20100@gmail.com>	<20130312013736.GB7105@unpythonic.net>	<vpqwqtdkq9z.fsf@grenoble-inp.fr>	<CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com> <vpqwqslgfzf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8FC-0005Wu-CK
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762446Ab3DBUzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:55:17 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:36706 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762410Ab3DBUzP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:55:15 -0400
Received: by mail-bk0-f51.google.com with SMTP id y8so436723bkt.38
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=BbuXjDonjjTEnDDfOgE0hML4MkTheNDnXzlnuL4XKiI=;
        b=fpUjKUaFLQSCyFPKUDkI6yoVmyMw/wqi7DNX1KA60HQYAjkgiFycjbL7p+tWCYvOkr
         N71mUm15uyiF4BES3VIXeCb2lqtRjhF9+l7QmfLjtfnDvwlGIrohcxblBy3lo4bQpGov
         FkwlcQ9UDGG3asX6AyWsXA5EkYKItbIdEpmJ11WMY0GPQBgDpm44mTWYNwt2ltIsuD3R
         M1zBZjsgkjmOM68yrYu+RM8BUzTgYXtQkJlD6iv8b0Ya6eLSnKlPVsFitcR9V6KJoz3/
         lO6356WcJ5ZfcqQTCn6z/3zTSjEb4Z1YAH+8jGWpwSzsS9ZbSs7Jm6PLerVmej8jNTvV
         0/VQ==
X-Received: by 10.204.169.144 with SMTP id z16mr7389981bky.109.1364936114417;
        Tue, 02 Apr 2013 13:55:14 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.217.144])
        by mx.google.com with ESMTPS id v2sm1243131bkw.5.2013.04.02.13.55.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 13:55:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <vpqwqslgfzf.fsf@grenoble-inp.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219884>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 02/04/2013 16:32, Matthieu Moy ha scritto:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> And this is a workaround:
>>
>> --- a/contrib/completion/git-completion.zsh
>> +++ b/contrib/completion/git-completion.zsh
>> @@ -66,7 +66,7 @@ __gitcomp_file ()
>>
>>         local IFS=$'\n'
>>         compset -P '*[=:]'
>> -       compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
>> +       compadd -Q -p "${2-}" -- ${=1} && _ret=0
>>  }
> 
> OK, not something we want to apply to git.git, but this means a
> workaround for users is to create a _git file with this content instead
> instead of copying/symlinking git-completion.zsh as _git (replace
> $GIT_ROOT_PATH with the appropriate value)

By the way: have you filled a bug report to Debian?


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlFbRasACgkQscQJ24LbaUTDZQCfbfF5yhxCfUSaWdv0pE7++X3l
Lc0AniAw5lEL6iunM+Tw8HvYxGwjuYYh
=KpQI
-----END PGP SIGNATURE-----
