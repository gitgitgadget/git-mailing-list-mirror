From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Sun, 19 Oct 2008 13:11:31 -0700
Message-ID: <7vabd073bg.fsf@gitster.siamese.dyndns.org>
References: <1224441040-5071-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:15:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kree3-0000Da-3u
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 22:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYJSULo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 16:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYJSULo
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 16:11:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYJSULo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 16:11:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3002871C36;
	Sun, 19 Oct 2008 16:11:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D28FF71C35; Sun, 19 Oct 2008 16:11:38 -0400 (EDT)
In-Reply-To: <1224441040-5071-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sun, 19 Oct 2008 20:30:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25D201E2-9E1A-11DD-8B04-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98640>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sat, Oct 18, 2008 at 03:17:23AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> > This adds a new feature to say --no-z from the command line, doesn't
>> > it?
>> > And I suspect the feature is broken ;-).
>>
>> Right, I fixed this in option_parse_z(). --no-z should set
>> line_termination to \n instead of 1.
>
> Originally in option_parse_z() I had
>
>         line_termination = unset;
>
> which is in fact right, because (as Pierre pointed out) unset for short
> options are always false, but I changed it to
>
>         line_termination = 0;
>
> to make it more readable.

I think Pierre's comment is short-sighted.  Think of what would happen
when somebody adds "--nul" as a longer equivalent to "-z", since it is
extremely easy to do things like that with the use of parse-opt API?
