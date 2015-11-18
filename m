From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] --bare is ignored before command word
Date: Wed, 18 Nov 2015 22:29:20 +0100
Message-ID: <vpqa8qbov2n.fsf@anie.imag.fr>
References: <loom.20151118T181639-5@post.gmane.org>
	<CA+P7+xoD2-eDZQt29KBqZF2g4i+K7XhJG0mhUgqf5iDURBPntg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronny Borchert <mister_rs@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 22:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzAIF-0001Jz-K1
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 22:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbbKRV31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 16:29:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54040 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756831AbbKRV30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 16:29:26 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tAILTHQq009444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 18 Nov 2015 22:29:17 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAILTKaV005733;
	Wed, 18 Nov 2015 22:29:20 +0100
In-Reply-To: <CA+P7+xoD2-eDZQt29KBqZF2g4i+K7XhJG0mhUgqf5iDURBPntg@mail.gmail.com>
	(Jacob Keller's message of "Wed, 18 Nov 2015 12:08:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Nov 2015 22:29:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAILTHQq009444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1448486961.98368@EJqPreSocc3Os2bD0Ondiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281459>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Nov 18, 2015 at 9:20 AM, Ronny Borchert <mister_rs@web.de> wrote:
>> I was trying to clone a bare repository. Not sure why I did, maybe
>> description on website was wrong.
>> My try:
>>
>> git --bare clone https://github.....
>>
>> This was leading in creating a none bare repository! No error or warning
>> message here!
>> I guess this behavior is also for other --xxx commands.
>>
>
> This is how the git options work. Options before a command word are
> always ignored.

No, they are not ignored. For example

$ git --foobar init
Unknown option: --foobar

=> the option is processed, and rejected explicitly.

But as you say, options before the command word apply to "git", not to
the particular command. The case of --bare is a bit unfortunate: both
"git" and "git clone" accept a --bare option, with a different meaning
(read "man git" to find what the first does).

So, I wouldn't call the current behavior a really good one, but it's the
documented behavior.

It would be nice to warn in this case though: I don't see any use for
"git --bare clone".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
