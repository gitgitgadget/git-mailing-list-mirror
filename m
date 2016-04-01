From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Fri, 1 Apr 2016 13:42:51 +0300
Message-ID: <56FE50AB.2090109@assembla.com>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <xmqqpoujama8.fsf@gitster.mtv.corp.google.com>
 <56F42820.5000003@assembla.com> <20160324180223.GA9817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 12:43:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwXh-0003IO-5J
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbcDAKm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:42:56 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34194 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbcDAKmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:42:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id p65so20407256wmp.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=t/bYVMhQ9HsHRx0h6AUdlBAWojhJpro+q3H66Q9jE9M=;
        b=wiDXh72pEcwq8lxkCVtzhYfhVMvPjwddTSCsAxs/iR8RcYxgqnzK4z+STvazdEtTMK
         8BCVco1+BOqrWcqgzDXX3wyj1eVRLr8OPwa/JQ8EAtln6rsWfnpGTj3r0xk71oNwomWn
         BwUFTG3zUnk1lTYmkx3EzwCmR5V1vadwGIUKh+0gxTi7N1H4cu3LmiudfTgzM993Tsu3
         wW7UeCZPoadYa9jhnEBEcoMtaFrLbEJlAJ826pCTWytiEZLJWjQB9NN+4yvIvHeMdXHi
         ZB7Q6Niayk5pidyhzdjtVfpzb+1FMLZpqupqxpOutsa1/MZkaPzy+YGGf0UuJV3FHAYF
         L7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=t/bYVMhQ9HsHRx0h6AUdlBAWojhJpro+q3H66Q9jE9M=;
        b=SwkVyvLZfibVs/5C4DgHefvyAacWxrChG2nf+NUVmDcPUFa4DBJnGxBpXgshI6wJqu
         sXY/E1XYZ3PvIKn7gJVowucjF01e4xmJojd7rSQgfiL35sJWlWTyJe8iRn/kyzS2hgZ1
         6i9PHG+HX+sMr91oUCrYJ2B+yvZMYIbuPzaFovl9exkFx6zhWMs2mLnJuRXEE4wXB5wB
         lgETzJIiExAYgShcXjGMz3MiLSWniUcKzhcqqVsgxQmC54KqWZz5OjEbBU4ydjobR+Ju
         ElQqxO35Am+I7tFe8VOY70H57VlFiFQaMP26Y7uIaUwYU/yiT1S3gdZzEEShQUXShotG
         PViw==
X-Gm-Message-State: AD7BkJIdGY5K/uKyWIPUFla+Dn7oVZLtQyWsxzf3KGmiijaVkcWIktvoHydjW+R3WT+BUg==
X-Received: by 10.28.210.73 with SMTP id j70mr2974852wmg.8.1459507373946;
        Fri, 01 Apr 2016 03:42:53 -0700 (PDT)
Received: from [192.168.88.127] ([217.26.172.139])
        by smtp.googlemail.com with ESMTPSA id j18sm29390304wmd.2.2016.04.01.03.42.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2016 03:42:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160324180223.GA9817@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290518>

Thanks a lot, Jeff, your explanation really helped!

--
Regards,
Stanislav

On 24/03/16 20:02, Jeff King wrote:
> On Thu, Mar 24, 2016 at 07:47:12PM +0200, Stanislav Kolotinskiy wrote:
>
>>> Thanks for noticing; the above explanation however does not make it
>>> very clear why the symptom exhibits itself only when "directory" is
>>> given (it also is unclear if "target" being a directory is special,
>>> or if any remote repository specification, e.g. host:/path/to/dir,
>>> triggers the same problem).
>> I'll think about a better explanation and will post it here - thanks.
> Feel free to steal from the explanation I posted earlier.
>
> -Peff
