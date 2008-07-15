From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9600: allow testing with cvsps 2.2, including beta
 versions
Date: Mon, 14 Jul 2008 17:31:40 -0700
Message-ID: <7v1w1wdm37.fsf@gitster.siamese.dyndns.org>
References: <20080715002019.5337.81984.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 02:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIYTc-0006uP-Nc
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbYGOAbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760654AbYGOAbt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:31:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227AbYGOAbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 20:31:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A00B22CD27;
	Mon, 14 Jul 2008 20:31:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8428B2CD26; Mon, 14 Jul 2008 20:31:44 -0400 (EDT)
In-Reply-To: <20080715002019.5337.81984.stgit@dv.roinet.com> (Pavel Roskin's
 message of "Mon, 14 Jul 2008 20:20:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68BBCEE0-5205-11DD-A33B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88489>

Pavel Roskin <proski@gnu.org> writes:

> Don't assume that unsupported versions are too old, they may be too new.

Excuse me, but we never assumed such.  

Neither too old nor too new ones are proven to work with us yet, so we
cannot be call them supported.

Let's apply your patch and see how well version 2.2 fares.

Thanks.

> diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
> index 655f882..f92b47a 100755
> --- a/t/t9600-cvsimport.sh
> +++ b/t/t9600-cvsimport.sh
> @@ -20,13 +20,15 @@ cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
>  case "$cvsps_version" in
>  2.1)
>  	;;
> +2.2*)
> +	;;

Hmm, I would have written:

	case "$..." in
        2.1 | 2.2 )

Is the reason why you have the asterisk there because the beta one claims
"2.2beta" or something (I am not suggesting to tighten the match, just
asking for information)?
