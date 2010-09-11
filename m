From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sun, 12 Sep 2010 00:17:15 +0200
Message-ID: <4C8BFFEB.5090902@gmail.com>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>	<20100830030819.GA25415@sigill.intra.peff.net> <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 00:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuYNz-0004kF-8A
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 00:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab0IKWRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 18:17:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43526 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab0IKWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 18:17:21 -0400
Received: by bwz11 with SMTP id 11so3437812bwz.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=FshYYE8Pddq6ZR5yyCfzvS0sqw5LOPp/RQmYqsfor9c=;
        b=Jnt6+S+OOAeZpJ3+qtNN/fYKoql+U+qYqWCEbT+T9XyiBxZJH39xANgNkn+OXE5AkL
         KUa9xxazahXBX7qjecgzpciT6G7XBAIGnNEqXsvY/Dy0eP0qJ7yg4S/NzTnktU90L8Dh
         weEN+aLbsRQvBjDLTzNOOW/t0FopVJWUxVUd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=HGfUhdJY7irIq++HIIm2bqBzE/vu0HImq6P5YN5ZxQ1ex3lpxzYYsfuVCFvEvW5H9v
         3lYc0gplqZlr7rJNLinUBMIIcYSgQ070C6BS4ETN4v8TWcGmI7MU3r08Ik6HJ8riTyiy
         NpzKOaH0g61fZHMZnUxhnelP9QPTM1jcgN84U=
Received: by 10.204.124.14 with SMTP id s14mr1857216bkr.21.1284243439703;
        Sat, 11 Sep 2010 15:17:19 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-125-85.multimo.pl [89.174.125.85])
        by mx.google.com with ESMTPS id x13sm3191292bki.0.2010.09.11.15.17.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Sep 2010 15:17:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156014>

On 09/11/10 17:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> I have this alias in my .gitconfig:
>>>
>>>     review =3D "!f() { for rev in $(git rev-list --reverse \"$@\");=
 do
>>> git show $rev; done; }; f"
>>>
>>> I use it after I "git pull" to see what changed, e.g.:
>>>
>>>     git review 49ea7b8..e1ef3c1

> I just like the UI of having each commit "pop up" where I can either
> page up/down within the commit, or dismiss it with "q" and go to the
> next one.

Something like

$ LESS=3D"$LESS +/^commit " git whatchanged -p --reverse ORIG_HEAD..

will let you jump between the commits using 'n' for next, 'N' for
previous.

Not 100% the same, i know, but much faster than your solution.
(mostly because of pipelining; while you're reviewing one change
the next commits are already being prepared. For deep, but filtered
queries, i often do it more explicitly as "git..|bag|less +/^commit"
to avoid the stalls.)

artur
