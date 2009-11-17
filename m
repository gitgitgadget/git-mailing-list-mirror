From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bash completion on 4.0 broken?
Date: Tue, 17 Nov 2009 10:54:50 +0100
Message-ID: <4B0272EA.5020708@drmicha.warpmail.net>
References: <4B0246C7.6020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 10:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAKmy-0001I0-Kc
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 10:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZKQJzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 04:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZKQJzo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 04:55:44 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43454 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306AbZKQJzn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 04:55:43 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 88B73BFC7B;
	Tue, 17 Nov 2009 04:55:49 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 17 Nov 2009 04:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vXOaLf3fsdsn9C0BjX7haz91vHg=; b=ewhxI2hy7980cno9Rey4myH9mfYevl+/khJ0NCm/tIhqw6tV6fHwdAcU/nBnZ5diAa1UOUqcjTFM9PyzWvmwmJQ9S+OF66pngjUSP46w3Vhs93zJ2RPXqsR/0hp8INRUkIR+mBn2+TBNn1Ynp9jmA7y+IH5zBxuPLE5BTLgI3oM=
X-Sasl-enc: 4I6o1VnF2Cl6Nrp8nlSk7USBHsMqxxyMrVaslUfXOW/X 1258451749
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC3154B21B9;
	Tue, 17 Nov 2009 04:55:48 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <4B0246C7.6020401@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133085>

Stephen Boyd venit, vidit, dixit 17.11.2009 07:46:
> When I try
> 
>     git show --pretty=<TAB><TAB>
> 
> I get a list of filenames and not the list of pretty formats.
> 
> I've debugged a little and see that the cur variable in _git_show () is 
> set to '=' when it should be '--pretty='. So it looks like something is 
> causing the command line to be split weirdly. Looking at the bash 
> NEWS[1] for 4.0 I see
> 
> i.  The programmable completion code now uses the same set of characters as
>     readline when breaking the command line into a list of words.
> 
> 
> which causes me to believe this is why it's broken now. I've tried 
> removing '=' from COMP_WORDBREAKS and that shows the list of formats 
> correctly, but then causes the entire '--pretty=' to be replaced with 
> the selected format.
> 
> Anyone else seeing the same problem or is my system just b0rked?
> 
> $ bash --version
> GNU bash, version 4.0.35(2)-release (x86_64-pc-linux-gnu)
> 
> References:
> [1] http://tiswww.case.edu/php/chet/bash/NEWS

Ouch, just when I decided to use completion rather than a bunch of
aliases it stops working. B0rked here 0ls0 on Fedora 12 (with git.git's
next):

GNU bash, Version 4.0.33(1)-release (x86_64-redhat-linux-gnu)

Command name completion and prompt magic do work.

Michael
