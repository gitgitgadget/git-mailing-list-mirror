From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Fri, 11 Nov 2011 23:00:31 +0100
Message-ID: <201111112300.31798.jnareb@gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com> <m3wrb7lzg8.fsf@localhost.localdomain> <7vvcqqr4wg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 23:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROz90-0005my-T7
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 23:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1KKWAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 17:00:12 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51628 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab1KKWAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 17:00:10 -0500
Received: by bke11 with SMTP id 11so3669763bke.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TDLZ2rkNVxrR1ZnNQvyl0kH6D/ZTegPP/Yhtz36wAJQ=;
        b=GGqHEyvJVBS0uBYjzcK3rDWAGO7MqNUjq/x11Ow6CHaw+cef6svumvQ69epS/qAwG3
         lWYGAhOnKYYs2SFDSuOYoI3YzEWK5f0TOn4qUoCSzDPKWpFT0/vJxm77hioI16uMQtRr
         U0bMLW9hHNvxinHAgAcgLzr1krDaYVdZmT0Y8=
Received: by 10.205.139.73 with SMTP id iv9mr4577262bkc.30.1321048809231;
        Fri, 11 Nov 2011 14:00:09 -0800 (PST)
Received: from [192.168.1.13] (abwk57.neoplus.adsl.tpnet.pl. [83.8.234.57])
        by mx.google.com with ESMTPS id m12sm3536466bkg.14.2011.11.11.14.00.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 14:00:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvcqqr4wg.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185291>

On Fri, 11 Nov 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>> 
>>>> Perhaps these 'git remote' commands should be removed in 1.8 then.
>>> 
>>> It is true that it was a long-term goal to deprecate many parts of the
>>> "git remote" script that started as a hack to scratch itches "git fetch"
>>> in the older days did not directly scratch for people, e.g. fetching from
>>> multiple remotes in one go.
>>> 
>>> I do not think 1.7.X series to 1.8 is a big enough jump to remove
>>> duplicated features, though.
>>  
>> I am using "git remote update" to fetch a _subset_ of remotes;
>> does "git fetch" offers such feature already?
> 
> Heh, look at builtin/remote.c::update() and report what you see.  It just
> calls into "git fetch" and let the command fetch either from a single
> repository or from a remote group. "git remote update" is not even aware
> of the remote groups; the expansion is done by "git fetch".
> 
> Whoever added "multiple repositories" feature to "git fetch" in order to
> support "remote update <group>" apparently under-documented it.

Well, it is documented in git-fetch(1), though in slightly piecemeal
fashion.

One difference is that "git remote update" defaults to "default" group
if it is defined, and to "--all" if it isn't.  With "git fetch --multiple"
you have to specify it explicitly ("git fetch --multiple" is a no-op,
I think).

-- 
Jakub Narebski
Poland
