From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: git cherry doesn't list a merge commit
Date: Mon, 13 Feb 2012 16:17:10 +0100
Message-ID: <4F392976.9070009@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 16:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwxeW-0008Ai-To
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 16:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab2BMPRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 10:17:13 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:52088 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab2BMPRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 10:17:12 -0500
Received: from [192.168.1.101] (94-21-245-15.pool.digikabel.hu [94.21.245.15])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Md4Bm-1SFBG12DwI-00IbiD; Mon, 13 Feb 2012 16:17:11 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
X-Provags-ID: V02:K0:ggYq1TdrW6DHCJVFqN228LFN6J576QuzDQAjr2dU3CL
 r9rclTTf5UWpLSjK67uRJSO8IhJlUCp/jwfe4Lp1wKPNqNebI+
 JVr793hjpUgn+cMr4PsBNpLlmfUzLS0Nos2Th/yhl0IRqYAiMm
 CevQJ6CiB9MAmvvYliya57tmC+Z+lBA2oXSeGyd+v5BycPIrJe
 yI5hm3fK4Ti38T+e6bgyJgsm3lOkB8WGaZYnMZD8g5vrhyqG60
 FitZYM09epHZYKYMvHKo/p+1TxLWuyuQA5yuRaByOkP4Yj3r2J
 i2e5JlVsQg/m20/wcR9lZx70JFVHmRCUFq3LhOaNeRUtLRiplc
 a66TlMUtQJCpwizUIESw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190631>

Dear List,

I have a question/misunderstanding about 'git cherry'. The scenario is=20
the following:
I have two repositories (two forks of the same parent repo): A and B. I=
=20
created a commit in A, then pulled B to A and finally made an other=20
commit in A. This resulted the following commits:

-----
commit f6afabb0a734843d5d122b612f0701d27b178e42
Author: akostajti <akos.tajti@intland.com>
Date: Mon Feb 13 15:59:51 2012 +0100

modified a

commit 4ec4d59f632b93456890db139125419d16a10807
Merge: a73e884 2a483e8
Author: akostajti <akos.tajti@intland.com>
Date: Mon Feb 13 15:59:34 2012 +0100

Merge branch 'master' of http://localhost:3180/git/first-60-project

commit a73e884d2dadf29898c2d6b665ed79d352422d26
Author: akostajti <akos.tajti@intland.com>
Date: Mon Feb 13 15:58:48 2012 +0100

hkl
-----

Now If I fetch B to A and run 'git cherry FETCH_HEAD master' I get only=
=20
two changeset ids:
+ a73e884d2dadf29898c2d6b665ed79d352422d26
+ f6afabb0a734843d5d122b612f0701d27b178e42

However, the manual of git cherry says:
"*Every* commit that doesn=E2=80=99t exist in the <upstream> branch has=
 its id=20
(sha1) reported, prefixed by a symbol. The ones that have equivalent=20
change already in the <upstream> branch are prefixed with a minus (-) s=
ign"

In my understanding this means that the merge commit=20
(4ec4d59f632b93456890db139125419d16a10807) should be also listed by=20
cherry, because it doesn't exist in the upstream. Am I doing something=20
wrong? How can I ge git cherry work as I expect?

Thanks in advance,
=C3=81kos Tajti
