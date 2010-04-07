From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 12:14:36 +0400
Message-ID: <4BBC3EEC.6010702@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com> <4BBB53F5.9010106@op5.se> <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com> <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com> <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E15.9040403@gmail.com> <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Apr 07 10:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzQPq-00062u-HP
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 10:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756304Ab0DGIPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 04:15:09 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:44961 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab0DGIPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 04:15:05 -0400
Received: by bwz1 with SMTP id 1so571181bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=0AVDlX84WJzb16iGOsvcEc53lB64DtngjcT2xbVoEm0=;
        b=l3TomnVs2nBQapmazbbV8aEXimNkiu93dE0bek9F/cAb/LSzbECX04TDl/ytJpyPzl
         i+xQ8at1WzjOrYowkYRhR8hc1X6m9hCT+WDimjq+pgkOd5jMdS5F7wInexqjprsrp+t+
         udGh2M4PWOVrvllcC1Vgyuz5CZFcw7zsgO4ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=D4yk6T9VjqWemr6+1yoAJqWdCgLInwKMxjM3r47GDn40SHMBkvBBzDQhhCSBzqDOz7
         jnH/WMbczlGUxPSXiKQoRZJV7rUmnvjd8glx6LNDK6Gvq/NUCcwi8xcsF5nVNqrzQgv8
         ID8S3HuF3yHg3ys7jKTuu4YhAjdla22Mh+f2I=
Received: by 10.204.134.87 with SMTP id i23mr4932451bkt.125.1270628103610;
        Wed, 07 Apr 2010 01:15:03 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 13sm6700764bwz.7.2010.04.07.01.15.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 01:15:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144204>

Too bad..
Yes, we really have a very large repo with binary files.

So, as far as I understand, the fastest way is to use rsync or smth like 
this instead of "git clone".

P.S. Btw, how can I ask for a feature of incorporating hashes into 
transport stream in trusted environments?

On 04/07/2010 12:00 PM, Ilari Liusvaara wrote:
> On Wed, Apr 07, 2010 at 09:54:29AM +0400, Vitaly Berov wrote:
>    
>> I suspected the security reasons.
>>
>> Ok, we work in trusted environment. How can we turn this behavior off?
>>      
>
> It can't be turned off. Protocol requires client to recompute hashes
> as they are not explicitly available in transport stream (must be inferred
> instead).
>
>    
>>> This being said, you should never have to wait 6 hours for that phase to
>>> complete.  It is typically a matter of minutes if not seconds.
>>>        
> The reasons why it might take 6 hours (offhand from memory):
>
> - Extremely large repo
> - Very large files in repo pushing client into swap.
>
> -Ilari
>
>    
