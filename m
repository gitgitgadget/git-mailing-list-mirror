From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Help merging two repo without connection
Date: Sun, 16 Nov 2008 10:33:54 -0500
Message-ID: <eaa105840811160733s18be2705l60806b1bf40b1743@mail.gmail.com>
References: <AB681AEE-D229-4F1C-8D7B-8E60E0ED8E96@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Luca Siciliano Viglieri" <lsiciliano@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 16 16:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1jeZ-00028g-V1
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 16:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYKPPd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 10:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbYKPPd4
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 10:33:56 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:31228 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbYKPPdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 10:33:55 -0500
Received: by hs-out-0708.google.com with SMTP id 4so935166hsl.5
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 07:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=m6XV7RhyX2MpT62D95m5m9JIAfYZi3rG+gXhnA/fGxg=;
        b=vgTcVjlN3/xfqXn1DKNn12/bGppCAscaVd8vSM39OC1/tzzbCJZEgrZV9Siv1gGDob
         7sXd+yJ2CFxPeaxxl+h6/vS4lfayIxjVJDHLHaVUBSFm9IVUvjKvmRSELPE7WLLoScRC
         AbQTZ3dEdsgFAO0LM+bsEksBow+1Zy5AF5BRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=t7GHxrHuYb7bfuuZoiHv67JJ5gf36NLaUYNix3etJYJRAS9ca3dw/UKxE71bQvlAdM
         9BD12+zKR+VpTb+n904Eq9f8AVYHjJj2w9wQXNRePv6jQPKF0gKCNbkdwbVTSukkxnKS
         eUkK5wBnbnl4ZIi8fx58qgAntUFlLExCuWeNc=
Received: by 10.65.233.16 with SMTP id k16mr2878106qbr.40.1226849634207;
        Sun, 16 Nov 2008 07:33:54 -0800 (PST)
Received: by 10.65.177.2 with HTTP; Sun, 16 Nov 2008 07:33:54 -0800 (PST)
In-Reply-To: <AB681AEE-D229-4F1C-8D7B-8E60E0ED8E96@web.de>
Content-Disposition: inline
X-Google-Sender-Auth: f1ec47fd403c9563
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101138>

On Sun, Nov 16, 2008 at 9:59 AM, Luca Siciliano Viglieri wrote:
> Hi,
> i'm trying to keep synched two repositories without always having a  direct
> connection.
...
> I don't thinks its right to have double (or more?) commits. I would have
> expected something like:
>
>
> -- (first commit) -- (second commit)  -- (my patch)--(my second patch)  --
>  (merge?) --
>
>
> The patches were created with git-format-patch and merged with git-am.
> I know that the commits have different sha1 but how can i keep with patches
> or something similar the two repositories exactly synched?

If you use "git bundle" instead of format-patch, you will have an
unreadable binary blob instead of a human-readable patch, but the
sha1s will not change (since the commiter information will be the
same). The remote side will "git pull" the bundle file instead of "git
am"ing it.

Peter Harris
