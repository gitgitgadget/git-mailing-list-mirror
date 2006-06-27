From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs importer woes
Date: Tue, 27 Jun 2006 22:42:38 +1200
Message-ID: <46a038f90606270342k2288cc2ds34ae05e089b8c906@mail.gmail.com>
References: <44A102F0.9090604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 12:43:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvB1s-0000QU-IB
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbWF0Kmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWF0Kmp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:42:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11050 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932775AbWF0Kmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 06:42:45 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2511874ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 03:42:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qjyrX7WxvsVNQ4yVxlOweIcb2q0DmieI7SljkxxcSwC/5z9iVqn34QTEaFStkqwjadOP9myX7uBnNtiGiU/A4A1+fPhAJ7lrCYEKAb0JvjWBTjRJHa4KUumAcrUWTrc1ROm0lyqsH5wl5AjQDLc3crUwBLvc3Vl9t45n+Jl1xZY=
Received: by 10.78.164.13 with SMTP id m13mr2444114hue;
        Tue, 27 Jun 2006 03:42:43 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 27 Jun 2006 03:42:38 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <44A102F0.9090604@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22725>

On 6/27/06, Andreas Ericsson <ae@op5.se> wrote:
> Sadly, the cvsimport command no longer works to create new repositories
> from scratch.

We are seeing some breakage in cvsimport that started with a patch of mine:

 8f732649bc4d5619a1b399e5808b3f4c662ad200 cvsimport: keep one index
per branch during import

so I'd say that if you are using cvsimport, stick to the v1.4.0
version. You can do

  git-cat-file blob v1.4.0:git-cvsimport.perl >git-cvsimport.perl

> problem seems to be firstly 061303f0b50a648db8e0af23791fc56181f6bf93.

Yes, that commit will break brand new imports, but it's trying to
fixup breakage that started with my patch. It shouldn't be too hard to
fix up, but real life is interfering.

> Oh, now it's done (4 minutes for 620 revisions with automated testing
> between good/bad. *LOVE* bisect).

Love bisect too for easy-to-test cases.

> The culprit is definitely 061303f0b50a648db8e0af23791fc56181f6bf93.
>
> Any perl-literate takers? Otherwise, just reverting the patch makes
> things work (for me) again.

Don't just revert that patch, unless I'm wrong there is some subtle
branch-creation breakage too.

cheers,




martin
