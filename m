From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of function
Date: Tue, 18 Aug 2009 07:23:42 +0200
Message-ID: <4A8A3ADE.9010703@gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302> <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com> <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Reece Dunn <msclrhd@googlemail.com>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 07:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdHB1-0006bK-23
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 07:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZHRFXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 01:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbZHRFXp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 01:23:45 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:39777 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbZHRFXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 01:23:41 -0400
Received: by fxm11 with SMTP id 11so147983fxm.39
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 22:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Zb/By2t8jY6HGfvRmijiXqPqAYb3vauj41HYpqXOcGg=;
        b=rLYFqc9v8c5VwPG24WNMr/1lM1vF3i1zrJkiP9lVgmSIiueB3ryFSi01K7lnBnYh71
         qObbXVkWDMFdKKIHfkxfCnAFCDPdmealMoJfkP/Ud0R/BUIy81f/1CO15jMuNxSZ6JUx
         2fsuaid1EB7H3KXhperjcd2rZNd7ztu8HOa7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gcTMIr8AET2UctOqP8D30JFm8MfdCMuDhcMh7KAP7w07Az7vTueQ3qNp5Z/Anp4YNb
         FmpxvHpzWn1smYYzQvKoRYXbFj1nDYAhKmLqyBnrb59wK0Txw2QpraZiPzFrqowR1NsR
         4Ne7YhfhRkweF++mJ1eputcRaycEZe9TUq3lo=
Received: by 10.204.151.210 with SMTP id d18mr3356388bkw.203.1250573020962;
        Mon, 17 Aug 2009 22:23:40 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 35sm5866242fkt.50.2009.08.17.22.23.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 22:23:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126347>

Johannes Schindelin said the following on 17.08.2009 21:36:
> Hi,
> 
> On Mon, 17 Aug 2009, Reece Dunn wrote:
> 
>> 2009/8/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>>> On Tue, 18 Aug 2009, Frank Li wrote:
>>>
>>>> Some compiler such as MSVC can't support declear variable at mid of 
>>>> funtion at c file.
>>> Please wrap your commit messages after 76 characters.
>>>
>>>> Signed-off-by: Frank Li <lznuaa@gmail.com>
>>>> ---
>>> How about this instead?
>>>
>>>        Avoid declaration after instruction
>>>
>>>        Microsoft Visual C++ does not understand this C99 style.
>>>
>>> ?
>>>
>>> The patch itself is good.
>> Shouldn't GCC be changed to use -std=c89 as well to pick up errors for 
>> compilers that don't support c99 (like the Microsoft Visual C++ C 
>> compiler)?
> 
> Hmm.  I played with the thought of adding -Werror -Wno-pointer-to-int-cast 
> -Wold-style-definition -Wdeclaration-after-statement like Junio described 
> in one of his mails for MinGW (as we _know_ what compiler we have there).
> 
> Dunno.

IMO it would be a good change. We should  not have any of those anyways..

--
.marius
