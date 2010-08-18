From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: BUG?: git-apply sometimes says "corrupt patch" when adding single
 lines
Date: Wed, 18 Aug 2010 09:29:12 +0200
Message-ID: <4C6B8BC8.9050301@viscovery.net>
References: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 09:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Old5Z-0002uU-6u
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 09:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab0HRH3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 03:29:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17299 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab0HRH3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 03:29:16 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Old5F-0005Ol-85; Wed, 18 Aug 2010 09:29:13 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EA11E1660F;
	Wed, 18 Aug 2010 09:29:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153813>

Am 8/18/2010 1:27, schrieb Tor Arvid Lund:
> I often use git-gui when staging commits, and I noticed that if the
> file I'm working with has a:
> 
> \ No newline at end of file
> 
> ... as the last line of the diff, and I try to "Stage lines for
> commit", then git-gui (or really git-apply, as I understand it) says
> that I have a "corrupt patch at line <so-and-so>".
> 
> Is this a bug? Or is it maybe git-gui that sends something wrong to
> git-apply? I don't know... :-/

This is really a bug in git-gui, not in git-apply: The big while loop in
lib/diff.tcl, function apply_range_or_line, must be taught about "\ No
newline...".

-- Hannes
