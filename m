From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Wed, 13 Apr 2016 16:19:18 +0530
Message-ID: <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
 <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com> <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 12:49:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqIMv-0007vf-Hy
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 12:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbcDMKtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 06:49:53 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33300 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbcDMKtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 06:49:49 -0400
Received: by mail-qg0-f42.google.com with SMTP id j35so39622723qge.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yWhqDe/3v6Uf3Pc5IATNVyLXZsAIXTLLaQJS4g3j3r8=;
        b=jSB15jgb3WvM0T5LQUEfaus8cZ7g+utWNRbicRzTodKqby6/Y4EZ5fajW7xKgJ3XKs
         VXKI0yoHIDytWOWlbMZzO+rBycIR2kXfS8ZoNS0fSKdP505MpAVvpfPMdYVEp3b+x2Eg
         lIRRMAhulLlHU1Cc/BSR51vesNvzYLLg9bKMfRff4T3WJrjSOx8zmiciAYMrpldrDDo2
         mVvjYZYQH5/QWBBxZqes83aG6ndrXRZl1QgZ9UHQB0V3ubHRgsiPAT++p+MMouPLyT6W
         6hsTGZqTPg2z4/Le84DP8cXIHHV419/ihfpLr7aucdspiDKoAiQXjwHXwGPhbyRBPrzw
         E2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yWhqDe/3v6Uf3Pc5IATNVyLXZsAIXTLLaQJS4g3j3r8=;
        b=iCQHOlQNNuYW9Hw3FyyWMaJJiPYLLiZX+9VMj8IkMs+SyLVdK9XlyTiB6oQoblj3Ac
         ybx4vihZ+ftxqGbmpaQNpy0oa67ctt7BWrsafb7zOTAEb40btp+BoWtcxgn0zcxiXGxv
         Ykytc74G0IqkrpLcRtKcf/7uTVqPVnG8rPUnRj47S2vwKRpPmATb2eJSXZOFeseJJHwD
         0m5XCoRoWmu9nUv/w200LnMd7/yez1imPfPSCkz5XQYLBFwh5hqfyml49um3C3oAM2pI
         ns4iv8scWT+deSSeqr0k6y81mKbzlc7VYseIABG0vbfn+A58jCzJZVhJPVAf5WNBdiil
         hl+A==
X-Gm-Message-State: AOPr4FWm+IAE48OIii+FPo56X5iRsjHSB9BXyPjBHL4ohsRzMmLR/+B6qKZrL1jXOOTLYxxmMrV3mg4ubKgQJA==
X-Received: by 10.140.19.52 with SMTP id 49mr10003988qgg.103.1460544587689;
 Wed, 13 Apr 2016 03:49:47 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Wed, 13 Apr 2016 03:49:18 -0700 (PDT)
In-Reply-To: <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291388>

Hello,

On Wed, Apr 13, 2016 at 2:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> +                        branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
>>> +                        remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
>>> +    } else {
>>> +            strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
>>> +                        branch_get_color(BRANCH_COLOR_RESET));
>>> +            strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
>>> +                        branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
>>
>> The overlong lines are somewhat irritating, but the change above in
>> this round relative to the previous one shows a good use case for
>> the conditional formatting feature and illustrates how powerful the
>> concept it is.  I like it.
>>
>> Thanks, will queue.

They are quite long and a little confusing, but like you said really powerful.

>
> Having said that, doesn't this need to be further adjusted for
> 95c38fb0 (branch: fix shortening of non-remote symrefs, 2016-04-03)?
>
> http://thread.gmane.org/gmane.comp.version-control.git/290622/focus=290624
>

That was one of the changes made in this version of the patch series :)

-- 
Regards,
Karthik Nayak
