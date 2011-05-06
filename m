From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] status: display "doing what" information in git status
Date: Fri, 06 May 2011 21:15:26 +0200
Message-ID: <vpqei4bvdwx.fsf@bauges.imag.fr>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
	<1304667535-4787-1-git-send-email-madcoder@debian.org>
	<vpqei4bwu4b.fsf@bauges.imag.fr> <20110506184403.GC2872@madism.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 21:18:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIQY7-0000RX-RC
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 21:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505Ab1EFTSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 15:18:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:60263 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202Ab1EFTSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 15:18:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p46JFQ0e006075
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2011 21:15:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QIQUo-0004UL-Ng; Fri, 06 May 2011 21:15:26 +0200
In-Reply-To: <20110506184403.GC2872@madism.org> (Pierre Habouzit's message of
	"Fri, 6 May 2011 20:44:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 06 May 2011 21:15:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173001>

Pierre Habouzit <madcoder@debian.org> writes:

> On Fri, May 06, 2011 at 08:40:04PM +0200, Matthieu Moy wrote:
>> Pierre Habouzit <madcoder@debian.org> writes:
>> 
>> > +	const char * const merge_advice =
>> > +		_("use \"git reset --hard\" to abort, or resolve conflicts and commit");
>> 
>> I think that should be "git reset --merge" (which preserves files not
>> touched by the merge, and makes sure "git merge; git reset" doesn't
>> permanently loose data).
>
> Wow, I didn't know about that one, so /maybe/ the hint isn't that
> useless after all :)

Actually, there's very few reason to run "git reset --hard" these days,
and we should really consider it as a very dangerous command that should
not be advertized to beginners. There's almost always a safer
alternative:

* You want to cancel a merge => git reset --merge
  (doesn't touch files not impacted by merges)

* You want to change the commit your HEAD points to => git reset --keep
  (in case you have local changes, they won't be overridden)

* You want to discard local changes => git stash
  (you may not think these changes are important, but you may be wrong)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
