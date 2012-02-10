From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 15:55:19 +0100
Message-ID: <201202101555.20163.jnareb@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com> <m339aivn4z.fsf@localhost.localdomain> <20120210151528.56145e0c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 15:55:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvrsp-0000wo-Su
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 15:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445Ab2BJOz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 09:55:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38015 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab2BJOzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 09:55:23 -0500
Received: by eekc14 with SMTP id c14so981398eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0eOsrJsKeEbolMMl6/DC9HirWejvKdEjAaXOAMjhp+s=;
        b=eqoKYCBiMDNTUu/BeM0hLHXwpbI+tpOBrfrHJc4y4+eMrtYfE9suelV7HP98LarSQJ
         x2uKmw2KD0K7LR+5QcfGAwp/pg30qyfYYII9mR3VNAwTMX8tFaO4Fglt+DOg3Guaie5L
         WoOj/NlmiQFN3Bm5oIRyCqekw7HX3RRxMcDqI=
Received: by 10.213.113.203 with SMTP id b11mr404523ebq.64.1328885721718;
        Fri, 10 Feb 2012 06:55:21 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id z47sm22888113eeh.9.2012.02.10.06.55.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 06:55:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120210151528.56145e0c@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190413>

On Fri, 10 Feb 2012, Micha=C5=82 Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> >=20
> > > The code that comares lines is based on
> > > contrib/diff-highlight/diff-highlight, except that it works with
> > > multiline changes too.  It also won't highlight lines that are
> > > completely different because that would only make the output unre=
adable.
> > > Combined diffs are not supported but a following commit will chan=
ge it.
> >=20
> > I was thinking that if gitweb were to support "diff refinement
> > highlighting", it would either use one of *Diff* packages from CPAN=
,
> > or "git diff --word-diff" output.
>=20
> I think highlighting inline and side-by-side diff outputs is
> something different from "git diff --word-diff". I find it useful for
> people who are used to these diff formats (i.e. me :).

I was thinking about *using* "git diff --word-diff" for diff refinement
highlighting of inline (unified) and side-by-side diff...=20

though having an option of showing word-diff would be I think a good
idea in some cases, like e.g. documentation changes.

> OTOH I'm not against using a dedicated package from CPAN. But I think
> my approach is proven to work (I use contrib/diff-highlight as a
> filter) and more lightweight (doesn't add another dependency to
> gitweb). Moreover, adding support for some Diff package may be done
> later, at any moment. It's just a matter of replacing one function
> (format_rem_add_line()) with the one that uses Diff.=20

O.K., if it is tested code, then all is good.  Well, except the fact
that I'm rather wary about adding more code to gitweb when it is still
single monolithic script, rather than split into packages.

Anyway, I'll try to review those patches soon.  I like the refactoring
work (that is from what I had chance to examine).

--=20
Jakub Narebski
Poland
