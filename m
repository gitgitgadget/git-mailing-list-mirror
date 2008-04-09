From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/8] test-lib.sh: Add a test_set_editor function to safely
 set $VISUAL
Date: Wed, 09 Apr 2008 08:36:48 +0200
Message-ID: <47FC6400.8010606@viscovery.net>
References: <> <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net> <1207704604-30393-4-git-send-email-bdonlan@fushizen.net> <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjTw8-0007BZ-Jp
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYDIGgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYDIGgx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:36:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7266 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbYDIGgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:36:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjTvN-00052v-1n; Wed, 09 Apr 2008 08:36:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CA458546; Wed,  9 Apr 2008 08:36:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79076>

Bryan Donlan schrieb:
> +test_set_editor () {
> +	# If the editor path contains a quote, just using VISUAL='"path"' isn't
> +	# enough.
> +	FAKE_EDITOR="$1"
> +	export FAKE_EDITOR
> +	VISUAL='"$FAKE_EDITOR"'
> +	export VISUAL

Clever! It assumes that $VISUAL is always run as sh -c "$VISUAL ...", but
I think this assumption is valid. A hint along these lines in the comment
could turn out helpful.

-- Hannes
