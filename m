From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 and keyword substitution
Date: Fri, 06 May 2011 20:29:55 +0100
Message-ID: <4DC44C33.7060903@diamand.org>
References: <BANLkTinLW3Ty4n1ODKU-N000q7qQUoSDTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Fri May 06 21:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIQj3-00064b-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab1EFTaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 15:30:02 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab1EFTaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 15:30:00 -0400
Received: by wya21 with SMTP id 21so2642307wya.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 12:29:59 -0700 (PDT)
Received: by 10.216.79.5 with SMTP id h5mr3994137wee.110.1304710199341;
        Fri, 06 May 2011 12:29:59 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id m84sm963797weq.12.2011.05.06.12.29.56
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 12:29:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
In-Reply-To: <BANLkTinLW3Ty4n1ODKU-N000q7qQUoSDTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173002>

On 06/05/11 18:26, Michael Horowitz wrote:
> All,
>
> I was wondering if there is a way to deal with this issue...
>
> It seems that git removes the keyword substitutions from Perforce.
> This is fine, except for the fact that it does not remove them from
> the p4 client shadow.  So, this causes git-p4 submit to fail whenever
> it either deletes a file with keywords (since the file it is deleting
> has the keywords and doesn't match) or lines close to the keywords
> change, such that applying the patch doesn't work.
>
> A Google search turned up a thread from a few years ago where someone
> submitted a patch to make removing the keyword substitutions optional,
> but I guess that patch never got accepted, at least not that I can
> see.
>
> Is there any other way of dealing with this?

I had exactly the same problem only yesterday, and found exactly the 
same thread!

I made a patch to git-p4 which zaps the RCS keywords in the perforce 
checkout if a conflict occurs.

I got as far as something which works if you just delete a line, but 
fails if you delete the entire file. And is a bit ugly.

I was going to ask the exact question you've asked though, to see if 
there's a better way.

Luke
