From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Sun, 24 Aug 2008 21:11:35 -0700
Message-ID: <7vvdxpivig.fsf@gitster.siamese.dyndns.org>
References: <200808221501.54908.jnareb@gmail.com>
 <200808250153.31697.jnareb@gmail.com>
 <20080825020502.GQ23800@genesis.frugalware.org>
 <200808250444.23305.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 06:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXTRh-0003fp-7G
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 06:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbYHYELp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 00:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbYHYELp
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 00:11:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYHYELp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 00:11:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E612667092;
	Mon, 25 Aug 2008 00:11:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C0ED067091; Mon, 25 Aug 2008 00:11:38 -0400 (EDT)
In-Reply-To: <200808250444.23305.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 25 Aug 2008 04:44:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED43EDE8-725B-11DD-951F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93591>

Jakub Narebski <jnareb@gmail.com> writes:

> +                     $markers .= " <span class=\"$class\" title=\"$ref\">" .
> +                             $cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"),
> +                                                    hash=>"refs/$ref")}, $name) .
> +                             "</span>";
>
> or equivalent (not stripping "refs/" in git_get_references).

If you mean by "hash => $it", I think it is only used as the URL the
anchor points at, and it is much more preferable to use the canonical
form.  "...?h=refs/heads/master" and "...h=heads/master" might produce the
same output, but then it is better for smart caching layer if you always
used canonical form, isn't it?
