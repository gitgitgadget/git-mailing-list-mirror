From: Enrico Weigelt <weigelt@metux.de>
Subject: incremental push/pull for large repositories
Date: Sat, 10 Jul 2010 05:12:59 +0200
Message-ID: <20100710031258.GA554@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 05:23:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXQes-0002Sl-Qy
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 05:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab0GJDXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 23:23:14 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:37002 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151Ab0GJDXN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 23:23:13 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6A3NB5S017976
	for git@vger.kernel.org; Sat, 10 Jul 2010 05:23:11 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6A3CxJY004776
	for git@vger.kernel.org; Sat, 10 Jul 2010 05:12:59 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150707>


Hi folks,


I often have situations where I've rebased branches with large files 
(10th of megabytes per file) and pushing them to the remote. Normally 
these files themselves stay untouched, but the history changes (eg. 
commits reordered, several changes in smaller files,etc).

It seem that on each push, the whole branch is transferred, including
all the large files, which already exist on the remote site. Is there
any way to prevent this ?

IMHO it would be enough having a negotiation on which objects really
have to be transferred before creating and transmitting the actual
pack file. That would save _much_ traffic (and transmit time) for
those situations. 

This could also be used to remotely repair broken repositories: 
just repack leaving off the broken objects and fetch the missing
ones from remotes.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
