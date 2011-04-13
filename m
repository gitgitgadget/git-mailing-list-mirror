From: Joshua Juran <jjuran@gmail.com>
Subject: Re: git rebase --continue automatic --skip?
Date: Wed, 13 Apr 2011 12:02:51 -0700
Message-ID: <D9A445D1-C0B5-4CB4-A847-E44618A6DD90@gmail.com>
References: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com> <20110409000351.GA7445@sigill.intra.peff.net> <7vy63iyk2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, skillzero@gmail.com,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:03:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5LB-0006Wq-As
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757830Ab1DMTC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:02:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46242 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362Ab1DMTCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:02:55 -0400
Received: by iwn34 with SMTP id 34so810112iwn.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=kCahc2x7Ntk7KtIoOQ+l35L6h4FiyO0qnCdvjJdEIyU=;
        b=vgZZUPGSV/mUaFTabdauNm8R9FeEQXPazkmKp7MTpGdUYAhRUdk1dVzPYLcdhAhIcb
         cQDAxf9BHr1L8mVOKNQOAmO8audL6Vxnkr1WOeHPU68+sX/u2aPFQ7KSqcAD1qx2H+he
         PY4S3kWoAV/DPDd9lpINBgIKcbkca1JPxk9mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=iprhTt4YYfVriotC6eqBi7rL9WuBv6a5tdXDP25fEdsyPs4AOjs0zFCzbTuzPYK0GJ
         H96kcnhh/XSoAdCsO5r4swA2at/qkgstFn3sNEUAuoRJYSfY4PIGa367niHKya/Ghetv
         tlf1TT8Yvh5mKc/Cn8FE1gCsTvmwoGHFxVsgM=
Received: by 10.231.39.129 with SMTP id g1mr6768265ibe.193.1302721375158;
        Wed, 13 Apr 2011 12:02:55 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id e9sm607302ibb.49.2011.04.13.12.02.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 12:02:53 -0700 (PDT)
In-Reply-To: <7vy63iyk2r.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171473>

On Apr 9, 2011, at 6:24 PM, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> I put it in rebase and not straight into "git am", as I'm not sure  
>> that
>> "am" would want to share the same behavior. I'm not sure why we  
>> haven't
>> done this up until now. Maybe there is some corner case I'm not  
>> thinking
>> of where the user would want to do something besides skip when we hit
>> this situation. I dunno.
>
> I think the "rebase --continue" behaviour was more or less  
> deliberate (I
> do not necessarily agree with the reasoning, though).  It is to ensure
> that the user has a chance to examine the situation and acknowledge  
> that
> it is fine to completely drop the now obsoleted change, as having to
> adjust the change to an updated base, even with conflict resolution,  
> may
> be common, it is a rare and notable event that the resolution ends up
> being empty.

Rather than changing --continue, the proposed behavior could be added  
as `git rebase --next`.

Josh
