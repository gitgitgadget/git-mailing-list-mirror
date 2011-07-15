From: John Szakmeister <john@szakmeister.net>
Subject: Re: Nesting a submodule inside of another...
Date: Fri, 15 Jul 2011 04:34:46 -0400
Message-ID: <CAEBDL5XzhuSQSzEMQ8yRupcufyQ=shtiTWejez0Mt75e0sJ-Vg@mail.gmail.com>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
	<4E1C9F21.6070300@web.de>
	<CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
	<4E1E0C27.60903@web.de>
	<CAEBDL5VUPE9YCX1C4pqkjb+EODkAWo9h774B=Jv5eUNbocMuZQ@mail.gmail.com>
	<201107141433.p6EEXbb9023826@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 10:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhdrK-0001qL-BK
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 10:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303Ab1GOIet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 04:34:49 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:40747 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045Ab1GOIes convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 04:34:48 -0400
Received: by fxd18 with SMTP id 18so2481828fxd.11
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9xtmIb/Ik/+GgYACoSY5y5tB3w91DlpaTo4r5RnO5no=;
        b=AoDSxnVPRBc5wS2GZUBlGp7Ezin87iCL8C0TVob4C9DMets7nH9CK6ua2Gfp2zPiZH
         i2dcfJ7znb0RKwEfBNreKcAT/l7C1ofy8eaJopXgccNtoUlS/TUgE61wc6u6aPvH68JT
         pWWH/BpOigb8AK/UNugzunDByaS75SbjjhSus=
Received: by 10.223.69.83 with SMTP id y19mr4956296fai.108.1310718886969; Fri,
 15 Jul 2011 01:34:46 -0700 (PDT)
Received: by 10.223.30.68 with HTTP; Fri, 15 Jul 2011 01:34:46 -0700 (PDT)
In-Reply-To: <201107141433.p6EEXbb9023826@no.baka.org>
X-Google-Sender-Auth: AMlxbOEchZjCCjZVFNH2mFvXbMk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177192>

On Thu, Jul 14, 2011 at 10:33 AM, Seth Robertson <in-gitvger@baka.org> =
wrote:
[snip]
> =C2=A0 =C2=A0Again, I don't see how the submodule needs to be aware o=
f the
> =C2=A0 =C2=A0superproject. =C2=A0In this case, it'd be the responsibi=
lity of the
> =C2=A0 =C2=A0superproject to setup whatever is necessary at 'git subm=
odule
> =C2=A0 =C2=A0init/add'. =C2=A0I don't see how the submodule *must* kn=
ow about the
> =C2=A0 =C2=A0superproject for it to succeed. =C2=A0I see the opposite=
, the superproject
> =C2=A0 =C2=A0needs to communicate some information down to the submod=
ule, but I
> =C2=A0 =C2=A0don't see the reverse.
>
> =C2=A0 =C2=A0What I'm hearing is that while it may be possible, the i=
dea of
> =C2=A0 =C2=A0violating the concept that the "subrepo is standalone" i=
s
> =C2=A0 =C2=A0unacceptable. =C2=A0Which means, unfortunately, git isn'=
t a solution for us
> =C2=A0 =C2=A0in this case.
>
> You might find that gitslave (http://gitslave.sf.net) might be a
> better solution for you than git-submodules in this case. =C2=A0It wo=
rks
> better for many workflows (and worse for others) but is much simpler
> to understand since with gitslave you have JBOR (just a bunch of
> repositories) with a program which can be thought of as running the
> requested git command over each repository in turn. =C2=A0Gitslave th=
us has
> a loose binding between the repositories, and you can only guarantee
> the relationship between repositories at tagged locations, though in
> practice this isn't a major concern.

Interesting.  I'll take a look!

> gitslave supports nested repositories (and recursive gitslave
> repositories, but those are different). =C2=A0With gitslave nested
> repositories it is also true that you would have to have a
> supplemental gitignore entry in framework1 (which gitslave will
> create).
>
> If you have any questions, please let me know.

I appreciate it.  Thanks Seth!

-John
