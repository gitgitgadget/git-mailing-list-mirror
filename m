From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig
 reader
Date: Thu, 03 Sep 2015 20:55:46 +0100
Message-ID: <55E8A5C2.9090500@diamand.org>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 21:56:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXac4-0006y1-3n
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbbICTzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 15:55:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33050 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbICTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:55:44 -0400
Received: by wiclk2 with SMTP id lk2so1584722wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=0qr+AkN2byOb21EVmmKhUou2iI8umnXc3l7cqSTQ98Q=;
        b=S6hD2hFwhLss3bm+DJVAPiJbL+Bw0pkLcYMZug7GVIGjNos97MwAOTuhH7vZwPmGmA
         jjgt2pPXyO01uGmeuwrR7Jh5pB3+fi22USQV3WRxjw81vHzV4eFtleuqpc/H6mHD660Z
         F/kQ7xwIb4ISfbo5WELs8kYOF/2p9nm8jznxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0qr+AkN2byOb21EVmmKhUou2iI8umnXc3l7cqSTQ98Q=;
        b=JBK46ybsY9kyNQmEmcohAGzLs8cWogArTZ425Krqp2laEv8SnIiovqg1b5n2RiHl0y
         fqW8eNqUvndX0p2fCJESKl8jreFVPW41Okysiz3Ccc8RzAydTDVG7ia0fTKqbuIiYAUr
         w7cmerAhY0Tf7dYy2qMaACaGIftptLE3/0kzOvOJP2h+eZzjbVrTONEkcHGHYZhu45O2
         bzjHbrxz5pMLk6URBkwGWA/jNQvZ53GLPUf4v81HWuc0Cs4iEB6QeIqxXzOB4FZrTvuz
         67U5pH+nb4vxCvwIm3pmz5L3BeFPMQmOpNHGPi9hZFlZjH7+UefXT8lyoExKWgP5KYnQ
         zrWQ==
X-Gm-Message-State: ALoCoQn9PJdg14R2mN6JbKlY1zVbmf+RgFgvww+0rBgJ3YDohaKHc05a7YTFmVj7j0HO0tNwcvyQ
X-Received: by 10.180.24.72 with SMTP id s8mr143012wif.49.1441310143096;
        Thu, 03 Sep 2015 12:55:43 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id pu6sm39353548wjc.34.2015.09.03.12.55.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 12:55:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1441298148-63885-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277245>

On 03/09/15 17:35, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>

I think this commit may need some explanation!

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   git-p4.py | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..c139cab 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -604,9 +604,12 @@ def gitBranchExists(branch):
>
>   _gitConfig = {}
>
> -def gitConfig(key):
> +def gitConfig(key, typeSpecifier=None):
>       if not _gitConfig.has_key(key):
> -        cmd = [ "git", "config", key ]
> +        cmd = [ "git", "config" ]
> +        if typeSpecifier:
> +            cmd += [ typeSpecifier ]
> +        cmd += [ key ]
>           s = read_pipe(cmd, ignore_error=True)
>           _gitConfig[key] = s.strip()
>       return _gitConfig[key]
> @@ -617,10 +620,7 @@ def gitConfigBool(key):
>          in the config."""
>
>       if not _gitConfig.has_key(key):
> -        cmd = [ "git", "config", "--bool", key ]
> -        s = read_pipe(cmd, ignore_error=True)
> -        v = s.strip()
> -        _gitConfig[key] = v == "true"
> +        _gitConfig[key] = gitConfig(key, '--bool') == "true"
>       return _gitConfig[key]
>
>   def gitConfigList(key):
>
