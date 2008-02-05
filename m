From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: [Bug?] uncommited changes cross branches
Date: Tue, 5 Feb 2008 15:34:09 -0500
Message-ID: <140813C2-123F-48CB-99CC-4E9A9B6C33B9@gmail.com>
References: <CB070331-8CA6-42CD-9CAD-20371F16DCD8@gmail.com> <alpine.LSU.1.00.0802051502360.8543@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:34:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUVE-0002Il-J8
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbYBEUeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbYBEUeQ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:34:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:8308 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbYBEUeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:34:14 -0500
Received: by nf-out-0910.google.com with SMTP id g13so576065nfb.21
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=hsnKQJzx+saKuIvn2gnoaKURcV7/XNZVCVzwVddEh8s=;
        b=CY4eM7ClUQzVxK1Fa6Hu//gmj/wN6y0cAtcCuNimYD1yFJc4gF+z+uC8ig53Tr2k7WuurHwK0pUH4zsVzSElMphbDJvXPnkCyyrrGqg2esFeFnbgXCh8AnSuxV3EZZtrTdNQBmhWvUebOZG4UwjwDCgt9UlPpLBLtnRhP6P+2UY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=hBQtJCV49xlQblm8RojyBLizvFPBsK/LYZzUbbe2l3m7ZAlit3nu2DUkGDs2+v82yQwoaLiu5FtW4lQYg300semYsdLi0R60Uqd++sT1iSHn0Ps/Too/G5LyK62NEv/dUzUg0kEtCljakJX2qbfkjYEvJbuwgbuRxKaxYL/07+g=
Received: by 10.78.138.14 with SMTP id l14mr15729472hud.57.1202243652518;
        Tue, 05 Feb 2008 12:34:12 -0800 (PST)
Received: from ?172.30.1.160? ( [80.67.64.10])
        by mx.google.com with ESMTPS id p28sm3102542hub.59.2008.02.05.12.34.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 12:34:11 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802051502360.8543@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72689>


On Feb 5, 2008, at 10:07 AM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 5 Feb 2008, Rhodes, Kate wrote:
>
>> If you have a file that exists in two branches in the same repo,  
>> make a
>> change to it without committing, then switch branches the changes  
>> carry
>> over, but if you make changes to a file that exists in only one of  
>> the
>> repos and try and switch branches Git complains that the file isn't
>> uptodate.  The latter behavior seems correct to me.
>
> It is slightly different: if you change a file without committing _- 
> and-
> the switch to another branch does not touch the file, git does not
> complain.
>
> The rationale: git should refuse to switch branches _only_ if  
> uncommitted
> changes would be lost.
>
> However, if you change a file whose content is different in the other
> branch (and "not existing" qualifies), the uncommitted changes would  
> be
> lost, and git should complain.

That makes sense, but I wonder if the distinction isn't a little too  
subtle for most users to pick up on without being told, and if letting  
uncommitted changes cross branches without some explicit user approval  
is a good idea. I assume that once someone becomes really used to  
working with multiple branches within the same repo you'd build up  
subconscious safeguards against accidentally pulling changes into a  
branch you didn't mean to, but I worry that it's going to be  
problematic for users starting out with git.

To me it's like the difference between -d and -D in git-branch. It's  
generally a good idea to use -d by default and have git warn you that  
you're about to do something that could screw you up.

-kate == masukomi
