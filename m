From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git push from client is not updating files on server
Date: Wed, 07 Mar 2012 12:04:13 +0100
Message-ID: <4F5740AD.9080306@ira.uka.de>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>	<4F567DC6.4070903@gmail.com>	<4F567FEF.5000105@gmail.com>	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>	<CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>	<4F569EA8.4050907@gmail.com> <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com> <4F56C946.8080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jerome Yanga <jerome.yanga@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 12:03:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Eee-0006cK-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 12:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab2CGLDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 06:03:32 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46877 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399Ab2CGLDb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 06:03:31 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S5EeJ-0001Ns-C2; Wed, 07 Mar 2012 12:03:30 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S5EeJ-0004sV-5E; Wed, 07 Mar 2012 12:03:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F56C946.8080601@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331118210.363599000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192444>

On 07.03.2012 03:34, Neal Kreitzinger wrote:
> Create a new non-bare clone of your bare repo. Then do git-pull on the
> new non-bare after the bare gets updates (someone does git push to it)
> and you want to test those new commits. The worktree of the new non-bare
> clone can be the document root of your testing virtual host, if that's
> what you're doing. That way, you know that no one else is messing with
> new non-bare (test repo) like doing development in it and messing up
> your tests.

To expand on Neals method, if you do git fetch (periodically in a cron 
job for example) on the cloned non-bare, 'git log HEAD..origin/HEAD' 
will have output only if the non-bare has new commits.
