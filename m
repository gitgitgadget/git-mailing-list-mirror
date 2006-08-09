From: Alan Larkin <nobrow@eircom.net>
Subject: Re: setting up a git repo on apache
Date: Wed, 09 Aug 2006 18:01:51 +0100
Message-ID: <44DA14FF.7080402@eircom.net>
References: <44DA060B.2050601@eircom.net> <Pine.LNX.4.63.0608091831320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 19:02:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GArRN-0004bm-3r
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWHIRBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 13:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWHIRBx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 13:01:53 -0400
Received: from mail04.svc.cra.dublin.eircom.net ([159.134.118.20]:8495 "HELO
	mail04.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S1750878AbWHIRBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 13:01:52 -0400
Received: (qmail 51161 messnum 5271304 invoked from network[193.1.133.115/affront.ucd.ie]); 9 Aug 2006 17:01:51 -0000
Received: from affront.ucd.ie (HELO ?193.1.133.115?) (193.1.133.115)
  by mail04.svc.cra.dublin.eircom.net (qp 51161) with SMTP; 9 Aug 2006 17:01:51 -0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0608091831320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25127>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 9 Aug 2006, Alan Larkin wrote:
> 
>> $ git push http://localhost:/webdav/git/myproj master
>> Error: no DAV locking support on remote repo
> 
> What do the access_log and the error_log say about this?
> 
> It could also be that you have a "Require valid-user" somewhere in there 
> by mistake.
> 
> Further, you might want to check if it works _with_ authentication (I 
> never tried without, and I am not sure if it should be allowed to begin 
> with).
> 
> There is a recent thread by Junio, Rutger and me, which might help you:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/24816/focus=24861
> 
> Hth,
> Dscho
> 
> 
> 

I initially had authentication in place (which was working insofar as I
couldnt browse the repo without logging in) but I removed it to simplify
the process of tracking down the DAV problem. I have also removed all
.htaccess files so nothing can be overriding apache2.conf and that only
contains:

<Directory /var/www/webdav>
	Order allow,deny
        Allow from localhost
        DAV on
</Directory>


Ill look into that previous thread. Apologies for not finding it before
posting.
