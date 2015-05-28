From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to
 'ref-filter'
Date: Thu, 28 May 2015 12:38:34 +0530
Message-ID: <5566BEF2.2000301@gmail.com>
References: <556317F8.2070609@gmail.com> <1432557943-25337-1-git-send-email-karthik.188@gmail.com> <xmqqegm4bmtg.fsf@gitster.dls.corp.google.com> <vpqpp5nfiea.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 09:08:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxrvp-0007bT-G8
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 09:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbE1HIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 03:08:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33385 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbE1HIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 03:08:40 -0400
Received: by padbw4 with SMTP id bw4so16831130pad.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Zz84jEK17xPs07yjW98boPPTlPO40yjci/cdRwQpPGA=;
        b=eUpvxWKc5tr01LYSOhO3SyrCUYVN+TEY2bsvbmqAxkdz8oleERFh696G46/XFGyIsZ
         qx3rTNpnUnwFkPvVUEKK02q/43oa6WZBWumcnndxn69AWJfHigoOlUPDDeTvq3VR2fGi
         OihDoQOOdhK8uT7V77yu2o7eN3RYbHbJcjaT0xGIiXC2so5iLNO7LqT7K+RGqA5xPsxi
         1soOcZtEdv5dx01fjnEFO13HCe0Gzzd5G8j9YFgz4v0YS3bHA6Tn12JOMMfuxn2VmaQy
         aJVUDOvdi8lqoFqCVli0HcWOqMkKR6n15HgBctySv8fXrVWF1gZW5gbsrWB0VDcSu7u/
         G+qg==
X-Received: by 10.67.1.98 with SMTP id bf2mr2826490pad.33.1432796919988;
        Thu, 28 May 2015 00:08:39 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ae9sm1266805pac.25.2015.05.28.00.08.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 00:08:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqpp5nfiea.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270126>

On 05/26/2015 09:19 PM, Matthieu Moy wrote:
> Seconded. Some reasons/guide to split:
>
> * Split trivial and non-trivial stuff. I can quickly review a
>    "rename-only" patch even if it's a bit long (essentially, I'll check
>    that you did find-and-replace properly), but reviewing a mix of
>    renames and actual code change is hard.
>
> * Split controversial and non-controversial stuff. For example, you
>    changed the ordering of fields in a struct. Perhaps it was not a good
>    idea. Perhaps it was a good idea, but then you want this reordering to
>    be alone in its patch so that you can explain why it's a good idea in
>    the commit message (you'll see me use the word "why" a lot when
>    talking about commit messages; not a coincidence).u

Since one of the patches is to restructure and rename 'for-each-ref', I thought
It would be ideal to introduce the data structures within that patch, What do you
think?

>
> * Split code movement and other stuff. For example extraction of
>    match_name_as_path() would be trivial if made in its own patch.
>
> I'd also make a separate patch "introduce the ref_list data-structure"
> to introduce struct ref_list and basic helper functions (constructors,
> mutators, destructors).
>
> It will take time and may appear to be counter-productive at first, but
> you'll get used to it, and you'll end up being actually more productive
> this way (well, maybe not "you" but the set "you + reviewers").
>

Thanks for this.

-- 
Regards,
Karthik
