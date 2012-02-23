From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] cherry-pick -x: always insert an empty line
Date: Thu, 23 Feb 2012 10:38:14 +0100
Message-ID: <4F460906.8030609@gmail.com>
References: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch> <7vhaynp605.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Beat Bolli <bbolli@ewanet.ch>, git@vger.kernel.org,
	Eric Raible <raible@nextest.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0V89-0004Mk-RV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab2BWJiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:38:20 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40292 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab2BWJiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:38:18 -0500
Received: by bkcjm19 with SMTP id jm19so836860bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 01:38:16 -0800 (PST)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 10.204.152.208 as permitted sender) client-ip=10.204.152.208;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sschuberth@gmail.com designates 10.204.152.208 as permitted sender) smtp.mail=sschuberth@gmail.com; dkim=pass header.i=sschuberth@gmail.com
Received: from mr.google.com ([10.204.152.208])
        by 10.204.152.208 with SMTP id h16mr350849bkw.6.1329989896896 (num_hops = 1);
        Thu, 23 Feb 2012 01:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=JfZkoK/v/XJGko7vp1umlZX8kukEpacc1sAMSMNzvig=;
        b=AhjM7mK9+QZ8ShmpDqNw2lNAq/GTuVuPHSnRkGISzZSgvb6LV+R/Vq3MVZCBhy5gJ5
         n5xlmCxZiE5oSx1Lnj1NWyQIdU6ofcS39/R57gcDw7X8qo3f0EyvmRJcY64o2eZmLWMI
         G7jx+c9UsRB8BWFfiz8FbD4tGjH2UZranruTU=
Received: by 10.204.152.208 with SMTP id h16mr297931bkw.6.1329989896805;
        Thu, 23 Feb 2012 01:38:16 -0800 (PST)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id u8sm1471145bkg.13.2012.02.23.01.38.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 01:38:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vhaynp605.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191337>

On 19.02.2012 09:44, Junio C Hamano wrote:

> If we cherry pick your commit somewhere else with "-x -s", the resulting
> commit log message would end like this:
>
>      Aside from that, even with a non-trivial commit the generated note
>      "(cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)"
>      seems abrupt when appended directly.
>
>      Cc: Eric Raible<raible@nextest.com>
>      Signed-off-by: Beat Bolli<bbolli@ewanet.ch>
>
>      (cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)
>      Signed-off-by: Frotz Xyzzy<nitfol@example.xz>
>
> which clearly is worse-looking with the extra LF you added in this patch.

Clearly? I would not say so, on the contrary. When using -s together 
with -x, I'd interpret this as signing off the process of cherry-picking 
itself, and as such, visually grouping the additional "signed-off" with 
the "cherry picked from" makes sense to me.

-- 
Sebastian Schuberth
