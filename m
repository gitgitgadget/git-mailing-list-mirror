From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 02:43:31 -0700 (PDT)
Message-ID: <884930.67488.qm@web31803.mail.mud.yahoo.com>
References: <7vps70qpx8.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>,
	Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgJ5-0008UH-Ua
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934275AbXCWJnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934277AbXCWJnd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:43:33 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:41439 "HELO
	web31803.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934275AbXCWJnc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2007 05:43:32 -0400
Received: (qmail 82822 invoked by uid 60001); 23 Mar 2007 09:43:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=yPyJTAdWLUldvipa//JvaN6/Bn7l4zxb0EmuScOLhBjMD2/v98uq9PR8r8Q+BL1D87/CvN99gChMv9m2Ss6OQC/IbzceRu/DnIhkSwrwpOs7aOhGfmfuQP4RguWoh9GPSXNGGZ4o/tbjGOagZ62muI7Uo6T/PHhT9xtc8uccjI4=;
X-YMail-OSG: NzI9qF8VM1mwKCpdXTiTntJUtVuu.DDjr_FdJS6GH0zxeiipT0hBnZ2mbc7x1pLG_rizRrxEV8QzYuRuwfoQTqHlZmSfenEfffPVypX9sn99JC1_STDm851ngPtN3hkfuprSRG2eXYxstTxbIRr_tkTn_g--
Received: from [68.186.59.161] by web31803.mail.mud.yahoo.com via HTTP; Fri, 23 Mar 2007 02:43:31 PDT
In-Reply-To: <7vps70qpx8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42920>

--- Junio C Hamano <junkio@cox.net> wrote:
> > So Luben does seem to have a hook installed, perhaps this is the
> > culprit.
> 
> Thanks for spotting this.  I do not use this hook (well, I only
> use commit-msg, pre-commit, and pre-rebase patches) and it was
> totally outside of my radar.
> 
> It runs describe to find the previous tag, but the parser is a
> bit old fashioned.  It says:
> 
> 	prev=$(git describe "$3^" | sed 's/-g.*//')
> 
> but modern way to say the same is:
> 
> 	prev=$(git describe --abbrev=0 "$3^")
> 
> Luben, sorry for the trouble.
> 
> I do not know how much better the recent hooks--update is
> compared to the version you use.  It is supposed to be backward
> compatible, so you _might_ want to simply update it with the one
> from 'master' after checking if it suits your needs.  Otherwise,
> I think the above one-liner should work the problem around.

Yeah, that's what Andy suggested too.

I guess the problem is that my git repos, especially the web
exported ones are truly of an ancient git...

I'll just update the "update" hook from the most recent "next"
I've got and see if I get this again.

Thanks,
   Luben
