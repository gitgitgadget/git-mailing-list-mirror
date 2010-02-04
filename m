From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 19:41:36 -0500
Message-ID: <4B6A17C0.8030007@gmail.com>
References: <20100203174041.GC14799@spearce.org> <alpine.LFD.2.00.1002031311010.1681@xanadu.home> <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com> <20100203192612.GD14799@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: demerphq <demerphq@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 01:41:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncpn2-000566-CI
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 01:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab0BDAln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 19:41:43 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:61278 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0BDAlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 19:41:42 -0500
Received: by yxe27 with SMTP id 27so1710969yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 16:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZGcecWukIpJZwNYS3qm6A/02LqdncaLdBJWBeNwnqI4=;
        b=hdmD9QJSChiezSoXDnINgmC/4ypK1iQ8pGKXgpHFNr+DfOFr3a7ZhfCC+dwBuASEFP
         gNNyytcauC7XFeO+Mikq7UR3bfkmAQAirbeS0HTGvRq6EhmB1/CYsrT+i0ueZo0EMKnA
         DhHfWuIBGoUqeOGhrqJMSNs33pGKz1QSgJNj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=evxk4dcoXzMcFiZh0RCZqxOxIJUKWVzKBKBzgmlrhSm/2YnxI9ENNZOzejCitTzAPt
         OJ7+YLAc+VaFn5ZjimOXL8fjnGHO5Q2qjnP7y0ZHNwlPgEBEbPYd0GQ9M1/qC782UPWy
         2tXAXmDY+RrjtKANdhcyvkR5JnZBtvQOa6THI=
Received: by 10.101.106.11 with SMTP id i11mr467307anm.112.1265244101548;
        Wed, 03 Feb 2010 16:41:41 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 13sm5075336gxk.9.2010.02.03.16.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 16:41:40 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20100203192612.GD14799@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138921>

Shawn O. Pearce wrote:
> demerphq <demerphq@gmail.com> wrote:
>> On 3 February 2010 19:15, Nicolas Pitre <nico@fluxnic.net> wrote:
>>> On Wed, 3 Feb 2010, Shawn O. Pearce wrote:
>>>
>>>> Am I correct that core C developers are still under the opinion
>>>> that extra headers in a commit object aren't encouraged?
>>> I would say so.
>>>
>>> [...]
>>>> At the end of the day, is it a bug that C git doesn't support
>>>> working with extra commit headers? ?IMHO, no, because, we've
>>>> rejected these in the past, and its not part of the Git standard.
>>>> And other implementations shouldn't be trying to sell it that way.
>>> Agreed. ?And this was discussed in great length on this list on few
>>> occasions already (probably more than a year back).
>> One problem, is that if you take the approach you say then you
>> basically guarantee that a new git that DOES add new headers will
>> break an old git that doesnt know about the headers, and actually
>> doesnt care about them either.
> 
> As I understand it, the current stance is:
> 
> 1) A compliant Git implementation ignores any headers it doesn't
>    recognize that appear *after* the optional "encoding" header.
> 
> 2) A compliant Git implementation does not produce any additional
>    headers in a commit object, because other implementations cannot
>    perform any machine based reasoning on them.
> 
> 3) All implementations would (eventually) treat all headers equally,
>    that is they all understand what author, committer, encoding are
>    and process them the same way.  Any new headers should equally
>    be fully cross-implementation.
> 
>> So it would essentially mean that if you ever have to change the
>> commit format you will be in a position where new git commits will be
>> incompatible by design with old git commits.
> 
> So, we can change the format by adding a new header, after the
> optional "encoding" header.
> 
> But such a change needs to be something that an older Git will
> safely ignore (due to rule 1), and something that a newer Git can
> make really effective use of (due to rule 2 and 3).  And that newer
> Git must also safely deal with commits missing that new header, due
> to the huge number of commits out in the wild without said header.
> 
> And don't even get me started on amending commits with new unknown
> headers.  Existing implementions of Git tools will drop the extra
> headers during the amend, because the headers are viewed as part
> of the commit object data... and during an amend you are making a
> totally new object.
> 
> For example, git-gui would drop any extra headers during an amend,
> because its running `git commit-tree` directly without any way to
> tell commit-tree this is for an amend of an existing commit, vs. a
> completely new commit... because either way its a new commit object.
> 
>> Shouldn't an old git just ignore headers from a new git?
> 
> Yes, see above.
>  

4) C-git "owns" the header name space. The git ML is _the_ controlling 
standards body.
