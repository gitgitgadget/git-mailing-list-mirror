From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-scm.com
Date: Thu, 31 Jul 2008 13:19:49 -0700
Message-ID: <2F33BB4E-C726-4405-8185-2B573ED7A3BA@sb.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>	 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>	 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>	 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>	 <20080727113707.GC32184@machine.or.cz>	 <7v3alv2n46.fsf@gitster.siamese.dyndns.org>	 <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>	 <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com>	 <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>	 <alpine.DEB.1.00.0807281201350.2725@eeepc-johanness> <530345950807281112w45215c16k49ffe240d41c6a9e@mail.gmail.com> <489206E4.2030901@freescale.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Tom Werner <pubsub@rubyisawesome.com>, git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOedr-0002am-Jq
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbYGaUTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYGaUTv
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:19:51 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:58956 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYGaUTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:19:50 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id 325C7125034A;
	Thu, 31 Jul 2008 13:19:50 -0700 (PDT)
Received: from [10.100.18.129] (unknown [10.100.18.129])
	by mail.rapleaf.com (Postfix) with ESMTP id 0559C12500B6;
	Thu, 31 Jul 2008 13:19:50 -0700 (PDT)
In-Reply-To: <489206E4.2030901@freescale.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90979>

On Jul 31, 2008, at 11:39 AM, Jon Loeliger wrote:

> Tom Werner wrote:
>>
>> The problem is that I'm only a casual C coder. It takes me a while to
>> figure out what's going on in the git source. We needed a way to  
>> serve
>> public git repositories from a hashed directory structure (e.g.
>> /a/b/c/user/repo.git) and we needed it fast.
>
> I'm not exactly sure what you mean by "hashed directory structure",
> but I suspect that your goal is some form of virtualized hosting
> that allows for directory names to be dynamically constructed with
> a component that appears to be the user name.
>
> Wouldn't the --interpolated-path ability of git-daemon either
> directly or with minor modifications directly support that?

Tom, correct me if I'm wrong, but my understanding of this is that,  
with GFS, they were running into the problem of too many dirents in  
one directory, thus causing lots of stability problems (GFS has a far  
lower limit than other filesystems in this regard). So the GitHub guys  
had to switch to a directory sharding structure (similar to how the  
git objects db uses the first 2 characters of the hash as the dir  
name) to split this up and keep the numbers manageable. However, they  
still had to support the old git://github.com/user/project.git paths.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
