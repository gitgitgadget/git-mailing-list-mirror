From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] git-rebase.sh: Fix --merge --abort failures when
 path contains whitespace
Date: Tue, 08 Apr 2008 23:50:48 -0700
Message-ID: <7vzls3bjxz.fsf@gitster.siamese.dyndns.org>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjU9t-0002Tr-Px
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYDIGvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYDIGvE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:51:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbYDIGvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:51:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA401135FF;
	Wed,  9 Apr 2008 02:51:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 21633135FC; Wed,  9 Apr 2008 02:50:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79080>

Bryan Donlan <bdonlan@fushizen.net> writes:

> @@ -42,7 +42,7 @@ To restore the original branch and stop rebasing run \"git rebase --abort\".
>  unset newbase
>  strategy=recursive
>  do_merge=
> -dotest=$GIT_DIR/.dotest-merge
> +dotest="$GIT_DIR/.dotest-merge"
>  prec=4
>  verbose=
>  git_am_opt=

This dq should not be necessary.

The rest of this looked fine.
