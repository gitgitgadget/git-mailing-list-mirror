From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] add get_sha1_with_real_ref() returning full name of ref on demand
Date: Sun, 28 Oct 2007 00:28:23 -0700
Message-ID: <7v8x5ny9yg.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2Zf-0006UH-QQ
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXJ1H23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXJ1H23
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:29 -0400
Received: from rune.pobox.com ([208.210.124.79]:46195 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbXJ1H22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:28 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8C3E2151704;
	Sun, 28 Oct 2007 03:28:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 15C48151703;
	Sun, 28 Oct 2007 03:28:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62527>

Steffen Prohaska <prohaska@zib.de> writes:

> The new function can be used by "git rev-parse" to print the full
> name of the matched ref and can be used by "git send-pack" to expand
> a local ref to its full name.

"can be"?  "will be used to implement git rev-parse --some-option"?

> +static int get_sha1_1(const char *name, int len, unsigned char *sha1, char **real_ref);
>  
>  static int get_parent(const char *name, int len,
>  		      unsigned char *result, int idx)
>  {
>  	unsigned char sha1[20];
> -	int ret = get_sha1_1(name, len, sha1);
> +	int ret = get_sha1_1(name, len, sha1, /*real_ref=*/ 0);

A null pointer constant in git sources is spelled as "NULL", not "0".
