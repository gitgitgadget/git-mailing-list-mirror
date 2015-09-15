From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7] git-p4: improve path encoding verbose output
Date: Tue, 15 Sep 2015 08:31:09 +0100
Message-ID: <55F7C93D.1080309@diamand.org>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com> <1442250640-93838-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 09:31:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbkiJ-0002tR-VL
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 09:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbbIOHbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 03:31:13 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34470 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbIOHbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 03:31:12 -0400
Received: by wicfx3 with SMTP id fx3so15332366wic.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=zMHQAxWi9tY2ZgM2ftWTQ6eQWPjd+virjHFn0VKtnho=;
        b=Fn6iBZnVFMK0lIXPdJ1XPxtTLMArpLjm1h3/u0AdRuvenv+37Tntewi69FWZml+zdQ
         dxc7TivoTO7rSb7fM+T02q5FrQm1lgqkZIUMKlajrpoCzG219GUkZZY6MyYWD1teAWrM
         18gtRzxqku3nzS1tiI2SgcjckU6zQc6SNPjyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zMHQAxWi9tY2ZgM2ftWTQ6eQWPjd+virjHFn0VKtnho=;
        b=WGtOSV1j0C28j5IZDvZUrTCTBNzDY8Fe9FMCci3Hq7uOqNvLT9ACNJX6vfRoNCOi1f
         kWSw9b6M4oFF9UlITGgqB9/kDyQ25iJ4YiilwMKW4juUUIrDQFp84rlNXPFfNpR3jEak
         JMgnUACuSPtumE/Mc7BWdBOiusWlACXkyC7C4lgbxwQ0EbgsrnJEXUgl8TlicmnkOvrS
         yaoFbP00gCKMpxBsCBsP2ogETb1CklrRx0hxJFnYG7QIQjF2d/q+p2MRfT1FZCLHrW8z
         XuVtgumAP0NhdtN3FcVMsFR6cmeYEsmNzTQvG0PezILrbWktfOBrTlEwGAFbFg9xkYHG
         y8Yg==
X-Gm-Message-State: ALoCoQnvp0LbLKMlc+bPmYjWZ85ECnV4PRpSvCM/wfePKtzzUKYySzCixa0qmFTENI9LZVpFca91
X-Received: by 10.180.8.3 with SMTP id n3mr4329671wia.41.1442302270900;
        Tue, 15 Sep 2015 00:31:10 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id mz12sm18357949wic.4.2015.09.15.00.31.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2015 00:31:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1442250640-93838-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277891>

On 14/09/15 18:10, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> If a path with non-ASCII characters is detected then print always the

s/print always/print/


> encoding and the encoded string in verbose mode.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   git-p4.py | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index d45cf2b..da25d3f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2220,16 +2220,15 @@ class P4Sync(Command, P4UserMap):
>               text = regexp.sub(r'$\1$', text)
>               contents = [ text ]
>
> -        if gitConfig("git-p4.pathEncoding"):
> -            relPath = relPath.decode(gitConfig("git-p4.pathEncoding")).encode('utf8', 'replace')
> -        elif self.verbose:
> -            try:
> -                relPath.decode('ascii')
> -            except:
> -                print (
> -                    "Path with Non-ASCII characters detected and no path encoding defined. "
> -                    "Please check the encoding: %s" % relPath
> -                )
> +        try:
> +            relPath.decode('ascii')
> +        except:
> +            encoding = 'utf8'
> +            if gitConfig('git-p4.pathEncoding'):
> +                encoding = gitConfig('git-p4.pathEncoding')

It would be better to query this once at startup. Otherwise we're 
potentially forking "git config" twice per file which on a large repo 
could become significant. Make it an instance variable perhaps?

> +                relPath = relPath.decode(encoding).encode('utf8', 'replace')
> +            if self.verbose:
> +                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
>
>           self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
>
>
