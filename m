From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Fix nested links problem with ref markers
Date: Wed, 14 Jan 2009 08:52:03 -0500
Message-ID: <cb7bb73a0901140552k6de6f48udd77205b918f30@mail.gmail.com>
References: <200901120215.13668.jnareb@gmail.com>
	 <200901140117.38803.jnareb@gmail.com>
	 <cb7bb73a0901131956s7f441c38o3a0b1e5f456a3cd3@mail.gmail.com>
	 <200901141139.42263.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN6BY-0003fU-PX
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbZANNwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbZANNwI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:52:08 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49771 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891AbZANNwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:52:06 -0500
Received: by bwz14 with SMTP id 14so1767022bwz.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 05:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OcZa0qsJHwCb3t5t2df0T5le5yuhqWBhTqkrbHzg1aw=;
        b=A/4/ziAY+VWUPpqoQC0MB4U3nAFXt5oQvMqQ+Ofi5bqRpNeG2wcwEYUwGZhOh99yvQ
         WJVTZ9Bw+EMXPyByTrg9B2paMxSTC4YkXL2nh+/0RK3T7oBLax2BIssOm6NTJf3qgVdX
         epneHitrNp2KzYB3feom76pdSAA9e612eUqd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YrQ2BGaIXGFAIbqBpmtQ8ThP7HVSJRpr8V6TLWVnl1pTlpRTxL6KT6LtSX998JPpwd
         cPmZY4xl+8izBVuw4WT0eK5tzLBmd4wqkpj/AATPMGsyzHo6tzWSC+WzpctqswpOVBgi
         x8Zstf8T0P6pEfGNa2RWgoS1CpOUblFHOpAdc=
Received: by 10.181.24.14 with SMTP id b14mr32515bkj.104.1231941123315;
        Wed, 14 Jan 2009 05:52:03 -0800 (PST)
Received: by 10.181.195.1 with HTTP; Wed, 14 Jan 2009 05:52:03 -0800 (PST)
In-Reply-To: <200901141139.42263.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105629>

On Wed, Jan 14, 2009 at 5:39 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 14 Jan 2009, Giuseppe Bilotta wrote:
>> On Tue, Jan 13, 2009 at 7:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Tue, 13 Jan 2009, Giuseppe Bilotta wrote:
>
>>>> Can you provide a patch I can apply to my tree for testing to see how
>>>> it comes up?
>>>
>>> Here it is. Note that CSS could be I think reduced. The size of
>>> gitweb.perl changes is affected by changing calling convention for
>>> git_print_header_html subroutine.
>>
>> It's funny, I was working on a very similar patch myself a couple of
>> days ago, but couldn't get the horizontal filler after the link to
>> work properly, which is why I asked on www-style.
>>
>> I'll test your patch and let you know.
>
> I am checking 'log' view of git repository; it should have enough
> ref markers to test this issue.
>
> It works also in Konqueror 3.5.3-0.2.fc4...
>
>>> There is also strange artifact at least in Mozilla 1.17.2: if I hover
>>> over ref marker, the subject (title) gets darker background. Curious...
>>
>> Might be some kind of bug with the capturing vs bubbling phase.
>
> ...but the same artifact can be seen too.  Also I am not entirely
> pleased with the way things behave on mouseover.  It is a pity that
> you cannot style element using CSS2.1 based on the pseudo-class :hover
> of descendant element, or/and pseudo-class of sibling element, which
> nevertheless overlays given element.

I know, I've been needing something like this in other occasion. And
that's precisely what I was talking about for the limits of CSS, and
why I really wonder if the illegal XHMTL but valid XML shouldn't
rather be our option ...



-- 
Giuseppe "Oblomov" Bilotta
