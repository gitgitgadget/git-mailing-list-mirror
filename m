From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Is there any efficient way to track history of a piece of code?
Date: Thu, 08 May 2014 19:35:49 +1200
Message-ID: <536B33D5.7090301@gmail.com>
References: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: Jianyu Zhan <nasa4836@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 09:36:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiIs3-0005mF-I4
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 09:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbaEHHfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 03:35:55 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:50333 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaEHHfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 03:35:54 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so2117957pde.13
        for <git@vger.kernel.org>; Thu, 08 May 2014 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rQuvZzVLfUv/ZJpt3bfcOj6VtIPV0mr+KxXfztXbVjE=;
        b=BqKsmyaTtGb6NajQoFCuJrCvvlTYbPEi1wYQPlhjlkSFWJDewyKmATjSeH/Kf2Wi/j
         FvZV/BI/kwXkzQ1ueNEd2iondbwcSUGiP+EHzKn0TMKc0fHEDobEIkojG6B7ZSgaKpe4
         BWwiuswlFe2BdM6GBWi4386/+rciBn0+yyAFB89DBNQCC5eiQ88ek8vjzGGPHYRvmmcy
         NwRGDsDk+cXNI94OFyo2xM/YMhy201LsgVhiNZHJYtShH/CrPBSCYROrxTn2vLP95hcz
         EY9/WAibNab0edGFQOMcbztqRi4xSeU1Y5ZQwgyWZCLqaB5jksyhJrvQcPmfT4KwuYwp
         l8+A==
X-Received: by 10.66.65.169 with SMTP id y9mr4261774pas.145.1399534554499;
        Thu, 08 May 2014 00:35:54 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id kt8sm1012368pab.7.2014.05.08.00.35.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 May 2014 00:35:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248413>

On 08/05/14 18:54, Jianyu Zhan wrote:
> Usually, a trivial change(like coding style fix) may bury a
> original change of the code, and thus git blame is of less
> help. And to address this situation, I have to do like this:
> 
>    git blame -s REF^ <file-in-question> > temp
> 
> to dig into the history recursively by hand, to find out
> the original change.
> 
> Here, REF is commit-id that git blame reports.
> 
> git log -L is a good alternative option, but sometimes it seems
> too cubersome, as I care only one line of code.
> 
> Is there any current solution or suggestion?
> 

I use "git gui blame" for this all the time at $dayjob. If there aren't
too many of these code clean ups then the eclipse git integration is
also handy for this but it will suffer from the same issues as git blame.
