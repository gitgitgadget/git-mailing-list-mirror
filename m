From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Mon, 21 Jul 2008 23:41:39 -0700
Message-ID: <7vfxq2pgik.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.62.0807211316530.2841@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLBa9-0004wM-7a
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbYGVGlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 02:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYGVGlr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:41:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYGVGlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:41:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A69F33C09;
	Tue, 22 Jul 2008 02:41:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 990ED33C08; Tue, 22 Jul 2008 02:41:41 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.62.0807211316530.2841@harper.uchicago.edu> (Jonathan
 Nieder's message of "Mon, 21 Jul 2008 13:27:23 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40747A9A-57B9-11DD-B719-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89446>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> +	This flag implies the '-c' option and makes the patch output
> +	even more compact by omitting uninteresting hunks.  A hunk is
> +	considered interesting only if either (a) it shows changes from
> +	all parents or (b) in an Octopus merge, it shows different changes
> +	from at least three different parents.

I am not sure where that "at lesta three different parents" comes from.
It might be that what the logic does can be expressed that way, but that
was not the guiding principle why the code does what it currently does.

These two might make it clearer what hunks are considered interesting:

    http://thread.gmane.org/gmane.comp.version-control.git/15098/focus=15109
    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15491

Especially the latter thread, not just the focused one but the whole
thing, is quite amusing.

This one gives an insight into the logical consequence of the hunk
selection criteria:

    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15600

it is worth a read after understanding why some hunks are omitted and some
hunks are included by reading other articles in the thread.
