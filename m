From: Niels Basjes <Niels@basjes.nl>
Subject: Re: [Proposal] Clonable scripts
Date: Tue, 10 Sep 2013 10:35:13 +0200
Message-ID: <CADoiZqpT1BLpcQmTDT=mmJ=5gmQ8b-uZC_qmw8BK2db57YLOmg@mail.gmail.com>
References: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
	<CALkWK0nk1KfL7YuTKuKJecPSxmu7gXmo67i2Ezb2QY5qmdN+rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 10:35:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJJPx-0001MU-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 10:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab3IJIfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 04:35:19 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:58751 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab3IJIfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 04:35:15 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so6053543lbj.27
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 01:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=mCTvl7BxvuosTJHWrkicQD85iYP+zkw8d6AX8Vw/UyU=;
        b=iGlol6LyH6/P86lV3HHJWKtKlyHF1ZcIJN5B7O/tXYpNNrJ4F5LHvUua4RLB+fPfAD
         biTVNItY/SE6o5+WBVYYEbv9lECIeso6SpoP/Rf3w7bPCujHU6eXa68n2mniZk2GR3X/
         dL7JLbz1lsgzo+sxS6hKbQG3qKLc0LgJ2exRzeNtu1QMyvmXcF7XkkjLbbESCGVhAdCV
         RZve/nUoXJ/vMg8SIGdPOjcOXj+mzdfHtLxecbYiZi58Lm7+9Zp6y9McIO6fLCbr7f0Y
         ucZMKXF3y7CZJtVmvWtWd0y8qm2v/424dnk54VQCfwn/t4qWZ4PE6g8JMkWuWfsjKDNj
         4ORw==
X-Gm-Message-State: ALoCoQlY3j+3lIbLJJJ1iDuLtTNwrxE0jrsdZFjM27liDcsS+mkOmw6ZoXTH1EX1Km81wF8p9Y88
X-Received: by 10.152.8.12 with SMTP id n12mr20394975laa.10.1378802113745;
 Tue, 10 Sep 2013 01:35:13 -0700 (PDT)
Received: by 10.114.68.133 with HTTP; Tue, 10 Sep 2013 01:35:13 -0700 (PDT)
X-Originating-IP: [131.180.123.95]
In-Reply-To: <CALkWK0nk1KfL7YuTKuKJecPSxmu7gXmo67i2Ezb2QY5qmdN+rA@mail.gmail.com>
X-Google-Sender-Auth: HULMB1vTfCWuSajRgl_mZUrnKII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234426>

Hi,

On Tue, Sep 10, 2013 at 12:18 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Niels Basjes wrote:
>> As we all know the hooks ( in .git/hooks ) are not cloned along with
>> the code of a project.
>> Now this is a correct approach for the scripts that do stuff like
>> emailing the people responsible for releases or submitting the commit
>> to a CI system.
>
> More often than not, maintainers come with these hooks and they keep
> them private.

Yes.

>> Initially I wanted to propose introducing fully clonable (pre-commit)
>> hook scripts.
>> However I can imagine that a malicious opensource coder can create a
>> github repo and try to hack the computer of a contributer via those
>> scripts. So having such scripts is a 'bad idea'.
>
> I think it's a good idea, since the contributer can look through the scripts.

What I meant to say is that having "fully functional unrestricted
scripts" that are cloned is a "bad idea".
Having "restricted cloned scripts" to me is a "goog idea" (or atleast,
that is what I propose here).


>> 3) For the regular hooks this language is also support and when
>> located in the (not cloned!) .git/hooks directory they are just as
>> powerful as a normal script (i.e. can control CI, send emails, etc.).
>
> I'm confused now; how can .git/hooks be as powerful as .githooks? The
> former users should consider uploading their code on GitHub.

The way I envisioned is is that the scripting language in .git/hooks
is "pick any language you like" with the builtin language as a new
addition.
In the .githooks (which is under version control in the code base and
cloned) is a the same builtin language, yet constrained in a sandbox.

> Which reminds me that we need to have GitTogethers. Thanks for this!

You're welcome.

-- 
Best regards / Met vriendelijke groeten,

Niels Basjes
