From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 04 Oct 2015 10:46:36 -0700
Message-ID: <xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	<CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	<CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	<vpq1tdb83nt.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roberto Tyley <roberto.tyley@gmail.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 19:46:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZinMy-0004cr-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 19:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbJDRqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 13:46:40 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33933 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbJDRqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 13:46:39 -0400
Received: by padhy16 with SMTP id hy16so12875099pad.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CmmPHSvgpH/9BH43/3fAd72ne4u2Mgyuuf2FQQJH/Jc=;
        b=1BdVV6DrIQj2Mml5gNbKp4rcAg/r7cpM4tC3IQKrVfeTDyZgh1kznUwRBflN5BcXLs
         bsJj5pX8Be7ywnPWZEDvqv7e8Ol7LGUxELt3tJwc2/CKsq2o6jKsXMgvNUbohWqlkkAn
         tfOQRT/q/Eqv3rk68HqTVr+aEsi0pXclW+THGwT9pida+jGNB+GI8V3KFdYNGtceXFKn
         QB6VPOyyHjTF5OSfEdwHzNkR6qPDYKBOOEBXBxTyT/i0Py03aQ/Eqo9zqAN1/nfKxoGD
         y+jrGXqB6rKS6b/fDCe4q8dFhZZx6yTG2grXwOJ34jpGdUJ1lPoS4re5eyl1704oeBVQ
         oIMA==
X-Received: by 10.69.20.10 with SMTP id gy10mr24805189pbd.80.1443980799333;
        Sun, 04 Oct 2015 10:46:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id ih4sm6824981pbc.28.2015.10.04.10.46.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 10:46:37 -0700 (PDT)
In-Reply-To: <vpq1tdb83nt.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sun, 04 Oct 2015 09:59:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279006>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>
>> I still don't see a reason why git/git needs to be the one that is
>> used,
>
> The very nice thing with Travis-CI is that it does not only test the
> repository's branches, but also all pull-requests.

OK, that is the first real argument I heard for enabling it on
git/git that is worth listening to.

Practically, it has little value to run CI (whose only test is to
run "make test") on branches that I publish in that repository.  By
the time a change hits that repository, "make test" has been run on
my end already, and the only thing the CI would catch is platform
dependent glitches (e.g. Windows and Mac), dependency-related ones
(e.g. p4), or breakages I already know about [*1*].

But we _do_ want to see tested patches submitted to the list so that
reviewers do not have to waste time on obviously bogus patches
reviewing (and the integrator wasting time on deconflicting).  A
test that is PR-initiated would give us a real value there.

The repository that is used for the PR-initiated test does not have
to be git/git (it only has to be a central well-known repository),
but similar to arrangement for SubmitGit, I agree that git/git would
be a good candidate for that "central well-known" one.  There is not
much point in introducing another "if you want your topics tested,
throw a PR against this other repository".

So,... I would not mind a patch that adds a CI configuration file (I
would really prefer it to be a battle-tested one, though) to my
tree, and I would not mind if CI is enabled on git/git, if Peff or
somebody more security-minded than me thinks it is safe to do so.

One final question.  Which configuration file does the CI use when
running a PR-initiated test?  The one already in the repository
i.e. the target of the proposed pull, or the one that is possibly
updated by the PR?

I am wondering if that can be an avenue for a possible mischief.

Thanks.


[Footnote]

*1* I occasionally do push out 'pu' with known breakages (e.g. the
recent 'lmdb' one) to make sure people are running the test suite so
that they will work with the topic author to resolve the issue
without having to wait for me to tell the topic author about it;
letting CI catch that kind of breakage would not add much value,
because it is already known ;-)
