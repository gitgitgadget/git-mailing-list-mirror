From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 0/6] Corrections to the mailmap file
Date: Thu, 11 Jul 2013 19:52:49 +0200
Message-ID: <51DEF0F1.5010204@googlemail.com>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com> <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 19:52:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxL32-0006HX-A3
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 19:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab3GKRww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 13:52:52 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63215 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab3GKRwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 13:52:51 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so12953220wib.10
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=MQ9aEp8LDYusEIbb7gwDkVXJH4vQyQ9x7Z5BD9EIRyY=;
        b=yWpm6BLNr80B1WF43OZUo2GJeTVle9GgiZGG4P2b20aFGxr4a63osJGhyDuyH4/ZHH
         yMn7Yyam1kKWgEBiFt8gf2F7QsHkqAAasUs77euZkFLAhWKPj6inbIUL/YeQsYZmxgLR
         LrGBEuL2YCR96vBJge60QbukpeX8NPqIKpBzZAzlGOAebG7g+PqstNDTxl0sSxOq4FNL
         6gvmiR5o6ygfH/a/uiyM9VG6BLvtXFz/r7keKkMoqLu3BkU6t6VB1rR3olvfs4iRLnwb
         vwJEc5sRl2FDO5rLrmJOLatnNsCPIqtEokukUtqy8M/LN/6hjrccigODF6G2sCiQmDn3
         PqQA==
X-Received: by 10.180.73.68 with SMTP id j4mr22305033wiv.10.1373565167710;
        Thu, 11 Jul 2013 10:52:47 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z6sm43781893wiv.11.2013.07.11.10.52.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 10:52:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230123>

On 07/11/2013 07:33 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>> I noticed many duplicates in email addresses but having the same name by
>> running:
>>
>>     # Finding out duplicates by comparing names:
>>     git shortlog -sne |awk '{ NF--; $1=""; print }' |sort |uniq -d
>>
>> Most of these entries are most probably the same person, but we cannot be 
>> sure, as there might be different persons having the same name, then they
>> are only distinguished by the mail address.
>>
>> However I suspect most of these to be the same person, having changed 
>> mail addresses.
>>
>> Here comes an initial batch of corrections to the mailmap file, which
>> maps people with email addresses of different capitalization onto
>> the same entity.
>> (Example Name@MIT.EDU is the same as Name@mit.edu)
>>
>> I intend to contact each of the persons individually and ask whether 
>> just their mail address changed, or if they are indeed different persons.
> 
> Has anything happen to this topic sice you posted?
> 
> I think:
> 
>  - .(none) is obviously bad, and we can fix without waiting for
>    responses as long as we know the replacement address is the
>    address from the list we usually see on the list (3).
> 
>  - Domain part is defined to be case insensitive (e.g. @mit.edu vs
>    @MIT.EDU), so both forms are equally valid.  The owner of the
>    address may have preferences (1 and 4), though.
> 
>    For this, we could just declare we downcase the domain part.
> 
>  - The local-part, even though RFC 2821 says "local-part of a
>    mailbox MUST BE treated as case sensitive", is often case
>    insensitive, and User.Name@domain and user.name@domain often name
>    the same mailbox.  The owner of the address may have preferences
>    (5 and 6), though.
> 
>    For this, we could just declare we Camel.Case the local part,
>    after making sure Camel.Case@domain has been used by the owner of
>    the address on this list.
> 
> So where does that leave us?
> 
> We can apply without waiting:
> 
>   1: downcase domain
>   3: .(none) and we know paulus@samba.org
>   4: downcase domain
>   5: We recently saw Dshco calls himself <Johannes.Schindelin@domain>.
>   6: The latest one from Nov 2009 uses <Toby.Allsopp@domain>.
> 
> The only possibly iffy one is Alex Riesen, but <raa.lkml@domain>
> seems to be the one he uses here, so I think 2. is also fine.
> 

To be honest, I did not continue to work on this. I was 
waiting for the first few patches to be reviewed, because 
I was not sure how important you all think this topic 
really is. I know projects, which frown upon such 
beautyfing commits. Hence I was waiting for an answer, 
whether such work is appreciated.

Anyway, last time I tried contributing to git, I was 
told to explicitely do it in the open. I did forget 
to CC the mailing list when asking Alex Riesen 
(2nd patch), whether it's all him.
I do see the benefit of the openess, when discussing code 
or documentation, but I wonder if you'd also like to see these
'Hello, are you the person having email x, y and z?' 
kind of mails  put on the mailing list as well. 
That would be 120 to go, which may be undesired?

So I'll start contacting the other people now.



 
