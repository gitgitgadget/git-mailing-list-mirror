From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Thu, 04 Jul 2013 07:37:34 +0200
Message-ID: <51D50A1E.2030904@viscovery.net>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com> <CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com> <7vli5ogh8r.fsf@alter.siamese.dyndns.org> <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com> <CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com> <CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com> <51D40203.1010100@alum.mit.edu> <51D413BA.6080709@viscovery.net> <7vmwq3e7xy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 07:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UucEk-0006ck-VK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 07:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab3GDFhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 01:37:43 -0400
Received: from so.liwest.at ([212.33.55.13]:40314 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab3GDFhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 01:37:42 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UucEZ-0000ux-Jz; Thu, 04 Jul 2013 07:37:35 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 45FD91660F;
	Thu,  4 Jul 2013 07:37:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vmwq3e7xy.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229554>

Am 7/3/2013 21:53, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> I don't think that is necessary. We already have *two* options to
>> force-push a ref: the + in front of refspec, and --force.
> 
> They mean exactly the same thing; the only difference being that "+"
> prefix is per target ref, while "--force" covers everything, acting
> as a mere short-hand to add "+" to everything you push.

I know, and I'm saying that we do not have to keep this duplicity.

> If the "--lockref/--update-only-if-ref-is-still-there" option
> defeats "--force", it should defeat "+src:dst" exactly the same way.

This logic is backwards. If anything, then "--force" must defeat the
safety that "--lockref" gives.

-- Hannes
