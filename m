From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 17:52:39 +0100
Message-ID: <200711211752.40264.jnareb@gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> <fi1heo$u4i$1@ger.gmane.org> <Pine.LNX.4.64.0711211544510.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iusp5-0001lZ-EQ
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXKUQwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbXKUQwv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:52:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:61885 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbXKUQwu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:52:50 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2175898nfb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Yme4a9dFl8pds9I/7mBkXL2xKON8HTsaT8HK/+lOt88=;
        b=H0KaziNCB1PVDaPraENJKqjLTtucBWg3hNAkmKLM6av/8zNdGzqhX8yJLWel7ls1Kk1f07VJ4jtu5W1ijusij9Du9ebbDilLjP8hjgavWnrV5YuDeFawbZ5IYWJQtw2zTrY/HEf7CQ14778gZoXXOTkpHV4ziulHxRI/f4Q1ym0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dGP1B7FfLYCMntOgFR7vsPAx73n/vxQJklwL8ua844um+dhooh9JIjvkXlWY9C2lSoNoC3fYi1yoAm52inano3pv0N91gUFqhKhMHbO3Xp0uhkeZw64Pn2fu2e7LxAFX7IpdTpd9TBeXaIOmLEsziYt0PPn8+4aiDqQ8+llC9G0=
Received: by 10.82.138.6 with SMTP id l6mr20519352bud.1195663968814;
        Wed, 21 Nov 2007 08:52:48 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.19])
        by mx.google.com with ESMTPS id p38sm7892180fke.2007.11.21.08.52.46
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Nov 2007 08:52:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711211544510.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65678>

Johannes Schindelin wrote:
> On Wed, 21 Nov 2007, Jakub Narebski wrote:
>> Santi Bejar wrote:
>> 
>>> 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if I have:
>>> 
>>> [remote "bundle"]
>>> 	url = /file/to/bundle
>>> 	fetch = "+refs/heads/*:refs/remotes/bundle/*"
>>> 
>>> $ git push bundle
>>> 
>>> would create a bundle in /file/to/bundle with the same branches as a
>>> normal git push, but considering the remote branches as the local
>>> remotes/bundle/*
>> 
>> And how you would differentiate between path meaning bundle, and path 
>> meaning "local" protocol, i.e. git repository on the same filesystem? 
> 
> Maybe because the git repository is specified as an existing directory?  
> The bundle is specified as a (possibly non-existing) file...

That has the disadvantage of pushing to bundle when you make an error
in the lastpart of path to existing repository.

After thinking about it a bit, I think it would be better to use 
bundle:// pseudoprotocol for the URL including config (bundle://file,
bundle:///path/to/bundle) and --bundle option to git push for
commandline.

-- 
Jakub Narebski
Poland
