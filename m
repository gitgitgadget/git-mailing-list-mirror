From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [RFC/PATCH] submodule: add 'exec' option to submodule update
Date: Fri, 28 Jun 2013 12:13:01 +0200
Message-ID: <51CD61AD.4090203@atlas-elektronik.com>
References: <1372413190-32732-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Jens.Lehmann@web.de" <Jens.Lehmann@web.de>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 12:21:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsVnX-0008LE-VW
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 12:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab3F1KU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 06:20:56 -0400
Received: from mail96.atlas.de ([194.156.172.86]:29289 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779Ab3F1KUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 06:20:55 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2013 06:20:55 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 17B441014B;
	Fri, 28 Jun 2013 12:12:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEaPVZaknmCb; Fri, 28 Jun 2013 12:12:58 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 28 Jun 2013 12:12:58 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 2296927169;
	Fri, 28 Jun 2013 12:12:58 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 28 Jun
 2013 12:12:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1372413190-32732-1-git-send-email-judge.packham@gmail.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229184>

Am 28.06.2013 11:53, schrieb Chris Packham:
> This allows the user some finer grained control over how the update is
> done. The primary motivation for this was interoperability with stgit
> however being able to intercept the submodule update process may prove
> useful for integrating or extending other tools.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> --
> Hi,
> 
> At $dayjob we have a number of users that are accustomed to using stgit.
> Stgit doesn't play nicely with git rebase which would be the logical
> setting for submodule.*.update for our usage. Instead we need to run
> 'stg rebase --merged' on those submodules that have been initialised
> with stgit.
> 
> Our current solution is an in-house script which is a poor substitute
> for git submodule update. I'd much rather replace our script with git
> submodule update but we do have a requirement to keep stgit for the
> foreseeable future.  Rather than narrowing in on stgit it seems logical
> to allow an arbitrary update command to be executed.

Hhmmm...
Can't the same be accomplished with 
 
  git submodule foreach 'your-update-script $sha1'

Am I missing something?

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Preserve nature... pickle a squirrel.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
