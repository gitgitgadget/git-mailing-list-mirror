From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 16:41:47 -0500
Message-ID: <CAMP44s2-QZxuV-bXc_0zeqxJDy=Y6AAC0iwgbjNDNuCaaMcErA@mail.gmail.com>
References: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
	<87haiu7jgn.fsf@linux-k42r.v.cablecom.net>
	<7v1u9y2u4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTvO-0001b0-AC
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757771Ab3DYVlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:41:49 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:59445 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab3DYVlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:41:49 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so3238553lbi.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sSMG9Gg/LKlXDiGPRV42W4b4eVz55QKfsaVZA20d6io=;
        b=yI9HLHzdKPEy17lV1I5v2HnEloeij8KigsWaR3bvtL4ttF4+fSu3p8qL0ch65ofnSN
         /E+adYjUZ1iuWWTxgVUzhZwx6JCAvSLOMLC5xMHsCwyYjkljzUykTXCKXK/aM3HpBDxy
         nV2iPCsUy2ga6zcGK+iGPsFxTcjTySMjEMcsSkZnJoJOvmwx5lbeY15ByysU/ja1guGA
         RivknvGllIqI68CmL+LCeRN56eCORzxiDcXwm19w8OwJ9VwYOUCeA/feuRtzhqmyCRjb
         gmRNLZK2SkQ8HHq7v88Hl4a5gTO27MdfnS3I3G1P9EAJeekb45UCP+k0uPMSNxKGjVAL
         Fy0Q==
X-Received: by 10.152.5.134 with SMTP id s6mr21271687las.24.1366926107631;
 Thu, 25 Apr 2013 14:41:47 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 14:41:47 -0700 (PDT)
In-Reply-To: <7v1u9y2u4q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222454>

On Thu, Apr 25, 2013 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Not just randomly synchronize the revisions with no checks at all. This
>>> is the way bazaar's UI does it.
>>>
>>> Also, add a non-ff check.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>
>>> This patch should probably go to maint, as the results of pushing the way we
>>> currently push are not really understood. Perhaps it's similar to a 'git push
>>>  --force', or perhaps it can potentially screw the repository.
>>>
>>> It's better to be safe and just do what bazaar does.
>>
>> Other than "this patch should probably go to maint", this should be in
>> the commit message.
>
> Hmph, should it?
>
> I do not quite understand what "... are not really understood.
> Perhaps..." wants to say.  Understood by whom?  By the author of the
> patch?  By the author of the original code?
>
> The log would end up saying "Doing the same as bazaar should be the
> right thing to do(TM), but don't ask me why.  I do not know what I
> am doing, or why checking is better than not checking, but it seems
> to work".  That _could_ be the truth, but it won't help people who
> are reading the code later, will it?

In addition to that, it's doubtful there's anybody who would actually
know. Bazaar is basically a dead and unmaintained project now, and it
has been for quite some time. It seems the people that had any idea
are long gone.

My gut feeling is that we should do it the way the Bazaar UI does it,
I don't have any evidence that there's anything wrong with the current
code, which Bazaar seems to but have, but for different purposes which
are hard to explain. I would rather avoid surprises.

-- 
Felipe Contreras
