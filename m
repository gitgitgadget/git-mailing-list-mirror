From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Fri, 29 May 2015 18:05:08 +0200
Message-ID: <87oal32wuj.fsf@ensimag.grenoble-inp.fr>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqq382giokd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 18:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMmi-00012v-Gq
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629AbbE2QFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:05:19 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:58848 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756455AbbE2QFR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 12:05:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F27EB24A8;
	Fri, 29 May 2015 18:05:13 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZaSx7WD4SFv; Fri, 29 May 2015 18:05:13 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E0457237D;
	Fri, 29 May 2015 18:05:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id D7F5020D6;
	Fri, 29 May 2015 18:05:13 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GeCIPkZ+i+2b; Fri, 29 May 2015 18:05:13 +0200 (CEST)
Received: from Groseille (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 2BABC20D4;
	Fri, 29 May 2015 18:05:13 +0200 (CEST)
In-Reply-To: <xmqq382giokd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 May 2015 10:45:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270250>

Junio C Hamano <gitster@pobox.com> writes:

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

>     Accept a list of emails separated by commas in flags --cc, --to
>     and --bcc.  Multiple addresses can already be given by using
>     these options multiple times, but it is more convenient to allow
>     cutting-and-pasting a list of addresses from the header of an
>     existing e-mail message, which already lists them as
>     comma-separated list, as a value to a single parameter.
>
> perhaps?
I've taken this description for the first part of the commit
message. Thanks!

> > before handling more complex ones such as names with commas:
> >         $ git send-email --to='Foo, Bar <foobar@example.com>'
> 
> Shouldn't this example send to two users, i.e. a local user Foo and
> the mailbox 'foobar' at example.com whose human-readable name is
> Bar?  If so, that is a bad example to illustrate the aspiration for
> the finished patch?

Yes, that works if Foo is in an alias file, so that's clearly a bad
example, I added quotes:

	git send-email --to='"Foo, Bar" <foobar@example.com>'

Thanks!
