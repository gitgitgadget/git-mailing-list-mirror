From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 09 Jun 2011 11:52:18 -0400
Message-ID: <4DF0EC32.40001@gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com> <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com> <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:52:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhX5-0007A9-Az
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab1FIPw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:52:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41760 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab1FIPwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:52:24 -0400
Received: by iyb14 with SMTP id 14so1417633iyb.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:disposition-notification-to:date
         :from:user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DfQoty6xZHi7Uh1N6GJ88s++ceoXQWhU164Zw3RCnqA=;
        b=N/TXoj5z4bDE6Ii72Nl6xobPsLelrgKHI77j13vLBG6xXOUjIzuQqZK4Pg0XvlcFio
         2AK4G9PsCSIebpf3b8ilAh6H31wYkBgix5tsQgwYeDmMPD7OmRWkvdzQsnkosEQMTVhT
         JCxI1PhhuA/4v6nizmA2dcJ3TVH0RlggOdA3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=vYprP6mNnQ/kyp2hKxkhRpY0XNvPeBnIXgyCx+pxATpz2jGIBQpqboBCynpnp55+iz
         OCnIMN54TbT02vHhS7inDDuLyo9Q/vpbfJjT8fCHGH1g2fKBZWxeAGfTSxRoedovfIWt
         u6Ev0UtRAwt8B8PBqoCG2AfbNd5C1ia/H+gyw=
Received: by 10.231.116.132 with SMTP id m4mr1104341ibq.86.1307634744128;
        Thu, 09 Jun 2011 08:52:24 -0700 (PDT)
Received: from [10.0.1.133] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id s9sm834690ibe.10.2011.06.09.08.52.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 08:52:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110505 Iceowl/1.0b1 Icedove/3.0.11
In-Reply-To: <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175535>

On 06/09/2011 11:23 AM, Shawn Pearce wrote:
> On Wed, Jun 8, 2011 at 23:50, Sverre Rabbelier<srabbelier@gmail.com>  wrote:
>> [+shawn, who runs into something similar with Gerrit]
>
>> On Thu, Jun 9, 2011 at 05:44, NAKAMURA Takumi<geek4civic@gmail.com>  wrote:
>>> Hello, Git. It is my 1st post here.
>>>
>>> I have tried tagging each commit as "refs/tags/rXXXXXX" on git-svn
>>> repo locally. (over 100k refs/tags.)
>
> As Jakub pointed out, use git notes for this. They were designed to
> scale to>100,000 annotations.
>
>>> Indeed, it made something extremely slower, even with packed-refs and
>>> pack objects.
>
> Having a reference to every commit in the repository is horrifically
> slow. We run into this with Gerrit Code Review and I need to find
> another solution. Git just wasn't meant to process repositories like
> this.

Assuming a very large number of refs, what is it that makes git so 
horrifically slow? Is there a design or implementation lesson here?
