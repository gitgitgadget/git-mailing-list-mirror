From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Problem: fatal oops during git fetch
Date: Thu, 14 Jan 2010 08:28:39 +0300
Message-ID: <20100114052839.GG10586@dpotapov.dyndns.org>
References: <op.u6hrkho1a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tilo Schwarz <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:30:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIHy-0004xL-56
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab0ANFab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481Ab0ANFab
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:30:31 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:37654 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0ANFaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:30:30 -0500
Received: by fxm25 with SMTP id 25so152600fxm.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XNTl5Smm15GWO9jcdj4jLEGLL57QkeFUNCZabbcuVVM=;
        b=qa3yVr0AST1zYe8TaTCBnSND4pG9eYQGfdO9FVgf/rrzx5ptOgLcEagFYIpROcfXxI
         IrT/lq4f6wCXh4R5Y1Q+3pI59SuObsj3E7e6KbolKsu9PEUWnP2TSgxodT4HacbnsJYE
         oXzNYczUF9GVxWHTpsKkgXh6GmnNY16ZMWNxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=odrRyRM7QJ0+CVIogrMctPUgpRwMqftmyxSvO3rvcrdiZcKU1msfxeFX8Qu9KQSaJf
         G6dNPGITxvCeT+hvsN0fI6IwFJ7OBOwnwYcfWuLyrQ1h5wkQbN4rfgyLqFjkECVYNURB
         KDkuXYjLzczO/cON2jPPbRRwSbq+ysAb5lNt0=
Received: by 10.223.2.80 with SMTP id 16mr276218fai.90.1263447028906;
        Wed, 13 Jan 2010 21:30:28 -0800 (PST)
Received: from localhost (ppp91-77-224-149.pppoe.mtu-net.ru [91.77.224.149])
        by mx.google.com with ESMTPS id 15sm137334fxm.14.2010.01.13.21.30.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 21:30:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <op.u6hrkho1a8ed4e@dellschleppa>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136931>

On Wed, Jan 13, 2010 at 11:03:43PM +0100, Tilo Schwarz wrote:
> 
> Yesterday I tried to fetch bug fixes from one remote machine to the main  
> development machine being on branch 'test' using
> 
> git fetch remote/test
> 
> I got something like
> 
> fatal: oops 'SHA1'
> Fetch failed
> 
> Any ideas what happened here?

My guess is that the remote repository is corrupted, and the specified SHA1
object was not found or it was corrupted. Try to run:

  git fsck --full

in the remote repository.


Dmitry
