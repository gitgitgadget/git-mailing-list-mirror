From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Re: [PATCH] Remove pdf target from Makefiles
Date: Tue, 18 Jun 2013 19:30:37 +0200 (CEST)
Message-ID: <1169504685.1649588.1371576637888.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Jun 18 19:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uozjv-00079h-UL
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202Ab3FRRak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:30:40 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:50957 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933091Ab3FRRaj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 13:30:39 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id EB4EFAAABA;
	Tue, 18 Jun 2013 19:30:37 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id EB0733480DF;
	Tue, 18 Jun 2013 19:30:37 +0200 (CEST)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E10245B909;
	Tue, 18 Jun 2013 19:30:37 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net E10245B909
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1371576637; bh=MFfsggO2O8XiH85TDq90C4N7Ma3j2Cn0gNhJyfMvI9k=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=R/7KYihV6CvxtuZBErvwGfgF+E4rnSh8cFRnFuz0SjPN6szNqZw/b69/Znq/5eAYK
	 kWkFaoNBqlJKe3dFQW0XzEzSr4IZcCkSLq8PJqNAlR7VCQbdLJYr8jScHLHcA9tfcc
	 1+Cg2YAmOcoP18vWHomgpLaeMIDylZscVTXMSqoA=
Received: from [94.217.25.56] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Tue, 18 Jun 2013 19:30:37 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.25.56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228286>

> 
> If I understood the original commit message correctly, you were saying
> the XML file was not suitable for html generation and you wanted to
> tweak it, and were dropping the PDF target to avoid breaking it.  Now
> if I understand correctly you are saying the XML file actually *is*
> suitable for html generation, and that the html generation rules just
> need tweaking.  In that case, why remove the PDF target?
> 
The latter is correct ;-)
In my commit message I talked about style files meaning
/etc/asciidoc/dblatex/asciidoc-dblatex.xsl and /etc/asciidoc/dblatex/asciidoc-dblatex.sty
which are used when creating user-manual.pdf out of user-manual.xml
and ./Documentation/docbook.xsl which is used for creating user-manual.html
out of user-manual.xml.
When I want to tweak the html generation rules I also have to tweak the pdf
generation rules because html and pdf should be as similiar to each other as
possible. But the pdf rules are global rules so we have to introduce rules
local to git and also tweak both rule sets in parallel.
I asked myself "Is this really worth the effort or should we drop user-manual.pdf 
and spend our efforts better on user-manual.txt and user-manual.html?"
and so came up with this patch ...


---
Thomas
