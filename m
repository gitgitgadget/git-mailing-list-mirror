From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 12:12:22 -0400
Message-ID: <4A61F466.3080105@gmail.com>
References: <4A611CE1.3080709@pobox.com>	 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>	 <4A6176E6.4060708@pobox.com>	 <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>	 <20090718104631.GA27307@coredump.intra.peff.net>	 <9b18b3110907180355s5bf08f8did180caa0c55b3389@mail.gmail.com>	 <20090718105855.GA29567@coredump.intra.peff.net> <9b18b3110907180420n67ec7fa1q4a0df2047f37435e@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael G Schwern <schwern@pobox.com>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 18:12:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSCWi-0001Uz-Vu
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 18:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZGRQMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 12:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbZGRQMf
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 12:12:35 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:36971 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZGRQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 12:12:35 -0400
Received: by yxe14 with SMTP id 14so2488718yxe.33
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iAdTMGigwHRwBXlA+Sj36RSAJoxme2FZRELjhw76N1Y=;
        b=ViJyIPHghChB6SydAe8a4N1BJwfRkp/wFvGV/L6+3UYao0ls1bw/zHsXxt8xgeQ5Jd
         cRyWB/KSh3+JdKu0QhvUBrUAxhkMnrnlZYurrW3UtW1YTjhwPAaO2VQgtWRnFSxpjTh1
         Qk3xzVZms1vgKET2n3KwoGsR+3z6ibtqMCG3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=uUP3SNTpJ6MMIxlHeDV5PhDjBra7+6rxO9eDIYpjIi0E2TyRwvwZHYcxqOUrxHUzF2
         NnYxkqqXUNChPHv0Ly1Y4H/yMmj1pL5zMfakLipcFGTA0alH/El0YiUdVDv1zoN/BBdb
         RIVqXlx6PxoZNTgGrDgk4dV3qp0LpVfmWYR08=
Received: by 10.100.107.8 with SMTP id f8mr3275411anc.197.1247933548127;
        Sat, 18 Jul 2009 09:12:28 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id c28sm97625anc.9.2009.07.18.09.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 09:12:27 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <9b18b3110907180420n67ec7fa1q4a0df2047f37435e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123526>

demerphq wrote:
> 2009/7/18 Jeff King <peff@peff.net>:
>> On Sat, Jul 18, 2009 at 12:55:26PM +0200, demerphq wrote:
>>
>>>> The silentness makes it harder to diagnose problems, but even with a
>>>> warning, we can break things by creating new commands. If you have an
>>>> alias "foo" and we ship "git-foo" in a newer version of git, your alias
>>>> will just stop working.
>>> That was my point. At least if there were warnings about this the risk
>>> would be mitigated.
>> I don't see how it's mitigated. You don't get any warning until _after_
>> things are broken. So yes, it may help you diagnose the breakage, but
>> presumably the fact that the command is doing something completely
>> different would also alert you to the breakage.
>>
>> The real problem comes from scripted use, where you don't necessarily
>> have a user reading warnings on stderr, or notice that some totally
>> bogus code is being run (especially if said code happens not to produce
>> a non-zero exit code).
>>
>> But perhaps that's what you meant, and I'm just nitpicking your
>> language.
> 
> I think we are more or less in agreement, except maybe that i think
> the situation would be marginally better if git detected this.
> 
> :-)
> 
> Seems an awkward position actually. Maybe a switch like
> --ignore-command-aliases which would be used by all internal commands
> when they expect to find another internal command would resolve it.
> Then aliases of internal commands to control default switches could
> actually be allowed to work, and there would not be the future
> compatibility trap that there seems to be now.

The real solution is to (re)move the aliases from the git name-space.
