From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Repo with only one file
Date: Thu, 8 Aug 2013 17:11:34 -0400
Message-ID: <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
 <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7XV1-00073e-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966651Ab3HHVL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:11:56 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:63124 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966622Ab3HHVLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:11:55 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so3454507veb.22
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X2zKbAoozVpQF9LFiiIq6V/FqMVI0V8NGzmzboR3K+0=;
        b=yvfijYnYSIjJrxznv5rlJc0j7JGWG4vpQmihLNxdTwGXEYbTEcT7bB/mZUYt8pms3L
         WAFBNHcl+N1ECqTQFqQ2Ub+VbvBPC9baFJFjHLNXLNAxUFot+82Vrvpx+yExyg4JCppK
         1IDQYjxAYLob14Ywf+6WHY8EM1exoSeS5ZGOHuWAOlt5TpNW6hAI2mZzzZSjXNFI72Wi
         Op6bTbDALfa/PLY89nAua699rSYgmOYOmLaHKzlbYbKoLCu9yOpZkH0QylqY2H+oMkM+
         yFBUBYzEgYaWM7NUqahT0BwZWzq2TlZWka/yysv+c1UR6Tyxk3NVBa8iKVCEUi0v1gRM
         Rqnw==
X-Received: by 10.58.19.162 with SMTP id g2mr4347866vee.12.1375996314887; Thu,
 08 Aug 2013 14:11:54 -0700 (PDT)
Received: by 10.58.220.72 with HTTP; Thu, 8 Aug 2013 14:11:34 -0700 (PDT)
In-Reply-To: <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231933>

On Wed, Aug 7, 2013 at 5:07 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
> On Wed, Aug 7, 2013 at 6:43 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
>>> these scripts and I'd like to keep the commit history.
>>>
>>> Ok, so:
>>> % find -type f ! -iname "webban.pl" | while read f; do git
>>> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
>>> HEAD ; done
>>>
>>> Which basically did it. But, I've got this one commit that seems to be
>>> orphaned - it doesn't change any files.
>>
>> Try this:
>>
>>   git filter-branch HEAD -- webban.pl
>>
>
>  % git filter-branch HEAD -- webban.pl
> Cannot create a new backup.
> A previous backup already exists in refs/original/
> Force overwriting the backup with -f
>  % git filter-branch -f HEAD -- webban.pl
> Rewrite 1e04b18c256c996312f167be808733bcc755f1e3 (9/9)
> WARNING: Ref 'refs/heads/master' is unchanged

I think you can ignore the warning.  Maybe you want to create a new
branch which only has this file in it now.

   $ git checkout -b webban

Phil
