From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] contrib/hooks: add an example pre-auto-gc hook
Date: Wed, 02 Apr 2008 12:49:32 -0700
Message-ID: <7vk5jg82b7.fsf@gitster.siamese.dyndns.org>
References: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
 <502492c60a58bdf409b3f6400da25f4a9a97463d.1207164676.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8yf-0006Ue-F7
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760526AbYDBTtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760521AbYDBTtu
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:49:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760435AbYDBTtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:49:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B62242D5;
	Wed,  2 Apr 2008 15:49:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DC43E42D2; Wed,  2 Apr 2008 15:49:34 -0400 (EDT)
In-Reply-To: <502492c60a58bdf409b3f6400da25f4a9a97463d.1207164676.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Wed, 2 Apr 2008 21:35:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78709>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +if test -x /sbin/on_ac_power && /sbin/on_ac_power
> +then
> +	/sbin/on_ac_power
> +	if [ $? = 1 ]; then
> +		exit 0
> +	fi

Shouldn't the above be:

	if test -x /sbin/on_ac_power && /sbin/on_ac_power
        then
        	exit 0

That is, you checked if you have the command to check on-ac-power-ness,
and the command says yes, so you happily let "gc --auto" do its thing.
