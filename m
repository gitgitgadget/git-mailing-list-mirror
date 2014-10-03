From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodules and GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Fri, 03 Oct 2014 13:17:09 +0200
Message-ID: <542E85B5.3020101@web.de>
References: <878ul19r5y.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vokac Michal <michal.vokac@comap.cz>
To: Michal Sojka <sojkam1@fel.cvut.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 13:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa0re-0000u7-C1
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 13:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaJCLRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 07:17:24 -0400
Received: from mout.web.de ([212.227.15.4]:50214 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbaJCLRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 07:17:23 -0400
Received: from [192.168.178.41] ([79.193.68.209]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LetUF-1Y19gt2Adr-00qi9Z; Fri, 03 Oct 2014 13:17:20
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <878ul19r5y.fsf@steelpick.2x.cz>
X-Provags-ID: V03:K0:PnjQ1bwqhSbKhyE0trlRR5QL/5hTJUQfiZgHMXPvdnUzFGWsG2r
 eLiqPHkxZw+2arPSDQ2whQXlnvu53h//uMYv5JqKwPy45DaUKbWMqk3P2C+K4lBtMzP/ISl
 TYmdLODdDhJ2ggYxGm/66PPXL/hU6NX7jgf0TalBxXy5Wsp9QUNcoJuyHka6eVPjee2DQGm
 BLPGBgyNV54ng1ExwOu7Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257837>

Am 30.09.2014 um 15:25 schrieb Michal Sojka:
> I'd like to shorten the time needed by our continuous integration (CI)
> tool to clone the source repositories. Currently the full clone takes
> about 10 minutes (even from local server). Our main repository has
> several submodules so the CI tool runs "git submodule update --init". My
> idea was to use GIT_ALTERNATE_OBJECT_DIRECTORIES to cache objects from
> several submodule repositories locally. However, this does not work
> because GIT_ALTERNATE_OBJECT_DIRECTORIES is considered local to the
> super-project and is not propagated to the "git clone" for submodules
> (git-submodule.sh calls clear_local_git_env).
 >
> My question is why is GIT_ALTERNATE_OBJECT_DIRECTORIES considered local
> to the repository? If I could modify the command-line I would use the
> "git submodule update" with the --reference option, which is propagated
> to clones of all submodules. Letting GIT_ALTERNATE_OBJECT_DIRECTORIES
> propagate to the submodules should have the same effect as --reference
> option. So why it is not propagated?

Because then it would /always/ propagate? So while that would have the
same effect as using the --reference option, not using the --reference
option would behave differently, no?
