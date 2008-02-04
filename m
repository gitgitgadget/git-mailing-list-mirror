From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Mon, 4 Feb 2008 00:06:09 -0800
Message-ID: <402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	 <402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	 <7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 09:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLwLl-00076n-9N
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 09:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYBDIGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 03:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYBDIGM
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 03:06:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:58187 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbYBDIGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 03:06:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1923912fga.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u3gvy28peKkSLZCqb40h4ptWYDRTf7CeZqnav4dKzKg=;
        b=NJ6H4Ky1Gj8fSCBiqD73Vm6Lr0X1mWjy2C1nn8d2dQfzcs7pQsK2MiLLCEA1g7winFEmPF+ZgR0lTh1PCErx/y9RhEEgOGzPvX8NeFSy0ZP+UQ9GlCfr9RmGKg72tl0I/nKs28lIC1KxgCLLetJvzMUsJlz9U9DUUqlLR+mU+dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SNsoj2MeM9AckfpzM+qRI0jXUXwT68y0pGLWQgqvpXSRsPi30sKufuAim49Hda7kDpBwFcpVfGDVuRKySYKsSYN/KhzB2cdtnHCkLTGaNAYMkbG/OgHZGhD0X+Mo+TsZ9N69fxi0NDsPhRELudfH10xSxuIRT1wYuZ6GecMcWhA=
Received: by 10.82.107.15 with SMTP id f15mr12581049buc.0.1202112369085;
        Mon, 04 Feb 2008 00:06:09 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Mon, 4 Feb 2008 00:06:09 -0800 (PST)
In-Reply-To: <7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72475>

On Feb 3, 2008 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Please make the next round an in-line patch.  Attachments cannot
> be commented on, and an RFC patch is all about getting comments,
> not about being included.  Whitespace breakages do not matter as
> much as the final submissions; readability and commentability
> matters more.

I will post an update in a few days, with a few bug-fixes.

> Instead of adding many new sub-strategies at once, I think it
> would make it easier to review to split the patch into (1) code
> movement without adding any functionality changes to make your
> further changes easier, if such a change is needed in your work
> (I did not really look at the attachment carefully), (2) add
> logic to find out the set of independent parents to remove
> redundant parents (perhaps using show-branch --independent? I
> dunno) and conditionally use it, (3) add infrastructure to allow
> adding different --ff=<what-to-do>, and then finally (4) a
> separate patch for each of <what-to-do>.

The patch is not easy to read for git-merge.sh.  You really need to
apply the patch and then review the code.  If I follow your suggestion
above it might be easier to read the patches.  I will do if tthere is
a demand for a split.  However, it might take some time.  What is the
time-frame for inclusion in 1.5.5?

> I suspect (2) is controversial if made unconditional.  Some
> people do not even like the fast-forward "merges" we have
> traditionally done.

--ff=never will turn this off together with fast forward.  Maybe we
should have --ff=traditional that is the old behavior.

-- 
Sverre Hvammen Johansen
