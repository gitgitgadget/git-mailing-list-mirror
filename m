From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 08:18:46 +0200
Message-ID: <4A10FDC6.2040706@viscovery.net>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Mon May 18 08:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5wCv-0007tS-H1
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 08:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbZERGSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 02:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbZERGSw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 02:18:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30346 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZERGSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 02:18:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M5wBS-0005Ju-4C; Mon, 18 May 2009 08:18:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CDB16FCD2; Mon, 18 May 2009 08:18:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119419>

Geoff Russell schrieb:
> How do I merge a branch X into my master and tell git that whenever there
> is a conflict, the file on X should prevail?  This is for a scripted
> application.

I assume you talk about file-level (content) merges.

There is no such tool, and the reason is that what you try to do here does
not make sense *in general*. It must be a very special kind of project
where you can blindly trust one side over the other if there are
conflicts, and that you can additionally trust non-conflicting content merges.

The best you can do is perhaps to pipe conflicting files through

    sed -e '/^<<<<<<</,/^=======/d' -e '/^>>>>>>>/d'

-- Hannes
