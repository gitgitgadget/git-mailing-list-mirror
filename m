From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] pack-refs: remove newly empty directories
Date: Tue, 06 Jul 2010 20:49:34 +0200
Message-ID: <m2y6doqwch.fsf@igel.home>
References: <1278368848-7037-1-git-send-email-price@ksplice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDDE-0001wt-KA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0GFStj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:49:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58429 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab0GFSti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:49:38 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 88F591C00329;
	Tue,  6 Jul 2010 20:49:35 +0200 (CEST)
Received: from igel.home (ppp-88-217-125-205.dynamic.mnet-online.de [88.217.125.205])
	by mail.mnet-online.de (Postfix) with ESMTP id 4C69B1C0015B;
	Tue,  6 Jul 2010 20:49:35 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 032A8CA29C; Tue,  6 Jul 2010 20:49:34 +0200 (CEST)
X-Yow: It's the land of DONNY AND MARIE as promised in TV GUIDE!
In-Reply-To: <1278368848-7037-1-git-send-email-price@ksplice.com> (Greg
	Price's message of "Mon, 5 Jul 2010 18:27:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150393>

Greg Price <price@ksplice.com> writes:

> In a large repository which uses directories to organize many refs,
> "git pack-refs --all --prune" does not improve performance so much
> as it should, unless we remove all the now-empty directories as well.

What happens if a parallel running git wants to update a ref in one of
the now-empty directories?  Can it get a spurious error after it has
called safe_create_leading_directories?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
