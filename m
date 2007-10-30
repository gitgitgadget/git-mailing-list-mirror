From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT-GUI PATCH 2/3] po2msg: ignore untranslated messages
Date: Tue, 30 Oct 2007 12:27:52 -0700
Message-ID: <7vabq0l7wn.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710301122300.4362@racer.site>
	<Pine.LNX.4.64.0710301124450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stimming@tuhh.de, spearce@spearce.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwmZ-0002ok-Qs
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbXJ3T2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759358AbXJ3T2B
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:28:01 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:41629 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759117AbXJ3T17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:27:59 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 252CB2EF;
	Tue, 30 Oct 2007 15:28:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A72D9061A;
	Tue, 30 Oct 2007 15:28:16 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710301124450.4362@racer.site> (Johannes
	Schindelin's message of "Tue, 30 Oct 2007 11:24:53 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62738>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Do not generate translations when the translated message is empty.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  po/po2msg.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/po/po2msg.sh b/po/po2msg.sh
> index 48a2669..91d420b 100644
> --- a/po/po2msg.sh
> +++ b/po/po2msg.sh
> @@ -62,6 +62,9 @@ proc flush_msg {} {
>  	if {$msgid == ""} {
>  		set prefix "set ::msgcat::header"
>  	} else {
> +		if {$msgstr == ""} {
> +			return
> +		}
>  		set prefix "::msgcat::mcset $lang \"[u2a $msgid]\""
>  	}

Is this change to fix some real issues?

Sometimes it is handy to be able to translate a non-empty string
into an empty one in one target language.
