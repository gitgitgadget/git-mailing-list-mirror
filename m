From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: re-running merge on a single file
Date: Fri, 12 Mar 2010 07:45:29 +0100
Message-ID: <4B99E309.2070603@viscovery.net>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>	 <201003112129.52596.markus.heidelberg@web.de>	 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>	 <m3hbomla3u.fsf@localhost.localdomain>	 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com> <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 07:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npycs-00047U-Jx
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 07:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab0CLGpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 01:45:33 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62473 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753236Ab0CLGpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 01:45:33 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Npyck-00040y-90; Fri, 12 Mar 2010 07:45:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F09C51660F;
	Fri, 12 Mar 2010 07:45:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142023>

Chris Packham schrieb:
> $ git checkout --merge -- cpu/mpc83xx/start.S
> $ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S
> fatal: Path 'cpu/mpc83xx/start.S' is in the index, but not at stage 1.
> Did you mean ':0:cpu/mpc83xx/start.S'?

Both of these work only as long as the index still records the conflicted
state. If you (or one of your tools) has git-added the file, or you have
git-checked-out some version of the file, the conflict stages are lost,
and you must reset --hard and redo the entire merge.

-- Hannes
