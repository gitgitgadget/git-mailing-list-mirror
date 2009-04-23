From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Thu, 23 Apr 2009 20:57:32 +0200
Message-ID: <20090423185732.GA8433@blimp.localdomain>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com> <20090422082652.GA32698@gmail.com> <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com> <7vr5zk346d.fsf@gitster.siamese.dyndns.org> <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com> <7v4owgyp8x.fsf@gitster.siamese.dyndns.org> <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com> <7vtz4fwzaz.fsf@gitster.siamese.dyndns.org> <81b0412b0904230252k3e8197d3y8798d5b797a49c39@mail.gmail.com> <7vhc0fv2xb.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx48m-0001Wj-0F
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZDWS5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZDWS5q
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:57:46 -0400
Received: from mout5.freenet.de ([195.4.92.95]:43513 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZDWS5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:57:45 -0400
Received: from [195.4.92.10] (helo=0.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #89)
	id 1Lx479-0001Rv-K6; Thu, 23 Apr 2009 20:57:39 +0200
Received: from x6383.x.pppool.de ([89.59.99.131]:46014 helo=tigra.home)
	by 0.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1Lx479-0001tx-8g; Thu, 23 Apr 2009 20:57:39 +0200
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 83450277D8;
	Thu, 23 Apr 2009 20:57:33 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 123D336D28; Thu, 23 Apr 2009 20:57:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhc0fv2xb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117363>

Junio C Hamano, Thu, Apr 23, 2009 16:51:28 +0200:
> Do you think you are in a so minority situation that your "workarounds"
> are valuable for nobody else?  Apparently you see value in letting them
> finding your patches in the archive, so you do not expect them to be
> "nobody else" but rather "a small minority".

Correct, "small minority".

> People on minority platforms have smaller number of people in similar
> situation to ask help from than people on mainstream platforms, and they
> suffer from the minority status of their platforms not only with git but
> about many other things.  Worse, their chance of finding solution by
> digging the archive is smaller, and they would need to spend a lot more
> time, than the people on other platforms.  And you know this a lot better
> than I do ;-).

Well, this particular minority is used to have marginal levels of
technical support and .

> For example, I do not think conversion from Perl exec() to Perl system()
> is worsening the code in any way in difftool.  Sure, it won't *improve*
> things for general majority of people, but as long as it does not hurt
> people (that includes me and others who pay maintenance cost), I do not
> think we should just bury the patch in archive or in your laptop.

Isn't it clearly marked in the archives with the keywords most often
associated with the platform? (they may seem a little... unprintable)

Still, you are, as usual, right. Especially regarding this particular case.

I'll add this comment regarding use of system in the case where exec
is right choice on all accounts and resend the patch:

    # ActiveState Perl for Win32 does not implement POSIX semantics of
    # exec* system call. It just spawns the given executable and finishes
    # the starting program, exiting with code 0.
    # system will at least catch the errors in returned by git diff,
    # allowing the caller of git difftool better handling of failures.
