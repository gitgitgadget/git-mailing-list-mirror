From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] p4: Retrieve the right revision of the UTF-16 file
Date: Wed, 27 May 2015 23:04:34 +0100
Message-ID: <55663F72.6010800@diamand.org>
References: <1432765918-7352-1-git-send-email-miguel.torroja@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Miguel Torroja <miguel.torroja@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 00:05:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjRx-0004w5-02
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbbE0WFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:05:16 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36430 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbE0WFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:05:14 -0400
Received: by wgbgq6 with SMTP id gq6so21183524wgb.3
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QVlLSwvZ+i9wnpgyJKX8Wux5kTcNdHME4agmUYqBW+A=;
        b=LXMgO8GZtsjvTSwime+aPc5gQmB4qEOm5PtD52J+pY0z9DiO5ZjEz8ePbZmZe/kN5h
         q5bGKr11Jeu+6iU+GP8xGPT9A/r97vPNuzP5qCZj0vIQ0Nbm8r8ad/xItvUrtnahz0M0
         xBDax/aKFk62bZybwskvksDTb+hJYX3q5tQS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QVlLSwvZ+i9wnpgyJKX8Wux5kTcNdHME4agmUYqBW+A=;
        b=F1vYhGcPQb7z0plV0SmB2zSao02iuqIpZFa06nZ4P4L/qh+TouoZHFpJfrLTVEPRWy
         VzXORu1Pk+A8DfEpyKID0ZJtDJcvQdwCAk7GQb13SnNxvGplBd3FyEbWEbLGkUhyx7cD
         55//8jIW5hx687RKu4qNrsITqA8SRyWkG1KY9mgtRs0g9o/fR7E8hpkQ9COh8XD37g/B
         I1ZWB/2Vd0tF9c5DvEjC5+n+sQSYiOPRTGr8hYNmZOzqa12OS5SDFxHR/EW9IEbsjVBA
         6oIgr4nkUMa9R+7UBpSYuYlu4tb2KM5PyNxogpKEMNxwdS15ujGgNkKJYBboPyZ4erGV
         a5sQ==
X-Gm-Message-State: ALoCoQn73HP2llqsZJ1i/5RBt7WAmfsz+i8bF62UkFaD+aBfkI+FTZohNwYnFZSy2RFZgS92WHAl
X-Received: by 10.194.63.228 with SMTP id j4mr13381656wjs.38.1432764313348;
        Wed, 27 May 2015 15:05:13 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id xy5sm382927wjc.35.2015.05.27.15.05.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 15:05:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1432765918-7352-1-git-send-email-miguel.torroja@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270106>

On 27/05/15 23:31, Miguel Torroja wrote:
> Fixing bug with UTF-16 files when they are retreived by git-p4.
> It was always getting the tip version of the file and the history of the
> file was lost.

This looks sensible to me, and seems to work in some simple testing, thanks!

Ack.

Luke


> ---
>   git-p4.py |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index cdfa2df..be2c7da 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2098,7 +2098,7 @@ class P4Sync(Command, P4UserMap):
>               # them back too.  This is not needed to the cygwin windows version,
>               # just the native "NT" type.
>               #
> -            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
> +            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" % (file['depotFile'], file['change']) ])
>               if p4_version_string().find("/NT") >= 0:
>                   text = text.replace("\r\n", "\n")
>               contents = [ text ]
>
