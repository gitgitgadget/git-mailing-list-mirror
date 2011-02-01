From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Tue, 01 Feb 2011 18:25:24 -0500
Message-ID: <4D489664.1020005@gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <201101312244.10047.trast@student.ethz.ch> <4D4875B2.4070008@gmail.com> <201102012339.31684.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 02 00:25:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPbJ-0007Du-L7
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 00:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1BAXZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 18:25:28 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53578 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1BAXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 18:25:27 -0500
Received: by vws16 with SMTP id 16so2614084vws.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:disposition-notification-to:date
         :from:user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=L86n10BOf+Du+/ZlvO1bdLH4Ijf3nI1aQY9itpg8ixk=;
        b=jkj4MqiYjiLrNTqJ4Uink3tEDyq5mhzUunt+jkg60GQhXMuVLPXbFS4O+OeqU1/fvh
         /K/PWATZcc+XWSAZuGvpJsS5UFfAGo/4RNqnKl1NOos3IY+uCet5CoQy6PzGrJ23j+E8
         tJ3YqOlSBxh0GMbydwRwsTSzlmtpCmALva504=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=G4yDtxdUwXEt5gbzG46BxGxnCmys6VY6lhA6FdrUbi45VpT+W5faGa1ruVp9FbZ+at
         hbHaLPmUQRfjP4Tdx1HzZWH0f2gFTAVrqI3I6A2lfID+My1BRi4lpKEyTwMdMsLwmsW/
         qY408CcJncqjQ+4M5anDTJuSnlBIw9lPerwq4=
Received: by 10.220.175.130 with SMTP id ba2mr2168651vcb.24.1296602726744;
        Tue, 01 Feb 2011 15:25:26 -0800 (PST)
Received: from [10.0.1.130] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id e18sm14454379vbm.5.2011.02.01.15.25.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 15:25:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <201102012339.31684.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165879>

On 02/01/2011 05:39 PM, Thomas Rast wrote:
> A Large Angry SCM wrote:
>> On 01/31/2011 04:44 PM, Thomas Rast wrote:
>>>
>>> Since the remote branches in some sense reflect the "last known state"
>>> of the remote, it would make sense to also update them to whatever a
>>> two-argument fetch got.
>>
>> If this is proposing to break:
>>
>> 	get-fetch ${REPO} ${SRC_REF}:${DST_REF}
>>
>> then I am against this since that form _is_ used and *is* plumbing.
>
> You're mixing up the two proposals.  This one is to teach
>
>    git fetch repo foo
>
> to update refs/remotes/repo/foo with the new value (maybe we should
> also have it update in the foo:bar case, but I haven't thought that
> through).
>
> The other one is to forbid 'git pull repo foo:bar' and would not
> change git-fetch at all.
>

I'm not concerned about the pull proposal (I haven't really thought 
about it, yet) but I am concerned that your proposal may break (as in 
change the behavior of) the case I identified above.
