From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 20:58:02 +0200
Message-ID: <vpqwr5ydkqt.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<7vlimegjw9.fsf@alter.siamese.dyndns.org>
	<vpqy5qejbjl.fsf@bauges.imag.fr>
	<7vobraf057.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 20:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEmSX-0008WV-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 20:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab2DBS63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 14:58:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56914 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab2DBS62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 14:58:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q32IqsRU009027
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 20:52:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SEmS3-0005k9-LY; Mon, 02 Apr 2012 20:58:03 +0200
In-Reply-To: <7vobraf057.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 02 Apr 2012 11:40:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Apr 2012 20:52:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q32IqsRU009027
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333997577.99943@5qMuqVB+aEIionSnMeyvHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194550>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Before saying "again", perhaps we should read and think about what the
>>> other side said.  I think [*1*] raises a good point.
>>
>>> *1* http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=194470
>>
>> I think this message precisely supports my claim: we focus the
>> discussion on "git push", without thinking on the big picture "git pull"
>> AND "git push". The message you point to does not talk at all about "git
>> pull".
>
> I do not think so; that "name" argument is about this part from Peff's
> message, to which it is a response:

What I read in the message is that branch names are important, and "same
name" usually have some sort of semantics for users. I agree with that.
But why doesn't the same applies to "git pull"? Why would it be natural
for "git pull" to pull from a branch other than the one with the same
name?

>>> > my two concerns is that this:
>>> >
>>> >   $ git clone ...
>>> >   $ git checkout -b topic origin/master
>>> >   $ hack hack hack
>>> >   $ git push
>>> >
>>> > will try to implicitly fast-forward merge your commits onto master.
>>> 
>>> And the reason why it is surprising to the beginners is?  Because "topic"
>>> and "master" (of "origin/master") are not the same name?
>>
>> Sort of. It is more because "upstream" is an overloaded concept. Perhaps
>> you created the branch from origin/master because you wanted to say
>> "this is where my topic is based, and when I 'rebase -i' later, I want
>> it to be considered the baseline". Or perhaps you meant to say "I am
>> going to work on origin's master branch, but I would prefer to call it
>> 'topic' here".
>
> If you re-read it, it should be clear that this is _also_ about "git pull";
> "I am going to work on origin's master branch" is about pushing the result
> back there.

That's still not clear. Your explanation shows me how "git push" is
involved, not "git pull".

> In the former case, you may want to push it to 'topic' to work further
> with your collaborators.  In the latter case, you would want to push it
> back to 'master', even though you are calling it locally 'topic' for some
> sick reason (read: because you can).

I still don't see pull involved here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
