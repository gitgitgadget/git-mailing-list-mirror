From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Fri, 28 Nov 2014 10:49:03 -0500
Message-ID: <5478996F.5050207@gmail.com>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com> <20141125034424.GA19161@peff.net> <xmqqtx1nub9e.fsf@gitster.dls.corp.google.com> <20141125050331.GB20805@peff.net> <547737C8.7070609@gmail.com> <20141128051805.GA19258@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 28 16:49:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuNnF-00060J-8H
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 16:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbaK1PtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 10:49:09 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36073 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbaK1PtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 10:49:07 -0500
Received: by mail-qa0-f46.google.com with SMTP id u7so4596739qaz.5
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oDUOwTRmdxd96G+YYpaXGYC3UtFPuoqNYln9mE7Gqq4=;
        b=Gbc56DJucULsPk2JmGssyuUsIji4tib22ihWUyJlJWSQQTQgMWmVAHHAVNfJbYSqW7
         pncF3910RATJh6QvJH/O/t+Tk1P0USD7qjWEwYpJAu63eDhxWaCizGwtTQOWyHEZeIkD
         YJLSECucjIEYS0SQcekbXEIq9LuNWVZ4rCUWC7We1hZwgbZ68InFHNs6yxdQ7IIY47cI
         jM7RtTaekp2R4/F86R/CE8URkBjhAQzOnMHSVVK6k3T22jUHOOeE8oFqioqTWLMGQO1U
         5XO9gZAtXT8dIvhXUsgpahF/RPUloow7vC5W0dDSqWOIPjCrYWA1oVhiVR5GVOI0WiKR
         0ArQ==
X-Received: by 10.140.92.2 with SMTP id a2mr62321198qge.51.1417189746360;
        Fri, 28 Nov 2014 07:49:06 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-126-100.washdc.fios.verizon.net. [173.79.126.100])
        by mx.google.com with ESMTPSA id v16sm9507343qaw.30.2014.11.28.07.49.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Nov 2014 07:49:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141128051805.GA19258@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260368>

On 11/28/2014 12:18 AM, Jeff King wrote:
> On Thu, Nov 27, 2014 at 09:40:08AM -0500, Mark Levedahl wrote:
>
>>> Then when you add new arguments, the hook has to search through the
>>> parameters looking for one that matches, rather than just checking "$1"
>>> for "amend" (and "$2" for the new option, and so on). As long as the set
>>> of options remains relatively small, I think that is preferable.
>>>
>>> We could also just pass them through the environment, which gives nice
>>> named parameters.
>>>
>> See http://comments.gmane.org/gmane.comp.version-control.git/148479 for an
>> earlier conversation on this exact topic. Also, see
>> http://permalink.gmane.org/gmane.comp.version-control.git/148480 for a
>> similar change in git-gui.
> Thanks for the links; I had no recollection of that thread.
> Unsurprisingly, I like the "HEAD"/"HEAD~1" suggestion. That "peff" guy
> seems really clever (and handsome, too, I'll bet).
>
> I'd still be OK with any of the suggestions given in this thread,
> though.
>
> -Peff
> ars

Apparently our combined handsome-foo was insufficient to get this 
accepted way back when, hopefully the current submitter has more :^)

In any event, I've carried the patches using HEAD/HEAD~1 in my tree for 
the last 4+ years, have a widely used pre-commit script that depends 
upon those. So, I personally would be very happy to see this finally 
show up in Junio's tree, would prefer HEAD/HEAD~1 but can adapt to whatever.

Mark
