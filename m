From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 3/3] Rework pretty_print_commit to use strbufs instead of custom buffers.
Date: Sat, 08 Sep 2007 13:59:31 +0200
Message-ID: <851wd9xt98.fsf@lola.goethe.zz>
References: <20070902224213.GB431@artemis.corp>
	<11892523992761-git-send-email-madcoder@debian.org>
	<1189252399433-git-send-email-madcoder@debian.org>
	<1189252399316-git-send-email-madcoder@debian.org>
	<11892523992038-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 14:00:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITyyw-0008Gu-GJ
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 14:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbXIHL7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 07:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbXIHL7e
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 07:59:34 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:49204 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886AbXIHL7e (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 07:59:34 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id C586E1836A6;
	Sat,  8 Sep 2007 13:59:32 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id B50312D3B28;
	Sat,  8 Sep 2007 13:59:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 86E428C469;
	Sat,  8 Sep 2007 13:59:32 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9EA141CAD71D; Sat,  8 Sep 2007 13:59:31 +0200 (CEST)
In-Reply-To: <11892523992038-git-send-email-madcoder@debian.org> (Pierre Habouzit's message of "Sat\,  8 Sep 2007 13\:53\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4194/Sat Sep  8 06:33:29 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58123>

Pierre Habouzit <madcoder@debian.org> writes:

>   Also remove the "len" parameter, as:
>   (1) it was used as a max boundary, and every caller used ~0u
>   (2) we check for final NUL no matter what, so it doesn't help for speed.

That sounds like a change that makes improvement of callers impossible
when it is found out that it leads to a performance issue.  Is it only
the pretty-print that is affected?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
