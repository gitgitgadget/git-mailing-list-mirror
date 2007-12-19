From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH 4/5] atmel_serial: Split the interrupt handler
Date: Wed, 19 Dec 2007 22:02:23 +0100
Organization: Atmel
Message-ID: <20071219220223.7c5b3887@siona>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
	<20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
	<alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
	<20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
	<20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
	<BAYC1-PASMTP13613FE244FF93DC2BF613AE5C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5644-00028b-6V
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 22:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbXLSVC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXLSVC1
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 16:02:27 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:60066 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751732AbXLSVC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 16:02:27 -0500
Received: from siona (vpn-000-018.norway.atmel.com [172.21.0.18])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id lBJL2KgL022169;
	Wed, 19 Dec 2007 22:02:20 +0100 (CET)
	(envelope-from hskinnemoen@atmel.com)
In-Reply-To: <BAYC1-PASMTP13613FE244FF93DC2BF613AE5C0@CEZ.ICE>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.12.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68938>

On Wed, 19 Dec 2007 15:37:45 -0500
Sean <seanlkml@sympatico.ca> wrote:

> Can't reproduce this here with the version of Git you're using
> (1.5.3.4). Can you figure out a small test case that shows the
> problem?  Perhaps the problem only shows up in your environment or
> with your particular config file settings.

Ah...seems like it only happens when I use git-rebase --interactive...

Test case:
1. Start with two branches pointing to the same commit
2. Modify the same file on both branches in conflicting ways.
3. Commit using a different author than the default.
4. Use git rebase -i to rebase one of the branches on top of the other
5. Resolve the conflict, update the index and run git rebase --continue

The last commit is now attributed to the correct name, but the default
e-mail address (from git-config.)

Just tested it with git 1.5.3.6 on a different computer.

> P.S. Trimmed CC list.

Thanks :-)

Haavard
