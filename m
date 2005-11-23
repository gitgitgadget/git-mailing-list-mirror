From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Wed, 23 Nov 2005 16:39:58 +0100
Message-ID: <200511231639.59866.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <200511230005.12957.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0511231549320.8191@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 16:43:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eewjg-0007iZ-Ej
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 16:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVKWPkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 10:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKWPkI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 10:40:08 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:9906 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751053AbVKWPkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 10:40:06 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 8DCF82295
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 16:40:05 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.63.0511231549320.8191@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12634>

On Wednesday 23 November 2005 15:53, Johannes Schindelin wrote:
> Okay. What about this config file?
> 
> -- snip --
> 	[myporcelain.headproperties: my/head.name]
> 		merge.candidates = my/other.head
> 	[myporcelain.headproperties]
> 		merge.candidates = blabla for my/head.name
> -- snap --

I am not sure you want to show here. Your example gives

 myporcelain.headproperties.merge.candidates = my/other.head for my/head.name
 myporcelain.headproperties.merge.candidates = blabla for my/head.name

I.e. 2 values for the same variable with the same "for" specification.
This is perfectly valid.

Are you talking about the multiple representations for the same thing?
Then hierarchical config keys already introduce this:

 [myporcelain]
    headproperties.merge.candidates = blabla

is the same as

 [myprocelain.headproperties.merge]
    candidates = blabla
 
> I am not totally opposed to what you are trying, but I think it 
> contradicts the KISS principle.

This suggestion is about easier reading of config files; IMHO far easier
with some use cases; but yes, it is arguable if it's worth an added
complexity of config.c/config-set.c.

And of course this is no issue if config files are only to be written
by git-config-set. But I do not think this was the goal of the config
format.

Josef

> (Note: the restriction that key names must 
> not start with a digit is also a contradiction to that.)
> 
> Ciao,
> Dscho
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
