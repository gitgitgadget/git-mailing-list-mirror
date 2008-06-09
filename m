From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: [Q] Changing the current branch (HEAD) in a bare repository - how?
Date: Mon, 9 Jun 2008 09:50:47 +0200
Message-ID: <a537dd660806090050t385db36fk15d44c88bd5183af@mail.gmail.com>
References: <200806090934.13564.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 09:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5cAn-0000qu-E7
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 09:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYFIHuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 03:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbYFIHuu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 03:50:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:49369 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYFIHuu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 03:50:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so182477rvb.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 00:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=oJ+nRKMk4kUYYq3ekKR3YU7l8coJMx0O59CuQCE3L/w=;
        b=dwaSgVm0q7FiC5XBP0P85CRGK9B9XkS54+oiLeTiR1ikv7DQjxbtsI3oZaSJyoZ65h
         AFx6OgoYmqiFFrAoPIhJvckvdWHUXun8nxjf+jJOEuSdXfVJeFfIp5ekJseivzgUI1eY
         81IA1sa9/UdtcH59kbR+Qyr4QNkDJ1ulh2l6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ehG2q5I/fcQjqIUHi1kP3U07iBzHttFdbnckwoehicew+pZOlEOYpCf+ceUKHEQg2q
         QfZv9HATO5NLxP0xcqOXBzsRU74nmgQvuT4rFeJ4X3j3ebah7a0/9wrPbAu5OvRtzDVF
         9//A+g8W2ZcfezunSecrjAP0QrdoOj1+abs30=
Received: by 10.140.199.3 with SMTP id w3mr1880376rvf.43.1212997847210;
        Mon, 09 Jun 2008 00:50:47 -0700 (PDT)
Received: by 10.141.197.19 with HTTP; Mon, 9 Jun 2008 00:50:47 -0700 (PDT)
In-Reply-To: <200806090934.13564.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: 4b2abdf9d3a29f0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84369>

> Date: Friday 06 June 2008
> Subject: Re: [Q] Changing the current branch (HEAD) in a bare repository - how?
> From: Jakub Narebski <jnareb@gmail.com>
>
> "Brian Foster" <brian.foster@innova-card.com> writes:
>>  Using git 1.5.2.5 (Kubuntu 7.10) and a bare repository,
>>  I [ essentially swapped branch names `master' and `foo' ].
>>  Now, how do I change the current branch to the (new)
>>  `master'?  [ ... ]
>
> In a bare repository it doesn't matter (almost) which branch is
> current one (there is no _checked out_ branch, so it only matters
> as a default checked out branch for clone, IIRC).

Jakub,

 Yes, I also believe that is the case (but have not confirmed).

 The reason for the exercise is the bare repository in question
 will be cloned by newbies, and I want things to "just work"
 out-of-the-box.  The (new) `master' is the development mainline
 (broadly meaning what has passed (usually my) review), and as
 such is nominally what Patches should be generated against.
 (It didn't start out that way due to some convoluted history that
 is not relevant.)  Hence --- with the caveat I'm also rather new
 to git --- it seems wise to ensure the default checked-out branch
 after a clone represents the nominal development line.  (Of course,
 I need/want to encourage the use of topic branches, but I see that
 as a rather different issue.)

>>  I (ultimately) hand-edited `HEAD' [ as Dscho suggested ].
>
> You have to rely on plumbing:
>
>   $ git symbolic-ref HEAD master
>
> (see documentation for details).

 Ah!  Thanks for the hint.

cheers!
	-blf-

-- 
"How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." |      http://www.stopesso.com
