From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 16:33:55 +0100
Message-ID: <4D42E1E3.4060808@viscovery.net>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org> <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 28 16:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiqKv-0000ZT-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 16:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab1A1PeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 10:34:03 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61676 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab1A1PeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 10:34:02 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PiqKi-0002gH-Jv; Fri, 28 Jan 2011 16:33:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 502AD1660F;
	Fri, 28 Jan 2011 16:33:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165621>

Am 1/28/2011 15:37, schrieb Shawn Pearce:
> A simple fix is to use --heads --tags by default like I do here, but
> make the actual parameters we feed to rev-list configurable.  A
> repository owner could select only the master branch as input to
> rev-list, making it less likely the topic branches would be
> considered.  Unfortunately that requires direct access to the
> repository.  It fails for a site like GitHub, where you don't manage
> the repository at all.

Let's define a ref hierarchy, refs/cache-pack, that names the cache pack
tips. A cache pack would be generated for each ref found in that
hierarchy. Then these commits are under user control even on github,
because you can just push the refs. Junio would perhaps choose a release
tag, and corresponding commits in the man and html histories. The choice
would not be completely automatic, though.

-- Hannes
