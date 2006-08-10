From: Alan Larkin <nobrow@eircom.net>
Subject: Re: setting up a git repo on apache
Date: Thu, 10 Aug 2006 10:43:06 +0100
Message-ID: <44DAFFAA.9040507@eircom.net>
References: <44DA060B.2050601@eircom.net> <Pine.LNX.4.63.0608091831320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 10 11:43:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB74K-0000N5-VZ
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 11:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWHJJnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWHJJnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 05:43:09 -0400
Received: from mail01.svc.cra.dublin.eircom.net ([159.134.118.17]:6182 "HELO
	mail01.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S1751491AbWHJJnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 05:43:08 -0400
Received: (qmail 77161 messnum 7071036 invoked from network[193.1.133.115/affront.ucd.ie]); 10 Aug 2006 09:43:06 -0000
Received: from affront.ucd.ie (HELO ?193.1.133.115?) (193.1.133.115)
  by mail01.svc.cra.dublin.eircom.net (qp 77161) with SMTP; 10 Aug 2006 09:43:06 -0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0608091831320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25176>

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
For the record, I followed the steps in the above linked thread as
closely as possible but the problem persists. It did however contain the
suggestion to use litmus to test the webdav and thats proving curious
insofar as several tests are failing, but in a not entirely reproducible
way. I mean, on one test I might see

14. cond_put.............. FAIL (PUT conditional on lock and etag
failed: 412 Precondition Failed)
15. fail_cond_put......... pass
16. cond_put_with_not..... pass
17. cond_put_corrupt_token WARNING: PUT failed with 400 not 423
    ...................... pass (with 1 warning)
18. complex_cond_put...... FAIL (PUT with complex conditional failed:
412 Precondition Failed)

and if run again I might see

14. cond_put.............. pass
15. fail_cond_put......... pass
16. cond_put_with_not..... pass
17. cond_put_corrupt_token WARNING: PUT failed with 400 not 423
    ...................... pass (with 1 warning)
18. complex_cond_put...... FAIL (PUT with complex conditional failed:
412 Precondition Failed)

and on another a different combination.

But this has no real place here, so I shall off and try find the
solution elsewhere and post back if its relevant.

Thanks for the help.
