From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
 further processing
Date: Tue, 17 Jun 2008 20:21:50 -0700
Message-ID: <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	madcoder@debian.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 05:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8oGC-0002Ub-Iy
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbYFRDWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756204AbYFRDWF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:22:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbYFRDWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:22:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8D6B128DE;
	Tue, 17 Jun 2008 23:22:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8083B128DC; Tue, 17 Jun 2008 23:21:52 -0400 (EDT)
In-Reply-To: <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> (Shawn
 Bohrer's message of "Tue, 17 Jun 2008 22:03:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7B2A5C6-3CE5-11DD-BF98-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85358>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> This adds the PARSE_OPT_NO_ERROR_ON_UNKNOWN flag which prevents
> parse_options() from erroring out when it finds an unknown option,
> and leaves the original command and unknown options in argv.

I have to say that this conceptually is broken.  How would you tell
without knowing what "--flag" is if the thing in argv[] after that is a
parameter to that option or the end of the options?
