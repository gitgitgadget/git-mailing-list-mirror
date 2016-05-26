From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [RFC/PATCH 2/2] log: add "--no-show-signature" command line option
Date: Thu, 26 May 2016 22:12:30 +0530
Message-ID: <CA+DCAeRRunqgbbbpDDK6gA-cXYrPtkmAuX-ERvtDtXsD2Z=xkw@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-3-mehul.jain2029@gmail.com>
	<20160526163241.GC18210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 18:42:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yMl-0002U4-ST
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbcEZQmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:42:32 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:36116 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcEZQmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:42:31 -0400
Received: by mail-qg0-f66.google.com with SMTP id l75so1687696qgd.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=c4kxi24pxjYK/tDNpx94F4c9A3IXApjWgCf7wwkdp70=;
        b=KcgSLHOgLU5fw+FaV4qJnV7YqeUbu/LXvD81FL/DVb6OhURPj8bz7Lm4Lp948yc6PK
         Ig5VYiP7/M3+HapidoqouXbmJCKyG1f2wqbbOCyW6iGbVJjueAhUQY2r3pxIxoAPr3yx
         46276S2xP21SHcpx8PcTFIKtHIGi2OhaWzQOEooWRnfkzEYfSjJChZvssa/2G5KI1fTf
         glKdcqKlLa1DtdYPRy0fBcyyNJ87j4W3UzCmq/4gpkacokW0Gcg/QXCi7Eht3ThkZJAE
         EiIHqURAVYFlg2rn+b5wOA6z3J/xwWjBkG0jOoidoPxWdqxEElMQPi6h5op/uR/btwtS
         kaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=c4kxi24pxjYK/tDNpx94F4c9A3IXApjWgCf7wwkdp70=;
        b=JWf1oWAZdSkJRYpi8JM4+dVoGogp7pWaXrFcv3q8ROFLOR2eOmHH8HGw83UknYcXNq
         uSy7LhM/gSv/tXep64OFqnyKzKJhjwu0cA2Jl0gyo0nSCMrwJpTk6wpppsRZ7E7/8LsC
         5UjlPtbAzHPwk+FSwuxbod0Akte7cRjLLWjNLvlG7HLMIe74ts1YKy+tieqGf2rspwFA
         AkFXYXOOiODZVCkGIGcdk+hfWhdL0V+qwgMajX5SKRrAQKcXNgz26Zoihw0e+OHEonUO
         qSYh5nzQjlc2yzRlUp1CsHfKrvG/BaFQCVTawxXVCJsEuHLPPz3htdMg3IyOZXQ12gLl
         QU4w==
X-Gm-Message-State: ALyK8tLxsdsY/+ha1uwOXPRIdLhCUMevX9cMl2IJIEar8BgsWnpU2UjUN7bvSRzdFNidwTtpc9cc1yjALDahXA==
X-Received: by 10.140.107.101 with SMTP id g92mr9480755qgf.87.1464280950695;
 Thu, 26 May 2016 09:42:30 -0700 (PDT)
Received: by 10.55.56.139 with HTTP; Thu, 26 May 2016 09:42:30 -0700 (PDT)
In-Reply-To: <20160526163241.GC18210@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295667>

Hi,

Thanks for your input.

On Thu, May 26, 2016 at 10:02 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 26, 2016 at 06:36:47PM +0530, Mehul Jain wrote:
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 36be9a1..ea24259 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -901,6 +901,13 @@ test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
>>       test_i18ngrep "gpg: Good signature" actual
>>  '
>>
>> +test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
>> +     git config log.showsignature true &&
>> +     git log -1 --no-show-signature signed >actual &&
>> +     test "$(test_i18ngrep "gpg: Signature made" actual)" = "" &&
>> +     test "$(test_i18ngrep "gpg: Good signature" actual)" = ""
>> +'
>
> Perhaps it would be more robust to simply grep for "gpg:". We should not
> be seeing any gpg-related lines in the output. It probably isn't that
> big a deal in practice, though. If the output from gpg changes, this
> test could report a false success, but all of the other nearby tests
> would show a breakage, so somebody would probably notice.

That's a very good point. I will make the changes accordingly.

Thanks,
Mehul
