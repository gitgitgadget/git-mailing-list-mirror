From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --graph --first-parent weirdness
Date: Wed, 04 Jun 2008 10:12:19 -0700
Message-ID: <7vmym1xgy4.fsf@gitster.siamese.dyndns.org>
References: <20080604150042.GA3038@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3wY9-0002Xr-F6
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 19:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbYFDRMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754918AbYFDRMd
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 13:12:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbYFDRMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 13:12:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CA1255FA;
	Wed,  4 Jun 2008 13:12:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7B24555F7; Wed,  4 Jun 2008 13:12:26 -0400 (EDT)
In-Reply-To: <20080604150042.GA3038@mithlond.arda.local> (Teemu Likonen's
 message of "Wed, 4 Jun 2008 18:00:42 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A87342E-3259-11DD-B002-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83797>

Teemu Likonen <tlikonen@iki.fi> writes:

> The output of "git log --graph --first-parent" seems weird.

Heh, --first-parent means "I'll view everything as a single strand of
pearls".  Who in the right mind would use --graph at the same time to
begin with ;-)?

We could turn --graph automatically off if --first-parent is given, but
I tend to agree with you that the right behaviour is to show the same
"everything prefixed with '| ', wasting two columns without good reason"
output as you would see on a true linear history.
