From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Fix nested links problem with ref markers
Date: Wed, 14 Jan 2009 11:39:41 +0100
Message-ID: <200901141139.42263.jnareb@gmail.com>
References: <200901120215.13668.jnareb@gmail.com> <200901140117.38803.jnareb@gmail.com> <cb7bb73a0901131956s7f441c38o3a0b1e5f456a3cd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN3BR-0007kZ-Sy
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbZANKju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 05:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZANKju
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:39:50 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:41098 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbZANKjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:39:49 -0500
Received: by ewy10 with SMTP id 10so564771ewy.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=w/UYiZE/ppm1vHRre8oegSaXW8I2DAcuffq8593iCzU=;
        b=RN/3vGRDuH/DFk81EeCWYYYfbdFegV/FVblmTNDaXVscbOhzHsUyoJldGiFiE5Dxt0
         d4B+/k687RZJ/46d2HM0vcFz068a+8hoafSAU+jZVhpgSsYHvHbpDLINf5c7FEFNmmqd
         a8IhDdIz05AZ1U9fh9J96R9j9AfGV7vxKkjXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Mu3GGX0ZHtQRqPRsVumi+2njAWdzP37kXyJNKe4JajQdN9lCAyBXW+e7vuXkyN8Gfq
         UW5/DSpNODMN7jtXx6vzfp2EUC19unc2UX5uCaPQxwAiLadiXFKlrqKB7vVagcXVb42U
         QIuQJ+eWVOckGe1ZeF6IxSjaMG1tdcUiwYLck=
Received: by 10.210.29.11 with SMTP id c11mr3216526ebc.104.1231929587157;
        Wed, 14 Jan 2009 02:39:47 -0800 (PST)
Received: from ?192.168.1.11? (abwf55.neoplus.adsl.tpnet.pl [83.8.229.55])
        by mx.google.com with ESMTPS id 28sm3182944eye.30.2009.01.14.02.39.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 02:39:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0901131956s7f441c38o3a0b1e5f456a3cd3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105612>

On Wed, 14 Jan 2009, Giuseppe Bilotta wrote:
> On Tue, Jan 13, 2009 at 7:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 13 Jan 2009, Giuseppe Bilotta wrote:

[...]
>>> The float thing was the second suggestion I was given on www-style.
>>
>> What was the first suggestion? And what is www-style?
> 
> The first suggestion was to just leave things as they are. www-style
> is www-style@w3c.org, the CSS mailing list of the W3C

Thanks.
 
>>> Can you provide a patch I can apply to my tree for testing to see how
>>> it comes up?
>>
>> Here it is. Note that CSS could be I think reduced. The size of
>> gitweb.perl changes is affected by changing calling convention for
>> git_print_header_html subroutine.
> 
> It's funny, I was working on a very similar patch myself a couple of
> days ago, but couldn't get the horizontal filler after the link to
> work properly, which is why I asked on www-style.
> 
> I'll test your patch and let you know.

I am checking 'log' view of git repository; it should have enough
ref markers to test this issue.

It works also in Konqueror 3.5.3-0.2.fc4...
 
>> There is also strange artifact at least in Mozilla 1.17.2: if I hover
>> over ref marker, the subject (title) gets darker background. Curious...
> 
> Might be some kind of bug with the capturing vs bubbling phase.

...but the same artifact can be seen too.  Also I am not entirely
pleased with the way things behave on mouseover.  It is a pity that
you cannot style element using CSS2.1 based on the pseudo-class :hover
of descendant element, or/and pseudo-class of sibling element, which
nevertheless overlays given element.

-- 
Jakub Narebski
Poland
