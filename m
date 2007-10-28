From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] add ref_cmp_full_short() comparing full ref name with a short name
Date: Sun, 28 Oct 2007 00:28:36 -0700
Message-ID: <7vr6jfwvdn.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<11935038084055-git-send-email-prohaska@zib.de>
	<11935038084130-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2a9-0006YK-Mi
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXJ1H2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbXJ1H2m
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:42 -0400
Received: from rune.pobox.com ([208.210.124.79]:46206 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbXJ1H2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:41 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id EAD69151704;
	Sun, 28 Oct 2007 03:29:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 718D0151703;
	Sun, 28 Oct 2007 03:29:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62530>

Steffen Prohaska <prohaska@zib.de> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index b820909..2a1e093 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -249,6 +249,20 @@ static const char *ref_fmt[] = {
>  	NULL
>  };
>  
> +int ref_cmp_full_short(const char *full_name, const char *short_name)
> +{
> +	const char **p;
> +	const int short_name_len = strlen(short_name);
> +
> +	for (p = ref_fmt; *p; p++) {
> +		if (strcmp(full_name, mkpath(*p, short_name_len, short_name)) == 0) {

We usually say "!strcmp()" instead for readability.
