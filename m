From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 13:48:51 +0300
Message-ID: <CAMP44s3g8acV4fjaSvnUo_jnhj40-TWR0az6zOwRNfv9_Qa23g@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
	<20120413094500.GD2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 12:49:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIe3m-0001w2-AX
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab2DMKsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:48:53 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39019 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2DMKsw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 06:48:52 -0400
Received: by eekc41 with SMTP id c41so734210eek.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vOzyTup0Ot9T8mzmoTn4fqxE6tD457LHhxPN1A7MqX4=;
        b=e9vZyNVyqYK2s7m09Ye+XwbYnf/m5xptGdEpvmiUeRuyDNZPHpi35T2U26uof4gSz8
         fbw1kLsuyj8NIaFge1+K8vEhXxyKQfVnt8Njbd38Zn9BLOQPYL1i98prlbidztZglWSd
         tNtaMxo656n2puunbLooI4I8T5HHyjU/7s/GypMIDMxXEc3ZSPGgKIFwMXKoMcNcD62r
         Q77KqArlloMnmmjAScUhqamzaQpfW8r2+fEYzr7K8/v31X2c7O4RpZr0K7roKSGOEXp7
         ctwRG9fGtCCYrLtpr/OueYyB8GceWTEaKky3PE3lQEFWxvV4sEithlnKuAdgl4YT8TcP
         A8PQ==
Received: by 10.14.198.8 with SMTP id u8mr153484een.58.1334314131521; Fri, 13
 Apr 2012 03:48:51 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Fri, 13 Apr 2012 03:48:51 -0700 (PDT)
In-Reply-To: <20120413094500.GD2164@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195408>

2012/4/13 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Fri, Apr 13, 2012 at 11:12:36AM +0200, SZEDER G=C3=A1bor wrote:
>> On Thu, Apr 12, 2012 at 12:57:03AM +0300, Felipe Contreras wrote:
>> > +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
>> > +
>> > +_get_comp_words_by_ref ()
>> > +{
>> > + =C2=A0 while [ $# -gt 0 ]; do
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$1" in
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cur)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
ur=3D${_words[_cword]}
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;=
;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
rev=3D${_words[_cword-1]}
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;=
;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 words)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w=
ords=3D("${_words[@]}")
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;=
;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cword)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
word=3D$_cword
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;=
;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shift
>> > + =C2=A0 done
>> > +}
>>
>> Git's completion script already implements this function. =C2=A0Why
>> override it here?
>
> Ah, ok, I think I got it.
>
> Of course, the words on the command line must be specified somehow to
> test completion functions. =C2=A0But the two implementations of
> _get_comp_words_by_ref() for bash and zsh in the completion script
> take the words on the command line from different variables, so we
> need a common implementation to test completion functions both on bas=
h
> and zsh. =C2=A0Hence the _get_comp_words_by_ref() above, which takes =
the
> words on the command line and their count from $_words and $_cword,
> respectively, and run_completion() below, which fills those variables
> with its arguments.

Well, yeah, that's one reason, but also I don't see the point in
trying to fill the internal bash completion variables, maybe there
would be some conflicts? Plus, the bash version of
_get_comp_words_by_ref is rather complicated, so I decided to start
with something simple that I could understand and see exactly what's
going on. And for zsh I would definitely prefer to override
_get_comp_words_by_ref than to mess with the internal variables,
although I haven't found a way to test completion for zsh.

Cheers.

--=20
=46elipe Contreras
