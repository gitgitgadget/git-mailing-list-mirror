From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Commit/merge messages for binary files
Date: Fri, 18 Feb 2011 22:42:42 +0100
Message-ID: <4D5EE7D2.5060703@gmail.com>
References: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com>	<vpq39nlsb3r.fsf@bauges.imag.fr> <4D5ED6F2.8030008@gmail.com> <vpqwrkx9h2z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 18 22:43:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqY6T-0006iT-DN
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 22:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1BRVmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 16:42:53 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55430 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab1BRVmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 16:42:52 -0500
Received: by fxm20 with SMTP id 20so4261361fxm.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XeKkJngiqtKOU//iNd5sF4Uczta+tvvweqJR7THwYTg=;
        b=BznG+TEHf6zzTCG+7OAAdxdW1fZYBlAoRx3W+nVIMQWc4xGZRbWmiVMVKKg5yJdiAR
         ZrEbi9+Q7D0XGiP3FrNYCtaUHHI4LsEB8GZZw/Pbi6FKw9hkWJYOsw4jzAQ1WF9FWYW0
         swy9vfZimA7/IpHIVXGiW2+cUmqwh9yl/xzhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Jp04aCu5HXNX48PwzXTcMWZQdq6+bny8rGQmwvzaR0qyhmtr1oR2A2tDsl+ZRITHzh
         MpqbtOOWXG+m6dh7Bvbm4OcTKuQ19Z8aXX3inAR87YcH5Phg4vWV0YZdbrSU0PGfFgBp
         wQNPT8KdRoiclOdDWEo0sGlo/HZ+rfovBGMgE=
Received: by 10.223.72.197 with SMTP id n5mr1628597faj.8.1298065370820;
        Fri, 18 Feb 2011 13:42:50 -0800 (PST)
Received: from [192.168.1.101] (akw69.neoplus.adsl.tpnet.pl [83.26.26.69])
        by mx.google.com with ESMTPS id n7sm1318180fam.35.2011.02.18.13.42.49
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 13:42:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <vpqwrkx9h2z.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167231>

W dniu 18.02.2011 22:19, Matthieu Moy pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> W dniu 18.02.2011 14:53, Matthieu Moy pisze:
>>> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>>>
>>>> Hi,
>>>>
>>>> there's a different output when committing change and when merging
>>>> change for a binary file.
>>>> Do the insertions/deletions have any meaning for binary files?
>>>
>>> No. They're inserted/deleted *lines*, and that wouldn't make sense for
>>> binary files.
>>
>> So it's a bug?
> 
> I don't see any bug. There were no insertion/deletion in text files,
> hence you see 0 for both.

Maybe I wasn't clear. Both the commit and the merge was for the same binary
file.

In case of commit there were non-zero insertions/deletions. 
See example below - notice both update binary file blob.o:

$ git commit -m Updated
[topic 5da30ce] Updated
 1 files changed, 8 insertions(+), 103 deletions(-)
 rewrite blob.o (100%)

$ git merge topic
Updating 75ab259..5da30ce
Fast-forward
 blob.o |  Bin 25920 -> 4364 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)


Hope that helps,

-- 
Piotr Krukowiecki
