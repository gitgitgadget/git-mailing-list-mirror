From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb and submodules
Date: Mon, 30 Jul 2007 02:09:03 +0200
Message-ID: <200707300209.03531.jnareb@gmail.com>
References: <200707271322.50114.jnareb@gmail.com> <200707282239.29340.jnareb@gmail.com> <20070729163747.GJ31114MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Mon Jul 30 02:09:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFIp7-00024K-2j
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 02:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965410AbXG3AJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 20:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763826AbXG3AJK
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 20:09:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:34710 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764031AbXG3AJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 20:09:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so133022nfb
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 17:09:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mLa9Op5nlbNSShnKjy51n1RuEWHJaZwGZESDJ78eh6pSp7DzXRGWUM0wwAfR/K0kAlQdQBL9PBeZRtxoM1dA3VbrfINUnO6UIHnSnToT9HCaUsqQbNt4XoWTUg9yf4N1SG5hbLAOvwMvdkKWv8t0PAlJIw0FZCoxkfGLboTOu+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NxWSmNvg813RBvZN8DzBaK6mNGCpP6SHx/JM33jelbuYVUVjorCmRxctai+r34mIk1kyGU3iq9XZLGnjmyFT/b91VpiQ31Lzdpdr4TOh9zc0dVe5UZQC3/cFGiQocq3FvqZUzSed1VghW5NjC8yxCyh9bho+pV0+yRC1afZ9DNc=
Received: by 10.86.89.4 with SMTP id m4mr3511424fgb.1185754147632;
        Sun, 29 Jul 2007 17:09:07 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id e9sm11364954muf.2007.07.29.17.09.06
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jul 2007 17:09:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070729163747.GJ31114MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54164>

On Sun,29 July 2007, Sven Verdoolaege wrote:
> On Sat, Jul 28, 2007 at 10:39:28PM +0200, Jakub Narebski wrote:
>> On Sat, 28 July 2007, Sven Verdoolaege wrote:
>>> On Sat, Jul 28, 2007 at 12:29:16PM +0200, Jakub Narebski wrote:
 
>> I am thinking about the following sequence to search for submodule
>> objects:
>> 
>> From $GIT_DIR/config:
>>   submodule.$name.objects (absolute or relative to gitdir of superproject)
>>   submodule.$name.gitdir  (absolute or relative to gitdir of superproject)
> 
> Do we really need both of these?

We need only location of object database for projects. The submodule
does not need full GIT_DIR structure, with refs, config, etc.

So no, I'm not sure if we want both. They are equivalent to setting
GIT_OBJECT_DIRECTORY and GIT_DIR for submodule, respectively.
 
>>   submodule.$name.url     (to find GIT_DIR, if it is local filesystem URL)
>> 
>> If there is working directory, from .gitmodules file in top level
>> of working directory:

Or the .git/config of superproject.

>>   submodule.$name.path/.git (relative to toplevel of working directory)
> 
> Having a relative path for the URL in .gitmodules in a public repo
> doesn't seem very useful to me.  I know it's only meant as a default
> value, but if it is a relative path, then it won't work for
> anyone cloning the superproject.

Erm, it should be relative path in .git/config (as in example in the
t/t7400-submodule-basic.sh IIRC). And this is purely local matter.

-- 
Jakub Narebski
Poland
