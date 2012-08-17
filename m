From: Luke Diamand <luke@diamand.org>
Subject: Re: Is there a way to find out which commit "git rebase --skip" skipped?
Date: Fri, 17 Aug 2012 10:32:12 +0100
Message-ID: <502E0F9C.5010303@diamand.org>
References: <CAE5ih78tYrX0F3AZ3vrE2p=_h24njhU_rTGEqbBHfJGkGuHmpw@mail.gmail.com> <7va9xu3kr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 11:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Ivj-0006NF-MV
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 11:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770Ab2HQJdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 05:33:17 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65387 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803Ab2HQJdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 05:33:14 -0400
Received: by eeil10 with SMTP id l10so1157071eei.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 02:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=nkhODdqpVEsLaZ0d6p+p8SVYj8qb3Adqm/846R9LTm0=;
        b=bZW/l0+ichJTLRhUW3DR+2b1Rmr5aDvUoD3NWCs6vkDSlZM+ofr9MYe1RXXXUxJYDk
         d5DANCIKDDjMiXV6c6OQYBA2JGPPBRA8sW+TlouVAb8kAg/Pjw7ORYWw1JqQOrM4pfUV
         Kfg88sYjE/NwNtS97mkhxvT4x56IM71MDejvKPwM9dY5XJY1oBR4F8qXCVp1dc4BizFO
         xXUjvKBsjBnMovzrtIaAq7SURPVG8Du746nAkjqk0PP137j2tMqQUn7kDG+aBog6UXp2
         hYRwWpAIq/zxN+ESxxojJjfdksmnagb1jWNDooDbYOTc6zFdibruRrxOdIojk21n1GwU
         vM2w==
Received: by 10.14.198.65 with SMTP id u41mr5510289een.22.1345195993398;
        Fri, 17 Aug 2012 02:33:13 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id 45sm18564368eed.17.2012.08.17.02.33.12
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 02:33:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <7va9xu3kr5.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlHCSlOMOXcepqkAkQat5eTmviMiPLd0YQ5MHTJYAnoC4ymyVjQJcaC7Ws7nUUfEh0bFVas
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203606>

On 16/08/12 16:43, Junio C Hamano wrote:
> Luke Diamand<luke@diamand.org>  writes:
>
>> If I do "git rebase --skip", is there a way to find out the commit SHA
>> that was skipped (other than just parsing the output of the command) ?
>
> There currently isn't, and I do not think it is doable in general
> when the command ever gives control back to the user to futz with
> the history, expecting the user only to fix up the conflict and make
> a single commit (in which case you would want to say "that old
> commit was replayed as this commit with different patch id) or say
> "rebase --skip" (in which case you could record "that old commit was
> manually skipped), but the user can do other things like resetting
> the head to lose commits that have been rebased already, adding new
> commits manually before continuing, etc., all of which will be done
> outside of your control.

All I need is to be able to get the commit *immediately* after the 
failed 'git rebase'. It looks like .git/ORIG_HEAD has exactly what I need.

Thanks,
Luke
