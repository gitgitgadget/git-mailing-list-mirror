From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Modified test-lib.sh to output stats to
 /tmp/git-test-results
Date: Sun, 08 Jun 2008 13:59:28 -0700
Message-ID: <7vej77iqxb.fsf@gitster.siamese.dyndns.org>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
 <m3tzg4vvgw.fsf@localhost.localdomain>
 <bd6139dc0806080745i2ff2489bv70a1596bcc83f700@mail.gmail.com>
 <7vabhvkbbi.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0806081202l48953181q7d337455c85bbe2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git list" <git@vger.kernel.org>
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:00:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5S0H-0005tq-KK
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbYFHU7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbYFHU7m
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 16:59:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbYFHU7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 16:59:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 744921941;
	Sun,  8 Jun 2008 16:59:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DDEA11940; Sun,  8 Jun 2008 16:59:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D077F718-359D-11DD-B3AF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84320>

"Sverre Rabbelier" <srabbelier@gmail.com> writes:

> Ah, I guess logging to /tmp/git-test-result was more reliable then.
> Any suggestions as to what is the best solution here? (We could for
> example save $PWD at the beginning of test-lib.sh.)

Saving at the beginning to use in test_done, and optionally detecting 
that cwd was changed and warn, would be sensible, I think.

> Ah, yes, I was going to have each test log to their own file
> (test-results-$$) and then cat the result together, but I figured that
> since we are .NOTPARALLEL anyway it would be more efficient not to. I
> reckon that whenever we decide to make such a change it will be then
> that we modify this script, if it is included?

Yup.  That is what I meant by "not immediate, but something to keep in
mind".
