From: Eugene Sajine <euguess@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 15:48:54 -0400
Message-ID: <CAPZPVFbHseYHdPOXmbyGxncZmmzSHwY_fJkNRRQAMVtGZBA0CQ@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Namit Bhalla <namitbhalla@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:49:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMljR-0005uN-5A
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349Ab2DXTs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 15:48:57 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50529 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757112Ab2DXTs4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 15:48:56 -0400
Received: by lahj13 with SMTP id j13so946559lah.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uWB30dtjqFxOvvaUTWX2SzVxV43z0RBn8r5z9dG6hbw=;
        b=0sQFEFnngKt7V6LohevYVNWYqrf1aHFV2B5sv7IzFEx0yIGV6mwtVV+x2uF+cjKJlk
         KCaOPVvy3+QSCOTGGsf2c3H9H6TNZ2OUcbplLht2ryHleHHizPgH+lMgkQBb2aJZNIP+
         4mXB7aTPue/3XqIxzhlzX8y2bVGQqfaGNxQt4Ms39+Y9j3i+HlT7m1mPuxortU7BcBoa
         P4NzaCJnVWNtWHaDvwe6IAqWxacfWaBBr17h39vlMatEeooUeY+9emEGAoL9OCQPsrlc
         AmhJo1llZfCqfRjRH1/GCU/8yxk5YEUYI2wE9+sGPbCl0Y8r6EvM1QsPttvWN7tYkNRX
         i+Gg==
Received: by 10.112.24.161 with SMTP id v1mr10719473lbf.12.1335296934923; Tue,
 24 Apr 2012 12:48:54 -0700 (PDT)
Received: by 10.112.17.166 with HTTP; Tue, 24 Apr 2012 12:48:54 -0700 (PDT)
In-Reply-To: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196242>

On Mon, Apr 16, 2012 at 5:27 AM, Namit Bhalla <namitbhalla@yahoo.com> w=
rote:
> I am looking to track some projects using Git with each project as a
> separate repository.
> Even after reading the documentation, I am still wondering if there i=
s a
> way to organize things as described below.
>
> Consider 2 projects, Project-a and Project-b, which are housed in
> repositories Repo-a and Repo-b respectively.
> Project-a develops reusable libraries which are needed by Project-b
> (otherwise Project-b will not compile).
> When a new stable version of Project-a libraries has to be delivered,=
 they
> are "checked into" a path in Repo-a.
> Now, I would like to setup Repo-b so that when someone starts working=
 on
> Project-b, he should be able to retrieve the code from Repo-b as well=
 as the libraries from Repo-a. Is there any way to achieve that in
> Git?
>
> Thanks for any pointers!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

We are working in the environment where we have hundreds (700 + and
counting) or projects with many of them reused by others.
We are following strictly one project =3D one repo rule without any
subtrees or submodules.
What you are asking about is "integration" and IMHO has nothing to do
with git - i.e. should be VCS independent.
We are using integration on the artifact level and it works amazingly w=
ell.
But we also use pretty strict naming and location convention that
allows us to script around the whole setup very easily.

In order to track dependencies between projects we use Ivy.
The project can be compiled locally using local copies of the upstream
project artifacts built by developer on the same machine or if not
present, the current production artifacts are used.
We also have Jenkins CI server that helps with integration. It is very
simple and straight forward set up without any unnecessary
complications IMHO.
=46eel free to contact me if you need more info about such set up.

Just my 2 cents.

Thanks,
Eugene
