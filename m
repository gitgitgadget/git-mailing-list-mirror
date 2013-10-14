From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] mv: Fix spurious warning when moving a file in presence of submodules
Date: Mon, 14 Oct 2013 14:33:57 +0200
Message-ID: <vpqfvs42fre.fsf@anie.imag.fr>
References: <vpq38o7nao9.fsf@anie.imag.fr> <52583B00.8040700@web.de>
	<525A8965.3040407@web.de> <vpqr4bp6wkh.fsf@anie.imag.fr>
	<20131014054048.GC25344@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 14:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVhLf-0008T0-2A
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 14:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab3JNMeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 08:34:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34594 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583Ab3JNMeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 08:34:04 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r9ECXuUt032506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Oct 2013 14:33:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9ECXvbu021801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 14 Oct 2013 14:33:57 +0200
In-Reply-To: <20131014054048.GC25344@google.com> (Jonathan Nieder's message of
	"Sun, 13 Oct 2013 22:40:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 14 Oct 2013 14:33:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9ECXuUt032506
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1382358838.04928@q8NIsx1ILFfNXArNOjrYFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236099>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>>>  static struct lock_file lock_file;
>>> +#define SUBMODULE_WITH_GITDIR ((const char *)1)
>>
>> I don't like very much hardcoded addresses like this. Are you 100% sure
>> address 1 will never be returned by xstrdup on any platform? The risk is
>> small if not negligible, but I'm unconfortable with this.
>
> I haven't checked what the standards say, but in practice I think it's
> okay.  [...]  We use (void *) 1 in the same way a few places currently.

OK, fine with me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
