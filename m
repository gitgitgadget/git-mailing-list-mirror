From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 02:41:22 +0200
Message-ID: <20090725004122.GA28477@Pilar.aei.mpg.de>
References: <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUVLd-00005L-Py
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbZGYAmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 20:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbZGYAmn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:42:43 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:46278 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbZGYAmm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:42:42 -0400
Received: by ewy26 with SMTP id 26so2107038ewy.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CxrMN1+bqhVg72cxntyibS8JwLSGqLLQiIrPdCDossk=;
        b=RgdDjlGDw8tv4aCwaPCFpoqFgsiQl94EXWicF4NPaYs+bHDi9eSxLRqnNduUbr5UDp
         d8iq5ZTD/3dRc9zLC+ieO1GbgCCxFZlRbwfHW97hFPvWh6wRMdTRzyDBXeVotG8nwhro
         WAQJ9Ht8HwIwcLHG3cUSpvGq/nZp6YYxog6Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gZXRnnycxM+AY4spAcpXhPC7mXKpnMQvf/EZXXVDCDkJL68ElSgAOLOC8etoLqL/dV
         6AmNOqQRElWVL5hwKKBYF5L/vY3sNi6RVVf7LBIJzkZ2qmqtLclWgMG+fD9bYEzk6rof
         6cxywRI+U37emwS4luRrY54jsQGSjGH6WUmIk=
Received: by 10.210.65.16 with SMTP id n16mr5031693eba.87.1248482560471;
        Fri, 24 Jul 2009 17:42:40 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.106.17])
        by mx.google.com with ESMTPS id 5sm1315565eyh.48.2009.07.24.17.42.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 17:42:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090724234648.GA4616@Pilar.aei.mpg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123987>

On Sat 25.Jul'09 at  1:46:48 +0200, Carlos R. Mafra wrote:
> 
> So I guess that my tests here for your NO_CURL=1 idea is inconclusive,
> as I am not sure what preload is prefetching.

Ok, so I killed /usr/sbin/preload and did the tests again. The 
results were much more stable, with average 0.40 vs 0.79
(NO_CURL=1 being faster). The pagefaults were pretty stable too,
(40major+654minor vs 12major+401minor). 

I will use NO_CURL=1 from now on!
