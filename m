From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: overriding/removing inherited credential.helper, Do not add an empty value from config credential.helper
Date: Thu, 07 Feb 2013 09:36:12 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87pq0cchsz.fsf@lifelogs.com>
References: <CAHtLG6QaHOOYgVFPyOWo44-jTX__cd0dCyu+vs+Uf4_U-HxySw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3SbZ-0000pH-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549Ab3BGOhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 09:37:14 -0500
Received: from z.lifelogs.com ([173.255.230.239]:59947 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab3BGOhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 09:37:13 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id E880FDE0E3;
	Thu,  7 Feb 2013 14:37:12 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <CAHtLG6QaHOOYgVFPyOWo44-jTX__cd0dCyu+vs+Uf4_U-HxySw@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sat, 10 Nov 2012 23:12:50
 +0800, Sat, 10 Nov
	2012 23:08:04 +0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215699>

On Sat, 10 Nov 2012 23:12:50 +0800 =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cool=
i@gmail.com> wrote:=20

> In credential.c, line 67:
>     if (!strcmp(key, "helper"))
>	  string_list_append(&c->helpers, value);

> In global config, I add one credential helper.
> But I do not want to use any credential helper in a specific reposito=
ry.
> Currently there is no way in local config to override and remove
> inherited credential helper.
> Of course, I do not want to change global config.

> Could you suggest a patch?

On Sat, 10 Nov 2012 23:08:04 +0800 =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cool=
i@gmail.com> wrote:=20

> Below is current git message when a local config credential.helper ha=
s
> an empty value. Please skip an empty value.

> $ git push --force origin master
> git: 'credential-' is not a git command. See 'git --help'.

> Did you mean this?
>	  credential
> Total 0 (delta 0), reused 0 (delta 0)
> To https://user@github.com/user/myrepo.git
>  + d23aa6a...3405990 master -> master (forced update)

I would like that too (needed it today).  Maybe the empty string (as
suggested) or "none" could be acceptable.

"none" seems friendlier and is very unlikely to collide with an actual
credential helper.

Ted
