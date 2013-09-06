From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Problem setting up a shared git repository
Date: Fri, 06 Sep 2013 09:43:32 +0200
Message-ID: <522987A4.1090702@viscovery.net>
References: <1378417432.91149.YahooMailNeo@web161803.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eyal Zinder <ezinder@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 09:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHqhn-00087M-R9
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 09:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727Ab3IFHng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 03:43:36 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254]:43800 "EHLO
	theia.linz.viscovery" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750717Ab3IFHnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 03:43:35 -0400
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0721416613;
	Fri,  6 Sep 2013 09:43:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1378417432.91149.YahooMailNeo@web161803.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234029>

Am 9/5/2013 23:43, schrieb Eyal Zinder:
> I'm trying to setup a distributed development repository with a central
> repository acting as the production copy.  I'm doing so on a Windows
> file share with no SSH / HTTP accessibility.  Basically each developer
> will have their own copy of the project, and the shared drive should
> have a copy of the master copy (prod/master branch), along with the
> work-tree files.
> 
> The idea is that any developer should be able to do independent
> development, staged commits, etc.. then push to the central (origin)
> repository, and production scripts will reflect these changes upon a
> push.
> 
> I got pretty close to this setup by creating a bare repository on the
> file share server (f:\GitDBs\foo.git), then cloning the bare repository
> onto the production path like so: git clone f:\GitDBs\foo.git foo

The setup sounds reasonable.

> I cloned the bare repository just the same onto my local dev path.. and
> proceeded with development. This worked fine, and I was able to push /
> pull changes into "origin" (bare repo), and then I would go to my prod
> (f:\foo) repository (clone of bare f:\GitDBs\foo.git), then pull the
> changes..

So far my understanding is that your production directory only ever issues
pulls from the bare repository. That is OK.

> The problem I faced later on was in parallel development, when changes
> were made to a file in one repository, and at the same time other
> changes made to the same file in another repository..  I couldh't push
> changes from the dev\foo to prod\foo or to origin..

Define "couldn't push". What are the error messages? Is it important that
it is *the same file* to which changes were made at the same time?

Do you have receive.denyNonFastForwards set in the bare repository?

> I'm completely lost at the moment.. I try to set --git-dir or
> --work-tree and I get mixed results..

Don't do that, it should not be necessary in your setup.

-- Hannes
