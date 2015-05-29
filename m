From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Fri, 29 May 2015 18:41:02 +0200
Message-ID: <87r3pz49r5.fsf@gmail.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
	<xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
	<87zj4n4w3t.fsf@gmail.com>
	<xmqqsiafe6md.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 18:41:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyNLB-0001EQ-4J
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbbE2Qk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:40:57 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38163 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbbE2QjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:39:12 -0400
Received: by wizo1 with SMTP id o1so30830631wiz.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=swJ2tJS2CEKRxSbRwOyR0YVBqLLpRBJC8PFOG2KYhb4=;
        b=q6XdBkfM4uszEfh8A8laBZMnVLvnFVsXpYpYZdRYPMNk3ksqjvuDsobGM88BeiuUlr
         N8WdGKouBfLWWUsufEBFFzaNDkOzB9jihqbXOrtcE05ZPNU7fqyUA6whlO/15SUQToNZ
         Ep4vzAR7DRWixrE+936KluObMImOwAROkXECSwB9McK1sUJ7sy/yADIZdtE3vzj15zw6
         oKcLVd58SUbv/VmfAN1tPssQ5Ndx63Ghl19i+F8ny3mf/GTlPROs0kuYrjxjQ3DWkpGx
         nb5fABZgEbRI7lR2l8VlNrhKijWuP+3OrFX8IIyrI4WDkmnEGTDDUl2z7h3i7nJDzk4D
         A2YQ==
X-Received: by 10.194.110.100 with SMTP id hz4mr17021755wjb.6.1432917551170;
        Fri, 29 May 2015 09:39:11 -0700 (PDT)
Received: from juno.home.vuxu.org ([2001:4ca0:0:f230:a288:b4ff:fea1:ce50])
        by mx.google.com with ESMTPSA id ef10sm9074720wjd.49.2015.05.29.09.39.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2015 09:39:09 -0700 (PDT)
Received: from localhost (juno.home.vuxu.org [local]);
	by juno.home.vuxu.org (OpenSMTPD) with ESMTPA id 378044ae;
	Fri, 29 May 2015 16:41:02 +0000 (UTC)
In-Reply-To: <xmqqsiafe6md.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 May 2015 08:38:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270255>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Neukirchen <chneukirchen@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  * You can help yourself with something like this, I suppose:
>>>
>>>    [alias]
>>> 	git = "!sh -c 'exec git \"$@\"' -"
>>>
>>>    but I personally feel that it is too ugly to live as part of our
>>>    official suggestion, so please do not send a patch to add it as
>>>    a built-in alias ;-).
>>
>> So I thought I was clever, but this didn't work:
>>
>> % ln -s /usr/bin/git ~/bin/git-git  
>> % git git
>> fatal: cannot handle git as a builtin
>
> Why did you have to do that when I already gave an alias that works?

I was just toying around, and it would have been cute.

> Or didn't the alias work?

It does.  This seems to work just as well, and is easier:

	git = !git

Thanks,
-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
