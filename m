From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 00:39:11 +0100
Message-ID: <200803170039.14634.jnareb@gmail.com>
References: <20080313231413.27966.3383.stgit@rover> <200803161937.07082.jnareb@gmail.com> <1205707048.2758.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb2SB-0006kI-Lf
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 00:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbYCPXjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 19:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbYCPXjI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 19:39:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:56729 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYCPXjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 19:39:06 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1488884fgb.17
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=vgQni/e9mQ+z4MKiITMBQNbShqX4cw53pEL9jbXlr5U=;
        b=A+iB9xiS1oxyUupMOHFGnE8ddVJnGwiAmhwqdsV9yDUu4yu3GHcaIB1TgPM9EcUqcR7XQ12C0dTFV9eGlZeFn40delBnXXT0wSVZJRL4Az3vau/UkzGowkeuLLd6oUOuBOjMevJsJj2y3nXf22l+vKTs8aP5dCZjp86yUnSp9s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PZH9t1bM3R9E/WZ4KwkoDjTbyT7jwqSWFfFGsjFYsmySUKBdWu2MaMJk5Kjkdmjw/9WTT1jm223GDC0OpytALTx+UgFCWAye+bkcS/viyHdjS55XjpzdBvDWnYPpTJWoOqxqus3v5YDMcFkpkkUYeTpuyVApsSKyPMqDZ2zOZv8=
Received: by 10.82.174.20 with SMTP id w20mr34109660bue.14.1205710744927;
        Sun, 16 Mar 2008 16:39:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.138])
        by mx.google.com with ESMTPS id f13sm12105029gvd.9.2008.03.16.16.39.02
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Mar 2008 16:39:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1205707048.2758.35.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77403>

J.H. wrote:
> Jakub Narebski wrote:
>>
>> P.S. When searching CPAN for existing modules for caching and CGI
>> caching I have found Cache::Adaptive::ByLoad which does what
>> caching-gitweb does,

I'm not sure about quality of this code, though. It uses Cache::Cache, 
by the way.

>> and some solutions in newer caching interfaces, 
>> either CHI or Cache, which try to avoid thundering horde problem.
> 
> Interesting - my have to take a look at that.

CHI uses either 'busy_lock [DURATION]' (bump expiration time), or
'expires_variance [FLOAT]' for fuzzy expiration time matching.

Cache has LRU and FIFO removal strategies.

-- 
Jakub Narebski
Poland
