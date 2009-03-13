From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/7] strbuf: add "include_delim" parameter to "strbuf_split"
Date: Fri, 13 Mar 2009 05:48:30 +0100
Message-ID: <200903130548.30370.chriscool@tuxfamily.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org> <20090312190846.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 05:51:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhzMK-0000oJ-6Q
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 05:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbZCMEt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 00:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbZCMEt3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 00:49:29 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:50174 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbZCMEt2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 00:49:28 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 24991D48037;
	Fri, 13 Mar 2009 05:49:17 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D71DCD4806E;
	Fri, 13 Mar 2009 05:49:14 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090312190846.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113140>

Le jeudi 12 mars 2009, Nanako Shiraishi a =C3=A9crit :
> Quoting Christian Couder <chriscool@tuxfamily.org>:
> > The "strbuf_split" function used to include the delimiter character
> > at the end of the splited strbufs it produced.
> >
> > This behavior is not wanted in many cases, so this patch adds a new
> > "include_delim" parameter to the function to let us switch it on or
> > off as we want.
>
> Sorry, but I don't understand the above claim. You say "not wanted in
> many cases" but your patch updates the existing callers, all of which=
 do
> want to include the delimiter.

In many programming languages, like Perl and Python for example, there =
is=20
a "split" function that splits strings, and by default the resulting=20
strings don't include the delimiter.

In Git there are only 2 existing callers and I think this function coul=
d be=20
used a lot more if there was a way not to include the delimiter.

In my patch series I add one caller that don't want the delimiter so af=
ter=20
my patch series there are already half as many callers that don't want =
the=20
delimiter.

And by the way, when I mentored the GSoC sequencer project I suggested =
to=20
Stephan to use strbuf_split, but we also had the problem that the delim=
iter=20
was included.

> The patch would easily justify itself if it made the callers pass 0 t=
o
> the function to decline the delimiter, and as the result it made the
> codepaths that use the result simpler. But I don't think that is what
> your patch does.

Yes, my patch does not do that, because I think including the delimiter=
 is a=20
special case of the more general and useful behavior of not including i=
t.

Best regards,
Christian.
