From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH 16/16] t7505: use SHELL_PATH in hook
Date: Thu, 13 Mar 2008 08:11:24 +0100
Message-ID: <47D8D39C.3070904@users.sourceforge.net>
References: <cover.1205356737.git.peff@peff.net> <20080312214243.GQ26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZi3U-0000Fg-Iv
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYCMHkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYCMHkI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:40:08 -0400
Received: from dorado.et.put.poznan.pl ([150.254.11.146]:52089 "EHLO
	dorado.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbYCMHkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:40:07 -0400
X-Greylist: delayed 1186 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2008 03:40:07 EDT
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by dorado.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m2D7F4O7025040;
	Thu, 13 Mar 2008 08:15:06 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.93] (pc1093.et.put.poznan.pl [150.254.11.93])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m2D7BOm13648;
	Thu, 13 Mar 2008 08:11:24 +0100 (MET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
In-Reply-To: <20080312214243.GQ26286@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.3.12.235745
X-PMX-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_700_799 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77049>

Hi!

* Jeff King [12 III 2008 22:42]:
> The hook doesn't run properly under Solaris /bin/sh. Let's
> use the SHELL_PATH the user told us about already instead.
[...]
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -25,7 +25,8 @@ export FAKE_EDITOR
>  HOOKDIR="$(git rev-parse --git-dir)/hooks"
>  HOOK="$HOOKDIR/prepare-commit-msg"
>  mkdir -p "$HOOKDIR"
> -cat > "$HOOK" <<'EOF'
> +echo "#!$SHELL_PATH" > "$HOOK"
> +cat >> "$HOOK" <<'EOF'
>  #!/bin/sh
    ^^^^^^^^^
The above line should be removed in my humble opinion.

BR,
/Adam

-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
