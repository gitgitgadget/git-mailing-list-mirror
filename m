From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 2/4] git-p4: add gitConfigInt reader
Date: Thu, 03 Sep 2015 20:57:59 +0100
Message-ID: <55E8A647.90903@diamand.org>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 21:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXae1-0000Qc-ML
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbbICT56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 15:57:58 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37520 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbICT55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:57:57 -0400
Received: by wicfx3 with SMTP id fx3so341011wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ycpof55Scw5o5lZ+AxPBLfEvQR4F837lgNj9QuKSpzY=;
        b=Pzws7WGamceeDC8hYqf5LStKAhQ1EVwpND9h4ObMl6ygJYUG1CVxiqjDY17kagkrpa
         VE5fGYA4Z2CRnOWgtyODmOcoRFSmtv731o8KAaFu4WxRcIbCNkbBr0b0tvRWYNQgNTQ5
         mM2T9Kn0TwtjE2rJLkt8JWFd0/f/59TgW+5jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ycpof55Scw5o5lZ+AxPBLfEvQR4F837lgNj9QuKSpzY=;
        b=dcPcpIzCDzTJmiyzPQ2DJjbNwydjPOlX7eEbft9NMVBNiOr99yTMJ3IzD9LZ6KVgQg
         q6TOAPfjpNI6hTphpxTcLHfzvxC449O8KgXN5jXCvgHuxRXHwio77gQ3hJu4/ausX/ZF
         7VZXk7ZQpa78obBfVHrNWobc2bcty+SqL4NQMzyz05HmMa0YG2DOoyG8JCkqhOu25TlA
         v6lGP7IhMZUQye06FmlxhcOc6CAPhn93VzxX1YLzOrr5fLOKGOUJTOelJOd6uJ3f8dEG
         P0RFAmZ5Rtn6NPGKMWP09Kv+eXFYysovcAGELlF0otEY9UaQDwTkVj+7QfutfxG/V7Gq
         EjYQ==
X-Gm-Message-State: ALoCoQkI6WNQi3fJ7Man8QSu3GqRTcEsqC5mZvQF0qTfjufMzSV3g5rCa6FFxDfVIW3ERTWYTzO6
X-Received: by 10.194.85.163 with SMTP id i3mr54244060wjz.75.1441310276109;
        Thu, 03 Sep 2015 12:57:56 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id eu10sm709490wib.5.2015.09.03.12.57.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 12:57:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1441298148-63885-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277247>

On 03/09/15 17:35, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>

Explanation?

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   git-p4.py | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index c139cab..ae1a4d3 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -623,6 +623,17 @@ def gitConfigBool(key):
>           _gitConfig[key] = gitConfig(key, '--bool') == "true"
>       return _gitConfig[key]
>
> +def gitConfigInt(key):
> +    if not _gitConfig.has_key(key):
> +        cmd = [ "git", "config", "--int", key ]
> +        s = read_pipe(cmd, ignore_error=True)
> +        v = s.strip()
> +        try:
> +            _gitConfig[key] = int(gitConfig(key, '--int'))
> +        except Exception, e:

Could do with specifying the actual type of the exception here (ValueError).



> +            _gitConfig[key] = None
> +    return _gitConfig[key]
> +
>   def gitConfigList(key):
>       if not _gitConfig.has_key(key):
>           s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
>
