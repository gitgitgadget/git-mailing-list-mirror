From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 16/21] repack: handle optional files created by pack-objects
Date: Sat, 07 Dec 2013 17:35:44 +0100
Message-ID: <87zjocippb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124605.GP10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:35:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKr9-0001kM-Ok
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab3LGQfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:35:48 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52282 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3LGQfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:35:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A283E4D6510;
	Sat,  7 Dec 2013 17:35:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zQ1bBKNNFgVT; Sat,  7 Dec 2013 17:35:45 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 667204D64C4;
	Sat,  7 Dec 2013 17:35:45 +0100 (CET)
In-Reply-To: <20131114124605.GP10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:46:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239002>

Jeff King <peff@peff.net> writes:

> We ask pack-objects to pack to a set of temporary files, and
> then rename them into place. Some files that pack-objects
> creates may be optional (like a .bitmap file), in which case
> we would not want to call rename(). We already call stat()
> and make the chmod optional if the file cannot be accessed.
> We could simply skip the rename step in this case, but that
> would be a minor regression in noticing problems with
> non-optional files (like the .pack and .idx files).
>
> Instead, we can now annotate extensions as optional, and
> skip them if they don't exist (and otherwise rely on
> rename() to barf).
>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Thomas Rast <tr@thomasrast.ch>

-- 
Thomas Rast
tr@thomasrast.ch
