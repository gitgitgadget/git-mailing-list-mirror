From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 11:45:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com> <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Janusz Harkot <janusz.harkot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 11:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjnwS-000751-T4
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 11:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab3FDJyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 05:54:07 -0400
Received: from giant.haxx.se ([80.67.6.50]:34870 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab3FDJyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 05:54:04 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2013 05:54:04 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r549jQ9R031438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jun 2013 11:45:26 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r549jQ3s031420;
	Tue, 4 Jun 2013 11:45:26 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226337>

On Tue, 4 Jun 2013, Janusz Harkot wrote:

> Strange was, that initial communication was OK (http GET), but when there 
> was http POST - git reported error (incorrect certificate). The only 
> workaround was to disable certificate verification.
>
> My question is: does git support SNI on the https? If so - are there 
> (undocumented) options to make it work?

It does. git uses libcurl for the HTTPS parts and it has support SNI for a 
long time, assuming you built libcurl with a TLS library that handles it.

Which libcurl version and SSL backend is this? (curl -V usually tells)

If you made it working by disabling certificate verification then it sounds as 
if SNI might still have worked and the problem was rahter something else, as 
without SNI you can't do name-based virtual hosting over HTTPS - but perhaps 
you wanted to communicate with the "default" server on that IP?

-- 

  / daniel.haxx.se
