From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 4/5] diff: introduce diff.submoduleFormat configuration
 variable
Date: Wed, 03 Oct 2012 15:45:05 +0200
Message-ID: <506C4161.3040201@web.de>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com> <1349196670-2844-5-git-send-email-artagnon@gmail.com> <506B4418.2050700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJPGM-0001d9-HP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab2JCNpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:45:08 -0400
Received: from mout.web.de ([212.227.17.12]:60622 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755706Ab2JCNpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:45:07 -0400
Received: from [192.168.178.41] ([91.3.173.123]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MOB3E-1TMjBN1988-005gbW; Wed, 03 Oct 2012 15:45:05
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <506B4418.2050700@web.de>
X-Provags-ID: V02:K0:EEG2zlzGm9ttaIeiOSYX/3O0nnIav8UDDYABFQknpQI
 bn6eIRwxxVvubjH80eP1U57jAjsQQ8rOqS6gCokB3NqDPynrnS
 lGrjYlcdS0QOaj+y++NTL9SzV/+CnikJGgy2asWtBJHG4wQdjg
 nZSeasezaoNMymZsnan/xMAheiKk/Rvoi0pg/gC51DlXzU7NKt
 7EQ5G4X3Pup8dKdn6TrLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206894>

Am 02.10.2012 21:44, schrieb Jens Lehmann:
> Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
>> Introduce a diff.submoduleFormat configuration variable corresponding
>> to the '--submodule' command-line option of 'git diff'.
> 
> Nice. Maybe a better name would be "diff.submodule", as this sets the
> default for the "--submodule" option of diff?
> 
> And I think you should also test in t4041 that "--submodule=short"
> overrides the config setting.

We also need tests which show that setting that config to "log" does
not break one of the many users of "git diff" ("stash", "rebase" and
"format-patch" come to mind, most probably I missed some others). I
suspect we'll have to add "--submodule=short" options to some call
sites to keep them working with submodule changes.
