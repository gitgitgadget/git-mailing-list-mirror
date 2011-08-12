From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 27/56] string-list: Add API to remove an item from an
 unsorted list
Date: Fri, 12 Aug 2011 09:00:45 +0200
Message-ID: <4E44CF9D.8030501@viscovery.net>
References: <1313126429-17368-1-git-send-email-newren@gmail.com> <1313126429-17368-28-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jim Foucar <jgfouca@sandia.gov>, Johannes Sixt <j6t@kdbg.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 09:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrljk-0006qB-K7
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 09:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab1HLHAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 03:00:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55332 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1HLHAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 03:00:50 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QrljZ-0008No-Kd; Fri, 12 Aug 2011 09:00:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 588F21660F;
	Fri, 12 Aug 2011 09:00:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1313126429-17368-28-git-send-email-newren@gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179221>

Am 8/12/2011 7:20, schrieb Elijah Newren:
> Here's an attempt for a delete_item API (note: only compile-tested).

Seriously? You haven't even tested this patch, and still don't mark it
with RFC?

> Bike-shed painters welcome: delete_item, remove_item, free_item?

You should know that a sentence like this shouldn't appear in the commit
message.

Yeah, I know, you just copy-pasted my email text. But that was not a
commit message. Perhaps like this:

    This implements removal of an entry in O(1) runtime by moving
    the last entry to the vacated spot. As such, the routine works
    only for unsorted lists.

BTW, the code does this:

> +	list->items[i] = list->items[list->nr-1];

i.e., it assigns an entire struct. Is this perhaps problematic with older
C compilers? (I don't know, I'm more used to C++, where this is well-defined.)

-- Hannes
