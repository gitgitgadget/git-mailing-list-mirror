From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Documentation: do not use regexp in refspec
 descriptions
Date: Thu, 30 Oct 2008 22:35:50 -0700
Message-ID: <7v7i7pba2x.fsf@gitster.siamese.dyndns.org>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Fri Oct 31 06:38:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvmi0-0003eS-Iz
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 06:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbYJaFgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 01:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYJaFgN
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 01:36:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYJaFgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 01:36:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4ED3176EBA;
	Fri, 31 Oct 2008 01:36:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0CC4776EB1; Fri, 31 Oct 2008 01:35:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D3571504-A70D-11DD-A42C-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99552>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> The refspec format description was a mix of regexp and BNF, making it
> very difficult to read.
>
> The syntax is now easier to read, though wrong: all parts of the
> refspec are actually optional.

It probably is easier to read, but strictly speaking it is not wrong.  The
two parts, <src> and <dst>, _always_ exist, even though either or both of
them can be an empty string.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 6150b1b..df99c0b 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -32,7 +32,7 @@ OPTIONS
>  
>  <refspec>...::
>  	The canonical format of a <refspec> parameter is
> -	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
> +	`[+]<src>:<dst>`; that is, an optional plus `{plus}`, followed
>  	by the source ref, followed by a colon `:`, followed by
>  	the destination ref.

I am wondering if it would be clearer and easier to understand if we just
said:

  	The canonical format of a <refspec> parameter is
	an optional plus `{plus}`, followed by the source ref,
        followed by a colon `:`, followed by the destination ref.
	Find various forms of refspecs in examples section.
