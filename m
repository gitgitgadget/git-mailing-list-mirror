From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 18:11:34 +0100
Message-ID: <200711211811.34391.jnareb@gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> <200711211752.40264.jnareb@gmail.com> <Pine.LNX.4.64.0711211658510.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 18:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iut7f-0001zb-Lp
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbXKURLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbXKURLo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:11:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:33815 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbXKURLn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:11:43 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2181940nfb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=RutG81FzhLxVuAfKQJiuMeAnCugEQOckbiLL3C71UMQ=;
        b=uMspQp6BfpvzcVe/57TGiHOXas30ayqxFfwcNTk1xzPUCw9N6BHQ1LN7bl9c4rWmby7ryLRLopel0q0gUa+5c2uFFP94YZ8KTBJpTDc5j++y73vAIjDePzn0iXE/Ki+N8NWkfLSzhRAXsnDeE7b3OTJV07+dfijkWIjdb/W1hU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GPu9CRkJv4pCbyWEEA6A2AynSsD+9MtSfS1HPKTH7aayzyRaaDaMcYERvYO9ozqcCnkmwVaug2DIQMrAn3BWMe6tNPxfH8DMz01IybCEBoZqXyEVE6u/DZmvXpwxpLGJjPiMoUpnyXnRywFdaGFPmuMbRwIDUfndW6ZHfa/kV5I=
Received: by 10.86.54.3 with SMTP id c3mr7522881fga.1195665097496;
        Wed, 21 Nov 2007 09:11:37 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.19])
        by mx.google.com with ESMTPS id 3sm10053557fge.2007.11.21.09.11.35
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Nov 2007 09:11:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711211658510.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65683>

Johannes Schindelin wrote:
> On Wed, 21 Nov 2007, Jakub Narebski wrote:
>> Johannes Schindelin wrote:
>>> On Wed, 21 Nov 2007, Jakub Narebski wrote:
>>>> Santi Bejar wrote:
>>>> 
>>>>> 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if I have:
>>>>> 
>>>>> [remote "bundle"]
>>>>> 	url = /file/to/bundle
>>>>> 	fetch = "+refs/heads/*:refs/remotes/bundle/*"
>>>>> 
>>>>> $ git push bundle
>>>>> 
>>>>> would create a bundle in /file/to/bundle with the same branches as a
>>>>> normal git push, but considering the remote branches as the local
>>>>> remotes/bundle/*
>>>> 
>>>> And how you would differentiate between path meaning bundle, and path 
>>>> meaning "local" protocol, i.e. git repository on the same filesystem? 
>>> 
>>> Maybe because the git repository is specified as an existing directory?  
>>> The bundle is specified as a (possibly non-existing) file...
>> 
>> That has the disadvantage of pushing to bundle when you make an error
>> in the lastpart of path to existing repository.
> 
> As I wrote in another reply, I would not allow overwriting an existing 
> file.

> Specifying a non-existing file should be good enough.

What I meant here that if you do "git push /some/path/to/rpeo.git", with
mistake in the last part of path to repository, you would end up with
a bundle, and you would have to really watch what happened to catch
the error.

I'd rather use "git push bundle:///some/path/to/bundle" or 
"git push --bundle bundlename" to catch errors better.

Besides it should be IMHO be possible to overwrite bundle if you are
doing fast-forward push...

-- 
Jakub Narebski
Poland
