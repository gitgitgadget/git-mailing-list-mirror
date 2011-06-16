From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git clone and submodules
Date: Thu, 16 Jun 2011 20:02:46 +0200
Message-ID: <4DFA4546.1020905@web.de>
References: <4DFA017A.5070206@micronengineering.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Massimo Manca <massimo.manca@micronengineering.it>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:03:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXGuI-0003zs-O1
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758552Ab1FPSCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:02:54 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41654 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758540Ab1FPSCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:02:51 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 60DC81925EAD5;
	Thu, 16 Jun 2011 20:02:49 +0200 (CEST)
Received: from [93.240.117.200] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QXGu1-0000sy-00; Thu, 16 Jun 2011 20:02:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DFA017A.5070206@micronengineering.it>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19G6HUQ5yzkDE2RfPGUDKMttxjPfOzvi/ylbtrY
	qAnG9ruiFmbFV+Yjs/NPLAn8f1xZEQrxQ3ioe8ud8i1K4C//sB
	PXthwyvw1US4fNVXfORw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175909>

Am 16.06.2011 15:13, schrieb Massimo Manca:
> 2. RepoWR will contain a complex project developed by several engineers
> and made of some subprojects (already existent) and some libraries. I
> would manage them as submodules, these are my intents:
> a) the library mclib (about 50 c files) has its repo on a different
> location, I would "connect" its repo inside RepoWR as a submodule
> because I am sure that we need to modify/extend the library and we would
> to have the ability to modify it and propagate modifications to its
> repo, forcing all users of mclib to see the modifications and to repeate
> their regression tests

That sounds like submodules would fit in nicely here.

> How can implement this situation? Where can I find info or documentation?

http://progit.org/book/ch6-6.html
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#submodules

And for questions not answered there feel free to ask.

> b) every module (not more the 4-5 c files) will be developed and unit
> tested, so normally every engineer makes a unit test project
> implementing/using the module to test with TDD workflow. During the
> progress of the work the modules must be added and committed to RepoWR;
> the modules are on the working directory of RepoWR (RepoWR\src) and the
> test files on a specific subfolder (RepoWR\TestModuleOne\src).
> Is this a viable solution or are there hidden problems and so better
> solution to implement?

Did I get that right that the test files should not be put in the same
submodule (= directory tree) where the to-be-tested code lives? To me
it makes more sense when the tests and the code that is tested live in
the same submodule.
