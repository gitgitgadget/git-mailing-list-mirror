From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 11:32:12 +0300
Message-ID: <4A0A858C.2070808@gmail.com>
References: <4A0A6BD1.7050907@gmail.com>	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>	 <4A0A777E.7080506@gmail.com>	 <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>	 <4A0A7BA1.4030500@gmail.com> <81b0412b0905130115v78b5065bjdeb3f349072eed4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49tV-0001h4-Co
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbZEMIci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756070AbZEMIch
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:32:37 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:37191 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120AbZEMIcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:32:36 -0400
Received: by qyk39 with SMTP id 39so956563qyk.33
        for <git@vger.kernel.org>; Wed, 13 May 2009 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WoO9AarMOFX//Q5qo6gwvm7Doid3b8VTHEPFgEQ2/A4=;
        b=pGiC+k8HHyB8ACqEOQF27wnxXNwxQxWt2QE3ioM4RFvPhQQ0pBYscoFXjbROhYvENH
         L8940bEm6M+SLdPFG+hSTCxFLB6dcAe8C7HQEUDi8kaVLLtVZpzPDydx/09M/aABbWBF
         yaeGB5D39poK2pasFAJw1di4oxWmfJd/Aea4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QfWWOChMLPVko0/7cdpNuHzBpRCR1ZtyrTYOq48HT6hvwsEUmbLZeeeGNPEhPCecp+
         0Njn3Nhut4wVMD1sMTbhNuICFIxvu2dZ7wU7jKjrTvgSt9fKhVWTQS8M19w+CbxHnpPK
         Ucuf17R9Jp//Jr1TTxtayYXUkprmBV5HEg0RE=
Received: by 10.220.100.194 with SMTP id z2mr530085vcn.68.1242203556278;
        Wed, 13 May 2009 01:32:36 -0700 (PDT)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id 9sm2838051yxs.33.2009.05.13.01.32.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 01:32:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <81b0412b0905130115v78b5065bjdeb3f349072eed4c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119006>



Alex Riesen wrote:
> 2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>   
>> tried git rebase, this is what i get:
>> git rebase -i upstream master
>> fatal: Needed a single revision
>> Invalid base
>>     
>
> $ git checkout my-old-master-based-on-old-upstream
> $ git rebase -i old-upstream
>   
so i need to create an 'old-upstream' branch first, that is based on the 
tip of the old-upstream remote, right? how? (thanks for the patience)
>   
>>> Ok, that simplifies everything. Just cherry-pick (see "git cherry-pick")
>>> your commits on new upstream. You might find it easiest if you cherry-pick
>>> them on commits in new upstream which correspond the old-upstream
>>> exactly.
>>>       
>> can you explain a bit more how to work with git cherry-pick? if i understand
>> correctly, i need to write down my commits, switch to the new upstream tip
>> ('git checkout upstream master'?) and then call git cherry-pick for each of
>> my commits.
>>     
>
> $ gitk old-upstream-with-my-changes-on-top &
> $ git checkout -b my-new-master-on-top-of-new-upstream  new-upstream
> ...select a commit in gitk...
> $ git cherry-pick <paste-the-selected-commit-here> # hit Enter
>
> repeat until you run out of commits you want to have on top of the new upstream.
>   
