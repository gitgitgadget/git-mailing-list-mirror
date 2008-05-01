From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 16:30:24 +0100
Message-ID: <e1dab3980805010830l49e7d126pa4de831c174eda0c@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
	 <20080501150958.GA11145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 17:31:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrake-00052E-RA
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762103AbYEAPa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762093AbYEAPa2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:30:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:44532 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762054AbYEAPa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:30:26 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1741425ugc.16
        for <git@vger.kernel.org>; Thu, 01 May 2008 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tol2k1eecticrXW44OCN8XhtaiayIC8gvyZyWRlS2Qk=;
        b=fCGF6fM9q5SthUYrTNvn5Nsy94Ne/ZVXD1hYllexDN28/SDdk9HNCRIujlUFYYFNW/ZNiklAYZtQiodQ/aAvtUr8Fn8oQVhy3GXYH/TaGOwdtia+6vSNEPS0och+f8yB/q07G/VAWjY4XM7LDhd5hJoCLKvSYd3ba1d9BYZ90L4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqsFiFEjYBSnuP4uP0hDiqiV82JiC4wfFBeLjdshG+hj83hNjPX9FaZnyjqVuBKvZINrcWbwuE9rKsOUHTl0mvHg6+RuYEPwtJ9ZzduKevPCqduYCuMuOgx3ESbXcwGrfXya9zPXq3dSMfjjU2+E5UrFizdd55Y9AKhE26VbC2w=
Received: by 10.150.206.21 with SMTP id d21mr2355377ybg.227.1209655824333;
        Thu, 01 May 2008 08:30:24 -0700 (PDT)
Received: by 10.150.225.18 with HTTP; Thu, 1 May 2008 08:30:24 -0700 (PDT)
In-Reply-To: <20080501150958.GA11145@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80922>

On Thu, May 1, 2008 at 4:09 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 01, 2008 at 05:54:06PM +0300, Ittay Dror wrote:
>
>  > Also, would anyone like to comment on:
>  > http://www.markshuttleworth.com/archives/123 (Renaming is the killer app
>  > of distributed version control
>  > <http://www.markshuttleworth.com/archives/123>)?

I'll just make the obvious point that he's talking about a problem and
an underlying cause:

The problem is not being able to successfully merge branches as time
goes by when one branch has had some renaming. He's decided the root
cause is not have an explicit representation of renames which would
enable the merges to succeed. So there are two questions:

1. Does development often happen where files get renamed and then
modified significantly in a distributed fashion but it is still
sensible to automatically merge the results?

2. Do you need explicit rename tracking to do an automatic merge in those cases?

I suspect that for 2 you don't in theory but considering all the
non-obvious possibilities would slow down the normal case of a
standard merge.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
