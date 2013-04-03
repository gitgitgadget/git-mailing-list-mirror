From: Andreas Ericsson <ae@op5.se>
Subject: Re: cd
Date: Thu, 04 Apr 2013 00:55:49 +0200
Message-ID: <515CB375.9010104@op5.se>
References: <1365000547327-7581484.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jpinheiro <7jpinheiro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 00:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNWbP-0005Pc-U8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 00:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760034Ab3DCWzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 18:55:54 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33568 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758730Ab3DCWzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 18:55:54 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so2090469lbi.23
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 15:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=G+EBkxMPqG2XwbEOGeC167s//J6qUxqrG9N59AxXs9o=;
        b=BKZmq+gJVqI4C3YGTy4HMjpM6x/nrukLX9dIR6gIt/hhOllFXyWjrlmar7QRiGRQBT
         BZPBRoIoSg6Dp81uZ68lVWrDfAgWs+XE+E5WnwB7/0mwHu7pqQHe3foUBbuI4DSCwFMC
         mgMtPpKyw4pugxspICO2h7hvtSmLu3CFKeECNGg0v+R3ogfm+Kf2rDiKiywUA6w/MEJb
         JDHqVCrh2ZH/qYUZ0BNu5px24PIpbmIJr5jlcyleFBplHc6t2ub/3qskkVgtakroUcni
         g0l7zN5y3I7M5MJP8tGQBoEQs856Cd3T/TmImeiUBAmGKZ8RUUDOZCtEhUXPcVZw2bl/
         Tw+Q==
X-Received: by 10.112.42.162 with SMTP id p2mr2023086lbl.103.1365029752737;
        Wed, 03 Apr 2013 15:55:52 -0700 (PDT)
Received: from [192.168.234.19] (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id pk1sm3098083lab.0.2013.04.03.15.55.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Apr 2013 15:55:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <1365000547327-7581484.post@n2.nabble.com>
X-Gm-Message-State: ALoCoQkt77sYIGQPGvcUQt90f6N+d+MaumgTwZlf3rOSUSyf0lMdEDw4/KMeH0YrCKx8FOBnEtKU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219977>

On 04/03/2013 04:49 PM, jpinheiro wrote:
> Hi all,
>
> We are students from Universidade do Minho in Portugal, and we are using git
> in project as a case study.
> While experimenting with git we found an unexpected behavior with git rm.
> Here is a trace of the unexpected behavior:
>
> $ git init
> $ mkdir D
> $ echo "Hi" > D/F
> $ git add D/F
> $ rm -r D
> $ echo "Hey" > D
> $ git rm D/F
> warning: 'D/F': Not a directory
> rm 'D/F'
> fatal: git rm: 'D/F': Not a directory
>
>
> If the file D created with last echo did not exist or was named differently
> then no error would occur as expected. For example:
>
> $ git init
> $ mkdir D
> $ echo "Hi" > D/F
> $ git add D/F
> $ rm -r D
> $ echo "Hey" > F
> $ git rm D/F
>
> This works as expected, and the only difference is the name of the file of
> the last echo.
> Is this the expected behavior of git rm?
>

Yes. The only difference between 'git rm' and 'rm' is that git rm also
removes the file from its index and prepares to commit a version without
it. From git's point of view, it's not an error if the file doesn't
exist. It *is* an error if the directory where the file should reside
suddenly no longer a directory though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
