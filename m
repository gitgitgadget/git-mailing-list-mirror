From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: sanitize_remote_name should accept
 underscores.
Date: Wed, 25 Jun 2008 00:11:13 -0700
Message-ID: <7vfxr23s6m.fsf@gitster.siamese.dyndns.org>
References: <1214322898-9272-1-git-send-email-apenwarr@gmail.com>
 <20080625064435.GL21299@hand.yhbt.net> <20080625065556.GM21299@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:12:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBPB2-000474-0E
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 09:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYFYHL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 03:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbYFYHL2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 03:11:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbYFYHL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 03:11:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FCE917ABA;
	Wed, 25 Jun 2008 03:11:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B55B17AB9; Wed, 25 Jun 2008 03:11:20 -0400 (EDT)
In-Reply-To: <20080625065556.GM21299@hand.yhbt.net> (Eric Wong's message of
 "Tue, 24 Jun 2008 23:55:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECDFA51E-4285-11DD-BBA8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86247>

Eric Wong <normalperson@yhbt.net> writes:

> Wait, nevermind, this is for remotes, not remote *branches*.
>
> Umm... are underscores now allowed in git config files?

In

	[foo "bar"] baz = value

foo and baz must be config.c::iskeychar() (and baz must be isalpha()), but
"bar" can be almost anything.

Isn't "not underscore" coming from DNS hostname part restriction?
