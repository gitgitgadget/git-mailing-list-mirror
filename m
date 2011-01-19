From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: filter-branch --env-filter GIT_AUTHOR_DATE
Date: Wed, 19 Jan 2011 15:30:55 +0100
Message-ID: <AANLkTimiG=Tr=rfLtE54pJvN8G05mx=GGsLDN4AbzLO+@mail.gmail.com>
References: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com>
 <4D368C49.3080105@viscovery.net> <AANLkTi=TAhYeWbyocag2myBXA2TfH7_r=hmam51YKbhm@mail.gmail.com>
 <4D36BDD9.4050108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 19 15:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfZ4V-0005XA-GK
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 15:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab1ASObh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 09:31:37 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49866 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab1ASObg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 09:31:36 -0500
Received: by pwj3 with SMTP id 3so161755pwj.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Y6VdSY/ucaGJc3xrBU4TMzDNyfQSmEmLfRb+pgBMyjQ=;
        b=XiHpGVK5V8FOtxdEMYgRxSteZzuqrqtnrTzIwnersRKx9iAfIIN3FE7Er9PvdrRFQO
         uuCtafCZ+VqGBdQTE/VnzpV8POZX7kwrh4KIn95+4JTXMIpJd8v6VAPV6pdCQ4DGaJ2A
         UX+GoRSGBpk/0PKd9/2U7poq6ZisKGN4ECWqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U3LcBw/910+YFa23n3mGHeSP+b92XQ9rFK1kobi/A9aUV0/0xniLE1UTwdjywiDJBg
         whVyAzHHg0GAd3EGEGy3+xBPFpg67MJMakgGlb3BiXMBb2yXOk/CdLx0yw/hqQN0RFpG
         pwPeyF+l9s2mFy1eRLYbWENTV894j6pFevuGM=
Received: by 10.142.240.18 with SMTP id n18mr673462wfh.421.1295447495931; Wed,
 19 Jan 2011 06:31:35 -0800 (PST)
Received: by 10.142.76.11 with HTTP; Wed, 19 Jan 2011 06:30:55 -0800 (PST)
In-Reply-To: <4D36BDD9.4050108@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165270>

On Wed, Jan 19, 2011 at 11:32 AM, Johannes Sixt wrote:
> Am 1/19/2011 11:08, schrieb Tuncer Ayaz:
>> On Wed, Jan 19, 2011 at 8:01 AM, Johannes Sixt wrote:
>>> Am 1/18/2011 17:43, schrieb Tuncer Ayaz:
>>>> To fix invalid timezone info in a repo I ran
>>>> git filter-branch --env-filter '
>>>>   GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0000/-0800/`' HEAD
>>>>
>>>> This fixed the invalid entries but the new timezone is -0700
>>>> instead of -0800. Is this expected?
>>>
>>> Parse error. You fixed it, but it is not fixed? So what?
>>
>> Fixed because it is not +0000 anymore. Surprised because the new
>> timezone is -0700 and not -0800.
>>
>>> What do you mean by "the new timezone is"? Do you mean "...is reported
>>> as"? If so, reported by which tools?
>>
>> git log
>> git cat-file $REV
>
> $ git filter-branch -f --env-filter 'echo; echo "$GIT_AUTHOR_DATE";
> GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0100/-0800/`;
> echo "$GIT_AUTHOR_DATE"' -- -1
> Rewrite 6fb5ec91707a4433628eae5d9d68153ca8b819fe (1/1)
> 1292311163 +0100
> 1292311163 -0800
>
> Ref 'refs/heads/master' was rewritten
> $ git cat-file commit HEAD
> tree 43554f2216bbcfc96385db0641ae212409f26f21
> parent 942f54790453970cfffbfedf29e47ac27b9ba995
> author Johannes Sixt <j.sixt@viscovery.net> 1292311163 -0800
> committer Johannes Sixt <j.sixt@viscovery.net> 1292311163 +0100
>
> master
>
> *Shrug*

Cannot reproduce anymore. Works as expected.

Successfully rewrote all GIT_AUTHOR_DATE timezone entries:
  -0700 -> -0800
  -0800 -> +0000
  +0000 -> -0800

git version 1.7.4.rc2.3.g60a2e
