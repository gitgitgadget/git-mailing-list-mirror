From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: please show tags file history browsing
Date: Sun, 12 Sep 2010 17:19:31 +0200
Message-ID: <201009121719.32390.jnareb@gmail.com>
References: <000001cb51be$ed214dd0$c763e970$@se> <201009121219.58191.jnareb@gmail.com> <001101cb527c$041a0eb0$0c4e2c10$@se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tjernlund" <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Sun Sep 12 17:19:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuoLO-0004hm-Hj
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 17:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab0ILPTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 11:19:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56954 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0ILPTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 11:19:37 -0400
Received: by fxm16 with SMTP id 16so2697142fxm.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MP7yJMOqFo1+VrnXxw7xpkkobucMwJx7bqiEY7L784Y=;
        b=xshGahPuSvjrc7I9qopYIfSaBuBOc9MA0CYuE8fxZTgBi1P/EVF38U1GZEX72eOf0L
         c3eMBGk/34yQhdOMxtQAoUYILzVfqpNVi9BSfvTFYKx4vhXGWNEN5b4vMsgBuVa3RvTm
         PhMKDJ4XLbQCvrhZtMehmSfKwKyia88PoIdV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dNWRPx1OFvlUXDn+XvOG/zyqdBjWt8xRAkejVwgJ4aXU0lu2szuhymzQFornPqLgPy
         LfdmuA/qavYxvQiIGU2ONTEypGe1/IYUlmMKHlnO8u+cSQZTstAn2za4DzfATkTql5yo
         rVdDvhubm+/WABzif/y6VzI17sndqNllei6KY=
Received: by 10.223.119.203 with SMTP id a11mr2318845far.86.1284304775926;
        Sun, 12 Sep 2010 08:19:35 -0700 (PDT)
Received: from [192.168.1.13] (abwi198.neoplus.adsl.tpnet.pl [83.8.232.198])
        by mx.google.com with ESMTPS id k25sm2358462fac.41.2010.09.12.08.19.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 08:19:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <001101cb527c$041a0eb0$0c4e2c10$@se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156035>

On Sun, 12 Sep 2010, Tjernlund wrote:
>> -----Original Message-----
>> From: Jakub Narebski [mailto:jnareb@gmail.com]
>> On Sun, 12 Sep 2010, Tjernlund wrote:
>>>> -----Original Message-----
>>>> From: Jakub Narebski [mailto:jnareb@gmail.com]
>>>>
>>>> "Tjernlund" <tjernlund@tjernlund.se> writes:
>>>>
>>>>> I would really like to see where the tags are when browsing
>>>>> file or directory history in gitweb. Would that be possible?
>> 
>>>> While it probably be possible to show tags in 'history' view, it would
>>>> be not easy.  The problem is that 'history' view shows only commits
>>>> that touch specified file or directory, and tagged commits usually do
>>>> not touch those files (at least if one is using "bump version number"
>>>> commits to tag them).
>>>>
>>>> So you would have:
>>>> 1. Design where to show those tags - they would be between shown
>>>>    commits.
>>>> 2. Create code which shows some/all tags that are between commits in
>>>>    the presence of nonlinear history, without affecting performance
>>>>    too badly.
>>>
>>> Ah, that is too bad because I think it would really useful.
>>> Image browsing a drivers history in the linux kernel. Then it would be
>>> really nice to see what changes/bug fixes went into what release.
>> 
>> First, you can help with the first issue even if you can't help with
>> the coding itself.
> 
> I like the gitk way of showing tags, won't that work in gitweb too?

Err... "gitk" shows tags, but so does 'shortlog' and 'log' view in
gitweb.  The 'history' view in gitweb doesn't show intermediate tags,
but neither does "gitk -- <path>".

>> Second, with single 'git name-rev --tags --stdin' or with '--decorate'
>> or '%d' in format we could (I think) either display at least some tags,
>> or name-rev decorations, i.e. something like:
>> 
>>   (v1.7.3-rc0~38) gitweb: Don't die_error in git_tag after already printing headers
>>   (v1.7.3-rc0~44) Merge branch 'maint'
>>   (v1.7.2.3~15) Typos in code comments, an error message, documentation
>>   (v1.7.3-rc0~85) Merge branch 'jn/maint-gitweb-dynconf'
>>   (v1.7.3-rc0~92) Merge branch 'maint'
>>   (v1.7.2.2~12) gitweb: clarify search results page when no matching commit found
>>   [...]
>> 
>> If we want to display all tags we would have IIUC extend git-log to
>> generate such information.
> 
> if displaying tags is a too expensive operation one could have a knob
> in gitweb to get at the tags.

Good thinking.  We have such knobs, so called 'features', for 'pickaxe'
and for 'grep' searches (both which can be expensive).

-- 
Jakub Narebski
Poland
