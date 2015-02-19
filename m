From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFD/PATCH] stash: introduce checkpoint mode
Date: Thu, 19 Feb 2015 15:43:16 -0800
Message-ID: <04CB0145-FE99-46EB-8430-069E05DF31EB@gmail.com>
References: <54E5C27E.9060109@drmicha.warpmail.net> <dbd1aae0508bd72dc3b21fabda4c420eef487720.1424349039.git.git@drmicha.warpmail.net> <8AAD6FE6-75C1-4BA2-8667-4DF8BF6B1EE4@gmail.com> <xmqq7fvd23mw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Armin Ronacher <armin.ronacher@active-4.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 00:43:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOake-0007AN-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 00:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbbBSXnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 18:43:20 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34754 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbbBSXnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 18:43:20 -0500
Received: by pabrd3 with SMTP id rd3so3484639pab.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=AsSdjdxp1iPonB10g5hebNMx6Kzi2tgIJAKtkeOmSYo=;
        b=AMRnfjglLa3J6/9dltHDC7xDaW4ozLwRhX37DSloFBkm6ZjgJZbX+Yf8IOKffppsl0
         LBkEjW8T/E0Ep9vF56ibeHN3LgUL4vJHGksLJXn8IoXclg89GrpzgGDq6LaTD9wmvE+G
         t0W3p307x/7+5w8lOwGj71e2Y5tUOJkTpfn0m1W7LJ+zEDOgeF3+SaCFxOfZzm1V0IAr
         p9kG9kbJqO1G33V1PGMb4ts6b7/u7o5DIEyC/VR/AirnStg6kC13tsnx8BAZQizEhCAQ
         H/9YYvchQngVQVgRaEFOOtetXJFW/m73trWtKNL5JZSA1pXdO+5lxkgq9I2EGUp5pbja
         UETg==
X-Received: by 10.66.235.36 with SMTP id uj4mr11674035pac.123.1424389399654;
        Thu, 19 Feb 2015 15:43:19 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id om9sm24831484pbb.34.2015.02.19.15.43.18
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Feb 2015 15:43:19 -0800 (PST)
In-Reply-To: <xmqq7fvd23mw.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264121>

On Feb 19, 2015, at 09:49, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> What about a shortcut to "reset-and-apply" as well?
>>
>> I have often been frustrated when "git stash apply" refuses to work
>> because I have changes that would be stepped on and there's no -- 
>> force
>> option like git checkout has.  I end up doing a reset just so I can
>> run stash apply.
>
> Doesn't that cut both ways, though?
>
> A single step short-cut, done in any way other than a more explicit
> way such as "git reset --hard && git stash apply" (e.g. "git stash
> reset-and-apply" or "git stash apply --force") that makes it crystal
> clear that the user _is_ discarding, has a risk of encouraging users
> to form a dangerous habit of invoking the short-cut without thinking
> and leading to "oops, I didn't mean that!".

Does that reasoning not also apply to the plethora of commands that  
take "--force" already?

I didn't check them all, but tag, checkout, push and branch  
immediately come to mind.  Why is it okay for all those other commands  
to have a --force mode, but not git stash?
