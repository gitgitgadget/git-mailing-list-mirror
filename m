From: David Aguilar <davvid@gmail.com>
Subject: Re: Move git-stash from one machine (or working copy) to another
Date: Sat, 22 Jan 2011 18:05:20 -0800
Message-ID: <1E3784B5-76A2-4071-989D-46E271BB1BAC@gmail.com>
References: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com> <7vfwsmp2op.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Patrick Doyle <wpdster@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 23 03:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgpKk-0007pv-Hs
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 03:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab1AWCFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 21:05:33 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60548 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1AWCFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 21:05:32 -0500
Received: by pzk35 with SMTP id 35so499328pzk.19
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 18:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:message-id:from:to:in-reply-to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date:cc;
        bh=/+pXks7qIaT9zvgvx4pHm0l5HMgXv/6BkohVwO2lnoY=;
        b=AsFQKSLginSKFmM+POQIkEs2pUEiyB8SlDARnGRBEyGgl+QnTexclHRqc0dUxb0yWF
         irHsZdjUJnCtcIht9VDy1zlDchDyTI/qiwxyMNY87jVY0+vqsIdZOQMtWVt29WtmnAEU
         PpNU2bArb+8hTZOnpKicSzz+hBZX6kFA4oVUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=lxMFFAbCBUQ4S/VgcXA31EFKRFUNSum3GbuLbNX6aFjfweJG5irDllKboPIp+K9Tsr
         1M2fFVa5Jf0q5xcuLvhhwbSFNcmZLU0SSDwxSFAZyRMCW91chA6ZKoC+8q8kn+f8DOas
         voXrXb3EaoZtF9Q7pLhx7mwV+fvGecejfDC1A=
Received: by 10.142.144.6 with SMTP id r6mr2264263wfd.64.1295748332363;
        Sat, 22 Jan 2011 18:05:32 -0800 (PST)
Received: from [10.8.99.217] ([166.205.138.78])
        by mx.google.com with ESMTPS id y42sm15115208wfd.10.2011.01.22.18.05.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Jan 2011 18:05:30 -0800 (PST)
In-Reply-To: <7vfwsmp2op.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165418>

On Jan 21, 2011, at 9:49 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Patrick Doyle <wpdster@gmail.com> writes:
>
>> Is there an easy way to move work in progress from one machine to  
>> another?
>>
>> One way to do it might be something like this:
>>
>> machine1$ git checkout -b movewip
>> machine1$ git add .
>> machine1$ git commit -m "Moving work in progress"
>> machine1$ git push origin movewip:movewip
>>
>> machine2$ git fetch origin movewip:movewip:
>> machine2$ git checkout movewip
>> machine2$ git reset HEAD^
>> machine2$ git stash
>> machine2$ git checkout master
>> machine2$ git stash pop
>>
>> # go through and delete movewip branches on machine1, machine2, and
>> the origin server
>>
>> Except for some possible typos, this seems like it would work, but
>> seems to be awfully clumsy.  Is there a more elegant way to  
>> accomplish
>> this?
>
> If your two machines can talk directly with each other (which seems  
> to be
> the case from your "take that with me (somehow) to machine2"), you  
> don't
> have to push and fetch through the origin.

This won't handle all cases, but it should do the trick 80%+ of the  
time.

% git diff > foo.patch

(on other machine)
% git apply foo.patch

-- 
         David
