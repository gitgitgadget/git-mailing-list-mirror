From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] New commit object headers: note headers
Date: Sun, 10 Feb 2008 00:26:38 +0100
Message-ID: <200802100026.39340.jnareb@gmail.com>
References: <200802091746.09102.jnareb@gmail.com> <fcaeb9bf0802090950l27aa247ei5d067e0f24fcade0@mail.gmail.com> <7vlk5tetaa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNz7b-0002LU-Vr
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 00:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626AbYBIX1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756872AbYBIX1M
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 18:27:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:32771 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbYBIX0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 18:26:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3310089fga.17
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=PtV+u9a/g/HzcbA+K1o/9FJ4n+VKZpztRvsKxgi/4No=;
        b=dH7kqfugTKO7/HDFtnVQDNkQQAI+nYo44Zk7OMMVA8pfDpwZuGBDdfrcteR7KwCTBet0fJDRYYxZs57cK0c+07gt/+24q9eATuCfGR0g3WM4VFQn7MRVdpZDPBraep1nIv73haRi8OmdHZa3afQ4JV3QkR1m1uVZooifoVmutPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XJRJk39CbYV4b+kJvE3ZplMkQYiA1BOVy4BiMqDqH7q7P4zW1uhBDqLj5E/V1sZdxtCZN7KAbVaPVJR+frYYnQQnC8BfSmGiHlRTj0eMKER2U3YKvrj8cBR+W59Ez/sy8DEkhrZnopBov6qeHUArHaxNnDP8IOO8FOhTUBLvp2c=
Received: by 10.86.73.17 with SMTP id v17mr13327683fga.67.1202599607080;
        Sat, 09 Feb 2008 15:26:47 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.105])
        by mx.google.com with ESMTPS id y37sm15654252iky.7.2008.02.09.15.26.43
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 15:26:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlk5tetaa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73273>

On Sat, 9 Feb 2008, Junio C Hamano wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>> On Sun, Feb 10, 2008 at 12:35 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>>> On Sat, 9 Feb 2008, Jakub Narebski wrote:
>>>>
>>>> 2. 'note' header (no semantical meaning)
>>>>
>>>> There was some time ago discussion about adding 'note' header, initially
>>>> to save original sha-1 of a commit for cherry-picking and rebase; then
>>>> for saving explicit rename or corrected rename info, for saving chosen
>>>> merge strategy, and for saving original ID of SCM import.
>>>
>>>  Probably want to have a prescribed syntax for specifying what note this
>>>  is, so that different programs using notes don't confuse each other.
>>
>> How about git ignoring all X- headers and let programs freely add
>> them? For example, X-SVN may be used for git-svn.
> 
> Please don't.
> 
> When two people/programs create an otherwise identical (for the
> purpose of git) commits that have two different object names,
> there'd better be a very good reason other than "I felt like
> adding an extra header that I can use willy-nilly".
> 
> Please separate the 'note' part and the 'generation' part and
> make two separate discussion threads.
> 
> And kill 'note' part altogether, but that can be done in that
> thread ;-).

Ah, well... very good reservation. So here it goes generic 'note'
(or 'X-*', similarly to non-standarized email headers) header...

Still I think it is would be nice to have original commit id in
a header when importing from foreign SCM. First, it would not pollute
commit message, which would be identical with the original commit
message (which allows easy two-way interaction). Second, it is
much easier and much less error prone to extract it by machine.

As to marking explicitely renames and copies...
-- 
Jakub Narebski
Poland
