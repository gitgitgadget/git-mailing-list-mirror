From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Fri, 15 Feb 2008 13:43:03 -0500
Message-ID: <76718490802151043q56340ea9i247dbb1601f8d225@mail.gmail.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.LSU.1.00.0802151035100.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:43:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ5XD-00028k-8a
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbYBOSnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbYBOSnH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:43:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:51705 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbYBOSnF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:43:05 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1194720wra.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QqVkSOfVx2NVsXflWZZMvwkgYDQw47Sre2LN0mk14lY=;
        b=vTIvv3fe+WJ8D6NSdIt5dk6cXcHNHrwSXrBe+nXjEriANW59c8b3a/4CHEyMrDE1ujk1g+X51sTKt9NGGNzO4RmX9Yz/XdLQVtQf/ROPITLn1uC3bVcUn/+eTEuWevA9z5yHMWClrSmV6VHeZ6h8hFSCByKcx1avs7dHAh4XKRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZXbfS5lnGIQXhTXIgfABUwHH7WO2uS88mPjOztGLTvP+xeZ50AR+BsPFSUwrqOHG3e+Hr3A/TZ2cp+mM48fPu6ScCiyXZwEWquSJCaJQSAYXpHEiulVp0c2/3ITeMW74zgrSHe28LcHe+qPjnq4uf5oOL7/wkL7zR73a5IM6O4=
Received: by 10.114.89.1 with SMTP id m1mr3294102wab.77.1203100983496;
        Fri, 15 Feb 2008 10:43:03 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 10:43:03 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802151035100.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73975>

On Fri, Feb 15, 2008 at 5:41 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  > +             char *cp = line;
>  > +             while (*cp == '>' && *cp != 0)
>  > +                     cp++;
>
>  How about using strchrnul()?

Actually strchrnul() here isn't correct. I want to strip leading '>'
only. strchrnul() will search for the first occurrence (skipping over
non-'>' to do so), which is not what I want.

>  > +                     while (*cp != '\n' && *cp !=0)
>  > +                             cp++;
>
>  Again, this is the job for strchrnul().

Yep, here strchrnul would be fine.

j.
