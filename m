From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch
Date: Fri, 28 Nov 2008 04:36:26 +0000
Message-ID: <492F754A.3080204@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 05:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5v71-0002QQ-33
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 05:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbYK1Egd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 23:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYK1Egc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 23:36:32 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:15706 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbYK1Egb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 23:36:31 -0500
Received: by ey-out-2122.google.com with SMTP id 6so542651eyi.37
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 20:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=09fcb3bhQ7lW0hgF9sq4KhMHEQPP81YGuaZwjEdVShE=;
        b=oDDPSKZPGZD81wNQHfepf4dGJHchLZRxOGtsDhMficWUrfrxPlrTGnxvte2Hl0MtkX
         ZSK9IHS4UCAFV6XGtG1OqkVlJjcN9zvOTu5+LS5OIHJ+lyvOXC8xz0EvTXe4rqsvcEvy
         zs85iSrFQr/SdLDCUyn0daC1q4aOgonK017ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Wl/FtuueuzVBzdV39Osl3SonWZOJJZtmE2YmDK8kJpt+NdEopvmnWcxlOShezPtjP6
         9oAVOTtEmqsNpPTXmPII+Og4u8448AnSTuDo1jLAdOabX0r/cKAj/03s1QdIt1qFGc9s
         H3mtN5hzd2VwrSLAslJwHq9YdK7O2XitpDyXU=
Received: by 10.210.45.14 with SMTP id s14mr8310785ebs.64.1227846989733;
        Thu, 27 Nov 2008 20:36:29 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id t12sm397970gvd.25.2008.11.27.20.36.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 20:36:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7viqq8adsf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101861>

Junio C Hamano wrote:
> William Pursell <bill.pursell@gmail.com> writes:
> 
>> Stage this hunk [y,n,a,l,d,k,K,j,J,e,?]? l
>> '*' indicates current hunk.  '+' stage, '-' don't stage
>>  0+: @@ -8,9 +8,9 @@ Aani
>>  1 : @@ -48,7 +48,7 @@ abandonable
>> *2 : @@ -88,7 +88,7 @@ abaton
>>  3 : @@ -128,7 +128,7 @@ abdest
>>  4-: @@ -81192,9 +81192,9 @@ gyrous
>>  5 : @@ -234925,7 +234925,7 @@ zymotic
>> @@ -88,7 +88,7 @@ abaton
>>  abator
>>  abattoir
>>  Abatua
>> -abature
>> +agature
>>  abave
>>  abaxial
>>  abaxile
> 
> Machines count from zero but humans count from one.

Humans should change. :)  Good point.

> What is your plans to limit the output of this when there are dozens of
> hunks?

Would having git-add--interactive fork a PAGER be too drastic?
It strikes me as probably being unworkable, and a better
approach would be too only display a fixed number of lines
and not immediately display the current hunk.  (In line with
your suggestion below to make it a status command.)

> A hunk can and often is quite long which would make this list scroll off
> the screen.  Together with the previous point, I suspect it would be
> better to make this not part of the "Stage this one?" question, but an
> action that (1) does not do anything to the hunk we have currently focus
> on, and (2) does not move the focus after it does its thing.  In other
> words, a new "status" action.  I think 'S' is not taken yet although 's'
> is taken for 'split'.

I tend to use 'git add --patch' directly rather than
git add --interactive, and would prefer to be able to
access the list from there.  But your point is definitely
valid and my work flow should probably change.

re: 's' vs 'S', I notice that y,n, and d are all case
insenstive, but the other commands are not.  Is this
necessary/desirable?

-- 
William Pursell
