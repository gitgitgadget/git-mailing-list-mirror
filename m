From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-instaweb: fix mod_perl detection for apache2
Date: Mon, 10 Aug 2009 01:55:34 -0700 (PDT)
Message-ID: <m3iqgwoxq7.fsf@localhost.localdomain>
References: <4C22ECF8-8FBE-4E45-A7CF-EA1203B49AA7@mailservices.uwaterloo.ca>
	<7vprb45ty7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 10:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQfR-00083M-EI
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbZHJIzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZHJIzg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:55:36 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51755 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbZHJIzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:55:35 -0400
Received: by bwz19 with SMTP id 19so2445520bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=HF/7aCiNq330yfdu9jepLbK7j6TpJgyo3l0ZMOyJ1DQ=;
        b=agq1UYpW9xcbARgNgablNucqlNARoEiAieuOC4n1u8wdScdFvSl44pKayvJYERbtVH
         L6tNBo6cn/xi1Xsjew8gecj9KV5ig6TUFa3juz5RuzOaR7PLm4Tyof88r4HLoXakW3kQ
         f7avsMq+gEfGRgW2VH5HpihUGaqf73RWlRMdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gfo65EdsA23eMpcRx1+wIwNBKAam/dkh/6VYN8VHimpD0bsHTBvlgFjIM0X7gbYZnq
         Xx+V71hEQ7PSgzjBY95uNDZb63NiK9yvThVrL8joFmnb3EE/McqfXPVc68Dr9J8jDs8V
         uI2JMn3o75rPv5OEEU5913wakFecvwztSqYrs=
Received: by 10.204.124.7 with SMTP id s7mr5754330bkr.105.1249894535835;
        Mon, 10 Aug 2009 01:55:35 -0700 (PDT)
Received: from localhost.localdomain (abvr219.neoplus.adsl.tpnet.pl [83.8.215.219])
        by mx.google.com with ESMTPS id 19sm6241731fkr.25.2009.08.10.01.55.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 01:55:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7A8smGQ002431;
	Mon, 10 Aug 2009 10:54:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7A8sPYj002421;
	Mon, 10 Aug 2009 10:54:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vprb45ty7.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125421>

Junio C Hamano <gitster@pobox.com> writes:

> Mark A Rada <marada@uwaterloo.ca> writes:
> 
> > The script was looking for something that matched the '^our $gitbin'
> > regex, which no longer exists in gitweb.cgi.
> >
> > Now it looks for 'MOD_PERL', which should be on the line that checks
> > to see if the script is running in a mod_perl environment.
> 
> Thanks.  That sounds like an ancient bug that in turn perhaps suggests
> nobody uses instaweb.  Will apply to 'maint'..

Hmmm... taking a peek at current "Git User's Survey 2009" results
http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2

11. What Git interfaces, implementations, frontends and tools do you
    use?

    git-instaweb  	3%  	77 / 2712

16. How often do you use the following forms of git commands or extra
    git tools?  

    git instaweb 
      never:     1983 - 79%
      rarely:     208 -  8%
      sometimes:   50 -  2% 	
      often:        9 -  0% 	

    Total respondents  	 2506

-- 
Jakub Narebski
Poland
ShadeHawk on #git
