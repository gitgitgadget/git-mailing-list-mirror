From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: mtimes of working files
Date: Thu, 12 Jul 2007 08:57:51 +0100
Message-ID: <200707120857.53090.andyparkins@gmail.com>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 09:58:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8tYo-0004vC-1x
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 09:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXGLH57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 03:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbXGLH57
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 03:57:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:20860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbXGLH56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 03:57:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so283385ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 00:57:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AY2wqW2W5u4kqpTj7i2XeEyO0aJV1gyGZt4lbYE6WJIti09X/EjKGtSn1CDUeh822y+z8gMkrjzv9W+oP69jOiw/MKZgMS0iQDWRatrN9IFCTRbwd9dG+y6PKTRNP5HcFTsUUX/Ypm1DUfZYqND/Hht91hi9HNmw0NP+YcUrOug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kddarrPBR0WHAjS3hwUC20tF6vjsZfSu6bqud7oq4UpAD4vs+IWhM7vYK/p4snsFVTkb1r8sd1nSAhksnbhly1ivjuaxu7m7JTSYtBGR3MuGdnzOOitGwydbWfugnsS7BpX+3xsLrU/DmPD1h2/PrUktuiPNBJleAFy+27iI0lU=
Received: by 10.66.224.3 with SMTP id w3mr1055130ugg.1184227077093;
        Thu, 12 Jul 2007 00:57:57 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b33sm35395246ika.2007.07.12.00.57.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 00:57:56 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070711202615.GE3069@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52255>

On Wednesday 2007 July 11, Jan Hudec wrote:

> I first thought the idea had something to do with make, but it will
> actually promptly break most build tools, because change to earlier version
> is a change too, but they wouldn't detect it.

I've found git's mtime setting to be the best where make is concerned so I 
would hate to see it changed.  Even when switching branches or rebasing or 
whatever, only the changed files get rebuilt.  The only time you get an 
unnecessary rebuild is if you do

 git checkout branch1
 git checkout branch2
 git checkout branch1

But we can hardly expect git to be responsible for that.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
