From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Mon, 07 Jul 2008 11:15:09 -0700
Message-ID: <7vhcb14l3m.fsf@gitster.siamese.dyndns.org>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org> <7vej67jt1e.fsf@gitster.siamese.dyndns.org> <7v4p73gxf6.fsf@gitster.siamese.dyndns.org> <20080707171721.GT4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFvGa-0005Nv-QM
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 20:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180AbYGGSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbYGGSPW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 14:15:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbYGGSPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 14:15:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C0D952E909;
	Mon,  7 Jul 2008 14:15:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C794F2E906; Mon,  7 Jul 2008 14:15:11 -0400 (EDT)
In-Reply-To: <20080707171721.GT4729@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 7 Jul 2008 19:17:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6A2E9B0-4C50-11DD-89AB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87638>

Miklos Vajna <vmiklos@frugalware.org> writes:

> I think it's better not to modify all_strategy, it serves as a
> reference, for example later this would allow us to check if the used
> merge strategy is a predefined or a custom one.

I do not get you on this point.  Which one is nicer?

 (1) Have two lists, perhaps all_* and user_*.  The logic that finds a
     strategy searches in two lists.  The logic that checks if a given
     strategy is built-in checks if it is on all_* list.

 (2) Have a single list, but add a boolean "unsigned is_builtin:1" to each
     element of it.  The logic that finds a strategy looks in this single
     list.  The logic that checks if a given strategy is built-in looks at
     the strategy instance and it has the bit already.

You seem to be advocating (1) but I do not understand why...
