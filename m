From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Linking two remote repositories
Date: Fri, 12 Mar 2010 17:10:07 +0100
Message-ID: <4B9A675F.6050309@web.de>
References: <loom.20100312T145901-192@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pavel <paullus325@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 17:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq7RN-0000hY-R7
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 17:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806Ab0CLQKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 11:10:13 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:48025 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab0CLQKM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 11:10:12 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4C784143E9E65;
	Fri, 12 Mar 2010 17:10:10 +0100 (CET)
Received: from [80.128.53.45] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nq7RC-0007C1-00; Fri, 12 Mar 2010 17:10:10 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <loom.20100312T145901-192@post.gmane.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+8d7H/gSyKFXasrOIwNnzmACGL1SpHLHfJbitF
	o8WaUTUsSybLOMvHxQwpmYd4XGrZiX2+9oaJtDT0MXKqUw4CaW
	VaxuAy7Sj+o1esMWobWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142039>

Am 12.03.2010 15:09, schrieb Pavel:
> Hi All,
> I'm just investigating of using git for following:
> We have two development teams in far direction from each other and very slow
> network connection between them. Currently they are using one Subversion
> repository on one side, but committing from other side is very-very slow. 
> 
> The idea is to setup two git repositories in two locations and developers will
> commit in there local repository. But what I can't figure out it's how to
> connect those repositories between each other, I do not want to have two
> "special" people to push between remote repositories. 
> Is there any ideas how to connect two repositories and have actual code versions
> on both of them ?

Having a similar setup at my dayjob, I think it should be sufficient to
have only one git server (maybe at the location where your svn-server is
now). As git keeps a local copy of the whole repo operations like commit,
diff and merge are fast and independent of network speed. Only clone, fetch
and push go over the slow network connection, but for us this is fast
enough (and a lot faster than our old RCS based VCS, which was basically
unusable for this scenario).
