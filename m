From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 07:41:52 +0100
Message-ID: <53102FB0.6040603@viscovery.net>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>	<530FA0C1.3000109@web.de>	<530FBB1D.3050505@gmail.com> <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lee Hopkins <leerhop@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJH96-0000cw-46
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbaB1GmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:42:04 -0500
Received: from so.liwest.at ([212.33.55.19]:59107 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbaB1GmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:42:03 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WJH8r-0005g9-SK; Fri, 28 Feb 2014 07:41:53 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 79B1516613;
	Fri, 28 Feb 2014 07:41:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242892>

Am 2/28/2014 0:38, schrieb Lee Hopkins:
>> If I understand the issue correctly, the problem is that packed-refs
>> are always case-sensitive, even if core.ignorecase=true. OTOH,

core.ignorecase is intended to affect filenames of the worktree, not
anything else, BTW.

>> checking / updating _unpacked_ refs on a case-insensitive file system
>> is naturally case-insensitive. So wouldn't it be a better workaround
>> to disallow packed refs (i.e. 'git config gc.packrefs false')?
> 
> You are correct, the issue boils down to mixing the usage of 
> packed-refs and loose refs on case insensitive file systems. So either 
> always using packed-refs or always using loose refs would take care of 
> the problem. Based Michael Haggerty's response, it seems that always 
> using loose refs would be a better workaround.

So, everybody on a case-insensitive file system should pay the price even
if they do not need the "feature"? No way.

If you are on a case-insensitive filesystem, or work on a cross-platform
project, ensure that you avoid ambiguous refs. Problem solved.

-- Hannes
