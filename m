From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Changing branches in supermodule does not affect submodule?
Date: Tue, 13 Oct 2009 15:11:01 +0200
Message-ID: <4AD47C65.5080904@web.de>
References: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 13 15:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxhKE-0007WZ-1B
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 15:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945AbZJMNSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 09:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759838AbZJMNSJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 09:18:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:44099 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759826AbZJMNSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 09:18:09 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id B859512F67E2D;
	Tue, 13 Oct 2009 15:11:05 +0200 (CEST)
Received: from [80.128.110.99] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mxh9d-0006Sh-00; Tue, 13 Oct 2009 15:11:05 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18qjYq5NW/KlybVY8jHHm7TbHAzUCMe0GYUMHZM
	dBu2R/CUuvhCK0b3bKxQOD2JvS1pOYeSb90sUGQ7SpMpCA06Ya
	5BAg0YUgnOhwPlTfGwDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130162>

Peter Krefting schrieb:
> If I have a repository with submodules that is in a clean state, and
> switch branches in the super repository, the submodules are left in the
> state they were in before I switched branches (with 1.6.4, at least). Is
> this the expected behaviour?

Yup, submodules have to be updated separatly.

When they are cloned from a remote with "git submodule add" followed by
a "git submodule init", just calling "git submodule update" every time
you want the submodule to be updated according to the state committed
in the superproject will do the trick (but keep in mind that all
referenced commits have to be accessible in the local clone of your
submodule, so you might have to do a fetch there once in a while).


Jens
