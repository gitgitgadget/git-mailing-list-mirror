From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Another use of "@"?
Date: Sat, 04 May 2013 00:09:26 +0200
Message-ID: <vpqy5bvaf6x.fsf@grenoble-inp.fr>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
	<7vr4hozie1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 00:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYOAh-0005dx-3k
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 00:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934345Ab3ECWJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 18:09:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39711 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934311Ab3ECWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 18:09:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r43M9NCM007971
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 4 May 2013 00:09:23 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UYOAQ-0003kt-Ew; Sat, 04 May 2013 00:09:26 +0200
In-Reply-To: <7vr4hozie1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 02 May 2013 23:28:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 04 May 2013 00:09:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r43M9NCM007971
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368223766.34413@K5+ajZOfc766rOufCTqViA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223328>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> My setup is a bit peculiar where I do git development on three
>> different machines. Say I updated branch long-branch-name on machine
>> A. Then I continue my work on machine B. I would want to hard reset
>> that long-branch-name on machine B before resuming my work. What I
>> usually do is
>>
>> git co long-branch-name
>> git diff A/long-branch-name
>> git reset --hard A/long-branch-name
>
> Perhaps
>
>     git checkout long-bra<TAB>
>     git diff A/!$
>     git reset --hard !$

I think Duy meant

  git diff A/$(git symbolic-ref --short HEAD)

i.e. "the branch with the same name as the current one, but on a
different remote". If this is the question, then it is a Git thing more
than a shell one.

The A/@ could make sense, but I'm wondering whether we're taking the
direction of implementing some kind of Brainfuck dialect in Git revision
specifiers. I'm not sure we want to add more special characters here and
there with subtly different meanings (@ = HEAD, @{1} = HEAD@{1}, A/@ =
A/$(git symbolic-ref --short HEAD)).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
