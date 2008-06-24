From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 16:16:36 -0700
Message-ID: <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
References: <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <20080621121429.GI29404@genesis.frugalware.org>
 <7vwskfclfs.fsf@gitster.siamese.dyndns.org>
 <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
 <20080624160224.GA29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806241709330.9925@racer>
 <20080624185403.GB29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806242007150.9925@racer>
 <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
 <20080624221049.GE29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:17:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHli-0006Wg-EG
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYFXXQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbYFXXQu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:16:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbYFXXQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:16:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A179D94D8;
	Tue, 24 Jun 2008 19:16:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C900794D1; Tue, 24 Jun 2008 19:16:43 -0400 (EDT)
In-Reply-To: <20080624221049.GE29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 25 Jun 2008 00:10:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9EDCAD68-4243-11DD-833E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86177>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Jun 24, 2008 at 01:44:34PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> >> bash: git-upload-pack: command not found
>> >> fatal: The remote end hung up unexpectedly
>> >
>> > Hmm.  Probably the client needs to be newer, too.  This is going to be 
>> > painful.  Junio?
>> 
>> Even with maint client accessing an account with next git-shell as its
>> login shell, I do not get the above failure.
>> 
>> Is git-shell installed and configured correctly at all in Miklos's setup?
>> Why does the other side say "bash: git-upload-pack" when login shell is
>> git-shell and not bash?
>
> Sorry for the confusion, this is not about git-shell at all. I have
> bash as the shell on the server, obviously.
>
> So, in case the server runs next, the client runs master, and I try to
> clone via ssh, I get the above error.

Ah, there is not much we can do in that case then.  git-upload-pack is
what the client asks you to run, and if you do not have it in the path,
you can (1) either make sure it is on the path, (2) have the client be
more explicit when asking for git-upload-pack (--upload-pack=$where), or
(3) leave the minimum git-* binaries that can remotely be launched
directly in the usual $PATH.

It most likely makes sense to do (3) anyway.  upload-pack, receive-pack,
anything else?
