From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 11:42:44 -0700 (PDT)
Message-ID: <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 19:42:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsKgL-0007gf-Tr
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 19:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab0CRSms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 14:42:48 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:45270 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab0CRSmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 14:42:47 -0400
Received: by bwz1 with SMTP id 1so2335210bwz.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=PqVdbjx1oBNED3IJrltTX3yQNZtdefy4FeCD8kmhCog=;
        b=sJuomqZYImzr3KlPq9wqWmR/so2b7tpJ2dkHFYTctEdrNnkcIWAYxVquTWzVMQjEVK
         SshA8TKcaD8YS8XxTXW2MKwK87WyDha2UMea65XglZhY+KbHIxXhANMsZ5jj1KnUdACq
         nGKw1NSyN+AvtOv+u5cus5CBX/coFm41Yif2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=m4I2kIt9gZvN12p5wRR3PxAjxKPhLKRfvWIsdSa73/BzjKuANZdkKMXx990V2pfD49
         L2RyuPO7gz8/lq6dR2FGobXsZ4g3N+PfrbhbEwK4AbzLSV5sRU6LaeGSDZqQjIrl5MoQ
         kAgN80u5LRRMmUM12DuG0OCr4msG/4xZIDHjE=
Received: by 10.204.8.5 with SMTP id f5mr3004155bkf.59.1268937765006;
        Thu, 18 Mar 2010 11:42:45 -0700 (PDT)
Received: from gmail.com (gpftor6.privacyfoundation.de [62.212.67.209])
        by mx.google.com with ESMTPS id 24sm857695bkr.12.2010.03.18.11.42.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 11:42:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142485>



Linus: Don't skim; read.



On Thu, Mar 18, 2010 at 12:27, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So in practice, the only thing that would happen
> is that people make up random uuid's and they'd
> be different for every single machine they have,
> because absolutely NOBODY would ever bother to
> try to save and move their uuids around.
>
> ...
>
> please realize that the emails are _more_ stable
> than a uuid would ever be. Because an email
> actually has some emotional attachment to the
> person in question.

My anticipation of your response was uncanny:

    >> For instance, the uuid could be... the SHA-1
    >> of some easily remembered, already reasonably
    >> unique information.
    >>
    >> ...
    >>
    >> ...he doesn't want to bother remembering some
    >> long human-hostile string, so he adopts as
    >> his uuid the SHA-1 of some easily remembered
    >> piece of information like the very first
    >> (name,email) pair that he used for git
    >> (Junio C Hamano <junkio@cox.net>)

So, forget the original generality and let's
define the uuid as a SHA-1 of some EASILY
REMEMBERED, already reasonably unique piece of
information such as an old (name,email) pair.

To make life easier on people, git tools could automate
that process; to Junio, his just uuid is an old,
unchanging (name,email) pair:

    $ git config --global user.name  "Junio C Hamano"
    $ git config --global user.email "gitster@pobox.com"
    $ git config --global --uuid "Junio C Hamano <junkio@cox.net>"

which produces something like:

    [user]
        name  = Junio C Hamano
        email = gitster@pobox.com
        uuid  = 6e99d26860f0b87ef4843fa838df2a918b85d1f7

In fact those three steps should probably be
further automated anyway:

    $ git config --global --init
    Full Name? Junio C Hamano
    Email? gitster@pobox.com
    UUID [Junio C Hamano <gitster@pobox.com>]? Junio C Hamano <junkio@cox.net>

Set it and forget it in a completely human way.

Could people still bungle the uuid or enter trash?
Sure, but that's essentially no different than the
current situation. This would be an improvement,
because at least some people would take advantage
of it; in fact, I bet most people would use it
properly because:

    * The information required is easily remembered
      and reproduced; it has that emotional aspect.

    * People have an emotional attachment to getting
      proper attribution for their work, and this
      helps.

Moreover, storing and using the SHA-1 uuid would be
very efficient and allow for saner .mailmap hacks.

Sincerely,
Michael Witten
