From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 21:13:39 +0100
Message-ID: <200802232113.40100.johannes.sixt@telecom.at>
References: <20080220235944.GA6278@coredump.intra.peff.net> <20080221000044.GB6429@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT0lI-0007FX-DB
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 21:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYBWUNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 15:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbYBWUNn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 15:13:43 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:34537 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbYBWUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 15:13:42 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 02F5DBF33A;
	Sat, 23 Feb 2008 21:13:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C39A460C3B;
	Sat, 23 Feb 2008 21:13:40 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <20080221000044.GB6429@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74846>

On Thursday 21 February 2008 01:00, Jeff King wrote:
> The fake-editor shell script invoked /bin/sh; normally this
> is fine, unless the /bin/sh doesn't meet our compatibility
> requirements, as is the case with Solaris. Specifically, the
> $() syntax used by fake-editor is not understood.
>
> Signed-off-by: Jeff King <peff@peff.net>
...
> -cat > fake-editor.sh <<\EOF
> -#!/bin/sh
> +echo "#!$SHELL" >fake-editor

Did you mean fake-editor.sh here?

> +cat >> fake-editor.sh <<\EOF
>  case "$1" in
>  */COMMIT_EDITMSG)
>  	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"

-- Hannes
