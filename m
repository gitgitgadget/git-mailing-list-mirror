From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] --bare is ignored before command word
Date: Fri, 20 Nov 2015 15:52:48 +0100
Message-ID: <vpqfv00hge7.fsf@anie.imag.fr>
References: <loom.20151118T181639-5@post.gmane.org>
	<CA+P7+xoD2-eDZQt29KBqZF2g4i+K7XhJG0mhUgqf5iDURBPntg@mail.gmail.com>
	<vpqa8qbov2n.fsf@anie.imag.fr>
	<20151119044646.GA8059@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Ronny Borchert <mister_rs@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:53:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzn3d-000590-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 15:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760186AbbKTOw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 09:52:57 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53937 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbbKTOw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 09:52:56 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tAKEqlfj028873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 20 Nov 2015 15:52:47 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAKEqm4P014399;
	Fri, 20 Nov 2015 15:52:48 +0100
In-Reply-To: <20151119044646.GA8059@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Nov 2015 23:46:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Nov 2015 15:52:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAKEqlfj028873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1448635970.03293@CkCxW19LIlnGT4LueWpfMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281523>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 18, 2015 at 10:29:20PM +0100, Matthieu Moy wrote:
>
>> But as you say, options before the command word apply to "git", not to
>> the particular command. The case of --bare is a bit unfortunate: both
>> "git" and "git clone" accept a --bare option, with a different meaning
>> (read "man git" to find what the first does).
>> 
>> So, I wouldn't call the current behavior a really good one, but it's the
>> documented behavior.
>> 
>> It would be nice to warn in this case though: I don't see any use for
>> "git --bare clone".
>
> We have a similar situation for "git init". Once upon a time there was
> just "git --bare init", and then 74d3b23 (git-init: accept --bare
> option, 2008-05-28) let us do it either way.
>
> I'm tempted to say that "git --bare clone" should work the same way.
> Both init and clone are special in that they are always about creating a
> new repository, not working in an existing one.  That's technically a
> non-compatible behavior change, but AFAICT with the current code the
> option is silently ignored, which just seems buggy.

I agree with this. I can't see a real use-case "git --bare clone" so it
could imply "git clone --bare".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
