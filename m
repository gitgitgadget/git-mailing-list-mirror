From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 out of memory for very large repository
Date: Fri, 23 Aug 2013 20:42:44 +0100
Message-ID: <5217BB34.9080502@diamand.org>
References: <20130823011245.GA7693@jerec> <52170C6A.4080708@diamand.org> <20130823114856.GA8182@jerec> <20130823115920.GB8182@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Corey Thompson <cmtptr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxGL-0003jb-N4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab3HWTnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:43:09 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:37120 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab3HWTnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 15:43:08 -0400
Received: by mail-wg0-f46.google.com with SMTP id k13so920238wgh.25
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KGD15njb+XbhgTJA2kJ6YC2yGSBw08+jFcLTvlxRWkU=;
        b=ZNiKlzf/YwZpTK1m0G6XCT4DqVOIIke2EocZivvrpkgYHVTTySBVRFQ4DEdhPMY79f
         IynI99d7e9GQzVhngw3IhVGh23qTdATw7ADGlxavMahHPKoBNU3eTwiYMl0/gKLSZEzU
         iC+pZ3ZLekZfKWYMSuCAgRZ9IjckemYAnNGK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KGD15njb+XbhgTJA2kJ6YC2yGSBw08+jFcLTvlxRWkU=;
        b=S6XAZPUFAhVwQp7HpcKPzO1koAo3Yhk7eFwfYMaSK+ZmbYXniQASAtPHO6sksgdjws
         j84jmZiIWxJ8Qdf3pa9+pg2sxgyrDUFBdUCQ7kuN/qMHErE/Cj6uoI4hGeCeFxTZH+a1
         8BX5a9DEpyfsbSKmv7WEyCkSGpw30Ljb6Ng486L7bbu0hLobhauF+cDDMDGrwet1irbV
         33Ax3mOTLGi7lNmUlpAL1UDsi8K4fEDXnEOs/0uraVxxBvgUpOdtQtb8AOPCzOcrKPT2
         yoHcJoUy0tabsRGFCkRB+yB3RHUr+9oO/5Oto0sp7RYAxhwAqHCN4OhEgY5rOB7M2zOo
         LS6A==
X-Gm-Message-State: ALoCoQkXYO4xZ153TFU/cGnSok3aBGOyiQvwnW3wNgEjjqnPazjs93YLwLAY0Ys2SwZoiUyRPVvb
X-Received: by 10.180.73.103 with SMTP id k7mr3344727wiv.24.1377286986818;
        Fri, 23 Aug 2013 12:43:06 -0700 (PDT)
Received: from [86.14.230.179] (cpc14-cmbg17-2-0-cust690.5-4.cable.virginmedia.com. [86.14.230.179])
        by mx.google.com with ESMTPSA id r6sm2142141wiw.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 12:43:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <20130823115920.GB8182@jerec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232829>


I think I've cloned files as large as that or larger. If you just want to
clone this and move on, perhaps you just need a bit more memory? What's the
size of your physical memory and swap partition? Per process memory limit?


On 23 Aug 2013 12:59, "Corey Thompson" <cmtptr@gmail.com> wrote:
On 23/08/13 12:59, Corey Thompson wrote:
> On Fri, Aug 23, 2013 at 07:48:56AM -0400, Corey Thompson wrote:
>> Sorry, I guess I could have included more details in my original post.
>> Since then, I have also made an attempt to clone another (slightly more
>> recent) branch, and at last had success.  So I see this does indeed
>> work, it just seems to be very unhappy with one particular branch.
>>
>> So, here are a few statistics I collected on the two branches.
>>
>> branch-that-fails:
>> total workspace disk usage (current head): 12GB
>> 68 files over 20MB
>> largest three being about 118MB
>>
>> branch-that-clones:
>> total workspace disk usage (current head): 11GB
>> 22 files over 20MB
>> largest three being about 80MB
>>
>> I suspect that part of the problem here might be that my company likes
>> to submit very large binaries into our repo (.tar.gzs, pre-compiled
>> third party binaries, etc.).
>>
>> Is there any way I can clone this in pieces?  The best I've come up with
>> is to clone only up to a change number just before it tends to fail, and
>> then rebase to the latest.  My clone succeeded, but the rebase still
>> runs out of memory.  It would be great if I could specify a change
>> number to rebase up to, so that I can just take this thing a few hundred
>> changes at a time.
>>
>> Thanks,
>> Corey
> 
> And I still haven't told you anything about my platform or git
> version...
> 
> This is on Fedora Core 11, with git 1.8.3.4 built from the github repo
> (117eea7e).
