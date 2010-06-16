From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: No working tree repository
Date: Wed, 16 Jun 2010 09:36:27 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006160933270.10800@ds9.cixit.se>
References: <4C17BEB7.90403@cfl.rr.com> <vpqy6egi2va.fsf@bauges.imag.fr> <4C17C77C.9000002@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 10:36:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOo71-00045P-AM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 10:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab0FPIgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 04:36:37 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:51774 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752378Ab0FPIgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 04:36:36 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o5G8aSsa020859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Jun 2010 10:36:28 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o5G8aRRx020855;
	Wed, 16 Jun 2010 10:36:28 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4C17C77C.9000002@cfl.rr.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 16 Jun 2010 10:36:28 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149258>

Phillip Susi:

> It seems that --bare on clone will prevent the checkout of the local 
> working tree. If I decide I do want the sources today I can just check 
> them out, but what is the proper way to do the reverse?

Then I would recommend creating another clone. I usually do a

   git clone --reference path/to/bare server:path/to/origin newcheckout

to create clones with working trees, without having to pay the penalty of 
having (yet) another copy of the objects under .git (and with .git in the 
order of 400 megabytes, and several working copies, it does pay off).

Maintaining this is a lot easier than constantly adding and removing a 
working tree from the repository.


If you only need a single file, "git show commit:path" should work, even on 
a bare repository.

-- 
\\// Peter - http://www.softwolves.pp.se/
