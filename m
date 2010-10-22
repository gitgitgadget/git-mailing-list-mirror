From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Fri, 22 Oct 2010 10:54:59 -0500
Message-ID: <AANLkTinY2q-nM8tSWgNG2TtuNXPPzwhY0M-QknODqAoK@mail.gmail.com>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com> <201010221741.25390.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:55:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Jxn-00085O-IA
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962Ab0JVPzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 11:55:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46101 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878Ab0JVPzU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 11:55:20 -0400
Received: by gxk23 with SMTP id 23so527530gxk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=URtKs1bOGOZlN3X3+sJbeXvq9dyp/t9f0PCDOPmK1jw=;
        b=rXtBELYOACCNLt4+HYwiwsGeJ4FyknmvJyJ3NCM9D0cGTttbqgho8jL1mL0V5xY+KJ
         yCQSZA2WdBGaUFD8mCndvp/2c9Qc/LgfiI12+JlDkpU/ms0cPyaMoHeHbsuZnNw/2hcB
         CCPlK41fJwMOET7Ne2bD4XgTsz8HIWJxAJfLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Yb4TPE2TOK2TVpz0RGBDMlem9MTFD/g8BHgmD92CIXB8FFbloaQbwT65WXDcsAa+KC
         ok80ydzA45/tJiroBAP9nAVzK83AtjJ6iIE/gjmCRXD2shleOvDTqY1XdpWLHcl2awS5
         inGES50tsNwQZ3MQLzwM2tqpFwx0zzzTj8lEU=
Received: by 10.150.131.8 with SMTP id e8mr1490217ybd.91.1287762919795; Fri,
 22 Oct 2010 08:55:19 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 08:54:59 -0700 (PDT)
In-Reply-To: <201010221741.25390.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159706>

Heya,

On Fri, Oct 22, 2010 at 10:41, Johan Herland <johan@herland.net> wrote:
> Yes, sorry for not answering you earlier. Here's what you wrote in th=
e
> previous thread:

No problem :).

> On Saturday 09 October 2010, Sverre Rabbelier wrote:
>> On Sat, Oct 9, 2010 at 03:08, Johan Herland <johan@herland.net> wrot=
e:
>> > - Fetching and pushing note refs:
>> > =C2=A0- Add refs/notes/* to default fetch refspec?
>>
>> Or at least add a '--notes[=3D<notes namespace>]' to fetch, pull, an=
d
>> push.
>
> Agreed, at least that.
>
> In order to promote sharing of notes, though, I'd like for it to be
> possible to configure the repo so that a vanilla 'git fetch' also
> updates your notes. In fact, I wonder if this should even be made the
> default.

I think notes directly under /refs/notes/ should be shared by default,
but those in sub-refs (such as the /refs/notes/am/ that's been
mentioned before) should not.

>> > =C2=A0- A way to specify (at clone time) which refspec(s) to set u=
p?
>>
>> How would that look like?
>
> Maybe add an option to 'git clone' (and 'git remote add') that specif=
ies
> the refspec you want to use in your config for that remote. Something
> like:
>
> =C2=A0git clone --fetch=3D"+refs/heads/*:refs/remotes/origin/*" \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--fetch=3D"+refs/notes/*:ref=
s/remotes/origin/notes/*" \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<source_url> ...

Who's going to type that out though? The only use case I can think of
is if you want to be able to give someone a line they can paste and be
set right away, but I don't see why in that case pasting multiple
commands (i.e., calling 'git config' a few times) wouldn't suffice.

> Obviously, we would probably want to provide shorthands for the most
> common refspecs, like:
>
> =C2=A0git clone --fetch=3Ddefault,notes <source_url> ...
> =C2=A0git clone --fetch-heads --fetch-notes <source_url> ...

Adding refspec shorthands _does_ make sense. However, it might make
more sense to put those under 'git remote' instead?

>> > =C2=A0- A way for the remote repo to hint at which refspecs you mi=
ght
>> > want to set up (by default?)
>>
>> I assume this would be a generic mechanism of sorts? Are there any
>> other use cases for this other than notes?
>
> Yes, I believe so (although I haven't thought much about this, yet).
> There's been earlier discussions on hiding certain branches from view=
=2E
> This could maybe be solved by the server suggesting a refspec that
> excludes the stuff you don't want to share (by default). Similary, th=
e
> refspec could _include_ notes namespaces that you do want to share.

That sounds like a good use case.

> Of course (as today) the client should be free to demand a different
> refspec, e.g. if it wants access to everything, or if it's only
> interested in a subset of the "default" refs.

Of course, I reckon it would just set up their refspecs, and the user
would be free to change it. Especially if we inform the user that the
refspec was set to something other than the default refspec.

--=20
Cheers,

Sverre Rabbelier
