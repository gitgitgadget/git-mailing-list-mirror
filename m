From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about git-cherry and the rev list it's using
Date: Fri, 13 May 2011 09:02:27 +0200
Message-ID: <BANLkTi=d+gDhgnmOzUDfHhGJP76JuLHJ2Q@mail.gmail.com>
References: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>
	<4DCB826F.5020406@drmicha.warpmail.net>
	<BANLkTi=qRbpBG_PDPjO_TVEe+nWqrFQ28w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 13 09:02:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKmOP-00043Y-0p
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 09:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab1EMHC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 03:02:28 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:46036 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756555Ab1EMHC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 03:02:27 -0400
Received: by pxi16 with SMTP id 16so1508243pxi.4
        for <git@vger.kernel.org>; Fri, 13 May 2011 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gtezfr8eYmbRmXNAnu2qa7lkfwUEtYL19aHjMGX9F8I=;
        b=Ec4lvHt+/bLYcR7TPw+Y6yOCTVpLFtSPMqDNuInjU83F/1nfcZQq6odYkuzDYY4/NM
         Lfpa/uHBM67jhmxA7Q5MQJt17nChL5qQk/EfTpuS2kL5r6Tbf9UCj1r3ZxrBIxdIoy6D
         OWCf4WcSEljhnhU4hCmbGPT0+4MY3mvC/n3+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CgTyfmEote7nYonMb0APvxWSVJldii95oBnXjju+4++GPbSWI5EB8alvQKMybHJckQ
         QdKEtwd5EQ6j4CGC/JNlsByFhIqTjTpiea3pjHK3sdjmERTxtOv1sFb6+wVQfVgvrDzP
         wzBkJlybdc7NjyxsVhdPEJvmdi3ZGZ4QC/Nb0=
Received: by 10.142.136.19 with SMTP id j19mr652691wfd.167.1305270147186; Fri,
 13 May 2011 00:02:27 -0700 (PDT)
Received: by 10.142.77.4 with HTTP; Fri, 13 May 2011 00:02:27 -0700 (PDT)
In-Reply-To: <BANLkTi=qRbpBG_PDPjO_TVEe+nWqrFQ28w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173507>

On Fri, May 13, 2011 at 8:54 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> [ resending to the mailing list too ]
>
> On Thu, May 12, 2011 at 8:47 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Francis Moreau venit, vidit, dixit 11.05.2011 18:11:
>>> Hello,
>>>
>>> I'm using "git cherry old master base" to see if all commits between
>>> master and base have been applied in my 'old' branch.
>>>
>>> So I expect that git cherry is using a list of commits given by : "git
>>> rev-list --no-merges base..master".
>>
>> Not really.
>>
>> For each commit in "--no-merges old..master ^base" (i.e. "--no-merges
>> master ^old ^base"), "git cherry" checks whether there is a patch
>> equivalent commit in "--no-merges master..old", and outputs it with + or -.
>>
>
> oh you're right, I missed the case when old has been merged in master.
>

BTW, can't it be convenient for users if git-cherry also displays the
sha1 of the commits which have been merged upstream (the ones with the
'-' sign) ?

Thanks
-- 
Francis
