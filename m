From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 17:41:24 +0200
Message-ID: <20120729154124.GA19201@paksenarrion.iveqy.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
 <20120729141354.GA16223@paksenarrion.iveqy.com>
 <CAMK1S_iFqQvU+USYf+wcsLFS1QtsytLnPfEhjcAVZa9Vwj8d1w@mail.gmail.com>
 <20120729150550.GA17679@paksenarrion.iveqy.com>
 <CAMK1S_hHBB9BViH=CFuJNgMJzMtzhE0mGc7ryFaDWNxOoH2Pgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 17:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvVcS-0006lW-MX
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 17:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab2G2PlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 11:41:19 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48869 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2G2PlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 11:41:18 -0400
Received: by lbbgm6 with SMTP id gm6so3099807lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hhkj/a84zOXU2aMS8lbTPR/052TWoq3t4OWsbPZQP9U=;
        b=0L4LJhX3kqGP3Fc/6PxfT89SaqXlXdhtetrPVvzYProDIEFUMSbE5Rm6w1iFL/5+oa
         2hMguCyCQ/E9Fy5vRE09as7h0g45qLOiACp8XZDC5+9TdJxga6T5wwrmMtz2U1dqM1Dm
         /PoQDHKg3VS4ltJiaOtVaRWF7KgfnP7Zsl9NhK/tL9ahPF1IoxDS4+qHzWukPV4vtkPN
         M+BOKLQ+ISKR/0J5GjyfvU8KYFJfAqNls21gWY+00dPuvup1bUS+7d2jf5E/lMfxi4LC
         Lw15eYCsOlK9Koz4AEzkvstLbip2rJ9zpW0EtSITOA5r3s5i0niaJrTXc/tzh6yg258I
         ZQjQ==
Received: by 10.152.112.138 with SMTP id iq10mr8774421lab.13.1343576477072;
        Sun, 29 Jul 2012 08:41:17 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-235-111.a189.priv.bahnhof.se. [81.170.235.111])
        by mx.google.com with ESMTPS id pp2sm8034350lab.3.2012.07.29.08.41.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 08:41:16 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1SvVcS-00054X-Bx; Sun, 29 Jul 2012 17:41:24 +0200
Content-Disposition: inline
In-Reply-To: <CAMK1S_hHBB9BViH=CFuJNgMJzMtzhE0mGc7ryFaDWNxOoH2Pgg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202485>

On Sun, Jul 29, 2012 at 08:45:39PM +0530, Sitaram Chamarty wrote:
> I think you misunderstood how gitolite works.  Gitolite does not have
> *any* user interaction other than sending some extra messages back vi=
a
> STDERR if you're using a normal git client to do normal git operation=
s
> (clone/fetch/ls-remote).

As you say, gitolite has userinteraction, and its not even standard to
git error messages. Try cloning a repo that doesn't exists via gitolite
and a regular ssh connection:

[iveqy@paksenarrion git]$ git clone ssh://gitolite@localhost/testing2
Cloning into testing2...
=46ATAL: R any testing2 id_rsa DENIED by fallthru
(or you mis-spelled the reponame)
fatal: The remote end hung up unexpectedly
[iveqy@paksenarrion git]$ git clone ssh://iveqy@localhost/testing2
Cloning into testing...
fatal: '/testing2' does not appear to be a git repository
fatal: The remote end hung up unexpectedly

> Such messages are *no different* from something that an update or
> pre-receive hook might send back even on a normal (no gitolite) git
> server.

As I showed above the "non-existing" repo is a case when it's different=
=2E
But you have a good point in hooks, of course a hook also should be abl=
e
to have two way user interaction.

> The only time that gitolite might have any user *interaction* is when
> using "gitolite commands".  These do not run git at all (neither on
> the client nor on the server), and in fact merely provide a convenien=
t
> way to allow users to run a controlled set of specific *shell*
> commands.

I do understand how gitolite works. However this is off-topic to my
original question. I also do not have an oppinion on how gitolite
should work, I simply don't care. Gitolite is an widely acceptet git
tool, I see improvement opportunities in git to allow an other
program to utilize two-way user interaction all the time, this will not
effect gitolite at all.

So in my point of view, it's up to Junio if I shall continue explore th=
is
path and maybe find a way of doing this in git, "the right way". Or if
this is something unwanted and gitolite and alike programs should
continue with STDERR "hacks".

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
