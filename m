From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues
 with --graph
Date: Mon, 07 Apr 2008 10:43:09 -0700
Message-ID: <7vhcedpnma.fsf@gitster.siamese.dyndns.org>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
 <7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
 <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
 <20080407131728.GA20319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 19:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JivOl-0004dZ-5H
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 19:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYDGRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbYDGRn5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 13:43:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYDGRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 13:43:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 897F8B2FB;
	Mon,  7 Apr 2008 13:43:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D8628B2E7; Mon,  7 Apr 2008 13:43:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78981>

Jeff King <peff@peff.net> writes:

> The main drawback is that dropping the automatic separator breaks
> existing uses. We could work around this by automatically appending '%n'
> if there is no use of "%n" or "%N",...

Yeah, I agree that sounds quite bad, and that is why I favor more explicit
and independent way to choose between separator and terminator (like the
"tformat" thing).
