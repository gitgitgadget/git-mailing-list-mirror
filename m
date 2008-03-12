From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/16] config: add --literal-match option
Date: Wed, 12 Mar 2008 15:34:51 -0700
Message-ID: <7vejaf4lmc.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312214019.GL26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:35:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZY5-0006GU-Ks
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbYCLWfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756043AbYCLWfF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:35:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbYCLWfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:35:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0D8B1CBC;
	Wed, 12 Mar 2008 18:35:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E48401CBB; Wed, 12 Mar 2008 18:34:58 -0400 (EDT)
In-Reply-To: <20080312214019.GL26286@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Mar 2008 17:40:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77014>

Jeff King <peff@peff.net> writes:

> When limiting the values to be set (or returned), the user
> previously had the option of specifying a regex. In some
> cases, however, they may want to find a literal value. The
> option --literal-match converts any matching regex into a
> literal string comparison.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think this is a nice addition regardless, but it is used by the next
> patch.
>
> The patch is about twice as long as it needs to be since getting and
> setting in builtin-config follow two almost-the-same parallel codepaths.
> I suspect this could be cleaned up, but I didn't look too closely.

I think that is a good new feature to propose.

Historically, the config_set_multivar() function has been one of the most
buggy part of the then-current codebase.  It might be a good idea to
clean-up first and then enhance.

But in either case I am quite reluctant to touch this part of the code
right now before 1.5.5, especially without extra sets of eyeballs.
