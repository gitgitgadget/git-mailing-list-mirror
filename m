From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 21:59:17 -0500
Message-ID: <4D2BC785.3090304@gmail.com>
References: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch> <7v62tw7kx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 03:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcUSG-0005xI-VG
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 03:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab1AKC7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 21:59:21 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34438 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab1AKC7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 21:59:20 -0500
Received: by qyj19 with SMTP id 19so2402545qyj.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 18:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fCV8+bahRaBqg/ji8pJKsTYsPzsP2Xpu9PTHoTJbl3s=;
        b=iIHtSDC7jp6SK9erSWeX2if8nwWpI8+ikuK4AA6yuSFe8EPd4qKkV/hP5D83vhv0Rk
         w7S00cO5cehq8EjE55POSefNnFDAL0jGPyJOezcQQQxXMXdYj9yHVGMumnMGA3ZKjaKw
         aiafwI0HINOmdk4KYkheFnED4OUQLeE36fTjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=TG8yXqUoJL9dLdSNJX10wEZxlkm+rO/4BHsKLK/R7dR5sikR01Owja5BG1e11kp+JB
         QnncSHxkK8ybYR9uGjTBupqFweMxKo0tiA8ie2uLBLBx2cz4k+xOEV7KKRVQZ9gSMHwX
         U0SKru2w0bbZXuwSUIne48Qaw/DeiGKNoUk2U=
Received: by 10.224.41.8 with SMTP id m8mr27771960qae.161.1294714759405;
        Mon, 10 Jan 2011 18:59:19 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-117-93.washdc.fios.verizon.net [173.79.117.93])
        by mx.google.com with ESMTPS id nb15sm17048307qcb.2.2011.01.10.18.59.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 18:59:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7v62tw7kx6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164907>

On 01/10/2011 12:01 PM, Junio C Hamano wrote:
> Thomas Rast<trast@student.ethz.ch>  writes:
>
>> The function resolve_relative_url was not prepared to deal with an
>> scp-style origin 'user@host:path' in the case where 'path' is only a
>> single component.  Fix this by extending the logic that strips one
>> path component from the $remoteurl.
>>
>> Also add tests for both styles of URLs.
>>
>> Noticed-by: Jeffrey Phillips Freeman<jeffrey.freeman@syncleus.com>
>> Signed-off-by: Thomas Rast<trast@student.ethz.ch>
>> ---
>>
>> If Mark agrees with the fix, I think this should go in before 1.7.4
>> since it's a pretty annoying bug.
> Seems obvious to me from a cursory look; thanks.
>

Looks ok to me. (FWIW, note that the original function handles 
user@host:~/path just fine :^).


Mark
