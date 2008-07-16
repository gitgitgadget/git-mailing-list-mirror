From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
 only
Date: Tue, 15 Jul 2008 22:54:25 -0700
Message-ID: <7v4p6qwezy.fsf@gitster.siamese.dyndns.org>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
 <20080716051829.GB4030@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 07:55:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIzzC-0004V0-46
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 07:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYGPFye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 01:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbYGPFyd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 01:54:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbYGPFyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 01:54:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35F9A35A05;
	Wed, 16 Jul 2008 01:54:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 964D435A04; Wed, 16 Jul 2008 01:54:27 -0400 (EDT)
In-Reply-To: <20080716051829.GB4030@segfault.peff.net> (Jeff King's message
 of "Wed, 16 Jul 2008 01:18:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8BADFC6-52FB-11DD-A942-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88638>

Jeff King <peff@peff.net> writes:

> This is probably a fine protective measure, and it looks like Junio has
> already applied it. But shouldn't any git commands returning such values
> be fixed? Which commands return such bogus error codes?

Anything that returns error() from its cmd_xxx() routine, for example,
would end up exiting with (-1).  Is it "such bogus" error codes, though?

I am somewhat tired tonight, so I'll leave it up to the list to do the
grepping and go to bed ;-)
