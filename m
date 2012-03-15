From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] help: Add 'help.follow-alias' config item
Date: Wed, 14 Mar 2012 23:06:09 -0700
Message-ID: <7v7gymmm9a.fsf@alter.siamese.dyndns.org>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
 <1331779969-8641-3-git-send-email-namhyung.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S83pJ-0003Fy-3D
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab2COGGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 02:06:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab2COGGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 02:06:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C6A23E5E;
	Thu, 15 Mar 2012 02:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6JwLpbUSXQd2z1Il0NxMbXD1IKQ=; b=Ja1XD6
	QZ2w2Xgb9+dE5d9rtZudHqvnjyzuwdqV4GNgDjIy0Tf6BCY2btkHvo6m1TToAC4z
	71iUPgNB/tWKllL4WV0K8GKzvMXaD2Xl9uMpZpgBg9GHSccO6DjobUALdKGvUgzL
	qieji9V0dnTv3sjI8xTb+o/d5l2DAnDLQDF4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f99gLhr1zXsN2i0r83Sn7Qpg0g5REJWi
	v4AhcUO6sBIAuM5lAmlguuo63FZoBUTMOlLLiQmcOtfv8Y7I4rXDc7REtH8euwrf
	ITWgOHCmtplw+L8Zli2o6IF7fY6mbd0TZQ6i3fl1+/ghaD8pPiGXJC2RBuJ1BwQx
	w96W3btCR5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 740C53E5D;
	Thu, 15 Mar 2012 02:06:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08C4F3E5C; Thu, 15 Mar 2012
 02:06:10 -0400 (EDT)
In-Reply-To: <1331779969-8641-3-git-send-email-namhyung.kim@lge.com>
 (Namhyung Kim's message of "Thu, 15 Mar 2012 11:52:49 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F693707C-6E64-11E1-AFF2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193182>

Namhyung Kim <namhyung.kim@lge.com> writes:

> The 'help.follow-alias' config option is used to determine the
> default value of '--follow-alias' option. To do this, move some
> codes to honor the priority of command line options.

How badly would this change break what 7c3baa9 (help -a: do not
unnecessarily look for a repository, 2009-09-04) tried to fix?

> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index debf293..9725e9f 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -80,6 +80,14 @@ line option:
>  * "info" corresponds to '-i|--info',
>  * "web" or "html" correspond to '-w|--web'.
>  
> +help.follow-alias

Please be consistent with existing ones.  I think we spell multi-word
variable names without hyphens.
