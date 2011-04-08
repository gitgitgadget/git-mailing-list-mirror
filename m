From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: convert crlf to eol on vendor branch overlay
Date: Fri, 08 Apr 2011 13:18:41 -0500
Message-ID: <4D9F5181.7050806@gmail.com>
References: <inlsit$scv$1@dough.gmane.org> <7vy63l4ak6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8GGj-0003Yx-33
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 20:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392Ab1DHSSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 14:18:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44091 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab1DHSSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 14:18:47 -0400
Received: by ywj3 with SMTP id 3so1531603ywj.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8iTuqJd702tm+6/6Wb+LJxwE8kJskl/cXelfR826gFY=;
        b=TQS9K7MPw3XEatsmoABDUD8JMayvyrpfbVfY5eiFyRN1BKYVtomkVSY1N7DirSMvZC
         L0M7Q40tzcIo82Lfwr+2m5BGq+yTUrkCIj3HOMIg0LiDeAzHdosDTUYwHEPuYfNRmLLs
         JY0qNTuABLqHWw8HIxGY7cx96ZdoYZvQRhMxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=YZdDxK+clLbz/wcslcin0SccNxp+auKop+8Z4JtAgOmiE28haKHec8vSS59zoSCPG7
         eBRlo33Oy2LoNCzGmq5fMpWQCMkAO/bnNfDbrxheDOinWa+Nd1V8YdeW1I5aaSl2WRAr
         9v/eSJGn5UjctZstJF2Fitm0pY7rsq7owjU8E=
Received: by 10.101.143.1 with SMTP id v1mr1759903ann.21.1302286726420;
        Fri, 08 Apr 2011 11:18:46 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c24sm3185062ana.21.2011.04.08.11.18.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 11:18:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vy63l4ak6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171140>

On 4/7/2011 11:43 PM, Junio C Hamano wrote:
> "Neal Kreitzinger"<neal@rsss.com>  writes:
>
>> How do I convert the eol's to LF?
>>
>> I tried this:
>>
>> vi .git/attributes
>> SRC/*/* text  (convert these to LF eol on commit)
>>
>> $ git config core.eol lf (convert "text" attr files to LF eol on checkout)
>
> Instead, how about something like:
>
>    $ git ls-files -z | xargs -0 perl -p -i -e 's/\r$//'
>
> and then:
>
>> $ git add . -A
>> $ git commit -m'convert eol'  (should convert CRLF to LF)
>
> ?
That worked!  Thanks!
