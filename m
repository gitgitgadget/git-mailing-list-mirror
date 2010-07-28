From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: removing very old commits (including initial)
Date: Wed, 28 Jul 2010 11:10:48 +0200
Message-ID: <AANLkTim7yLFXZ8hgH1=agq2Qi7TUFk=348Pxb=SB67dm@mail.gmail.com>
References: <20100728115309.08ed6fdd@packard.rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Wed Jul 28 11:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe2fW-0005Yk-5u
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab0G1JLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 05:11:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56919 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab0G1JLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 05:11:09 -0400
Received: by fxm14 with SMTP id 14so1092630fxm.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 02:11:08 -0700 (PDT)
Received: by 10.103.221.1 with SMTP id y1mr1296700muq.19.1280308268180; Wed, 
	28 Jul 2010 02:11:08 -0700 (PDT)
Received: by 10.102.58.11 with HTTP; Wed, 28 Jul 2010 02:10:48 -0700 (PDT)
In-Reply-To: <20100728115309.08ed6fdd@packard.rktmb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152061>

On Wed, Jul 28, 2010 at 10:53 AM, Mihamina Rakotomandimby
<mihamina@gulfsat.mg> wrote:
> Manao ahoana, Hello, Bonjour,
>
> I work on a personnal project that become a little bit bigger over th=
e
> time.
> Initially, it was a single file one, and that file contained database
> credentials.
> Later, I splat the project and put the credentials in another untrack=
ed
> file (.gitignore).
> When I want to publish this project, the history contains the initial
> file, with the credentials. I dont want to publish that.
>
> It's not a problem to definitely wipe the "single file" part of histo=
ry
> of this project, but interesting to keep the history after the
> split&untracking.

If I understand you correctly you want to publish only the commits
since a particular commit, say "newroot". You can do it with "git
filter-branch". You have many different filters, but in you case I
would you grafts to cut the history and the rewrite the history with
git filter-branch.

In .git/info/grafts you put something like this:
HashOfTheNewRoot

It means that this commit has no parent, so you are cutting the
history. You can examine the history with git log or gitk to check
everything looks fine. To make it definitive you have to execute git
filter-branch:

$ git filter-branch -- --all

--all in this case means all the refs.

HTH,
Santi
>
> How to?
> Publishing will be through gitweb.
>
> Misaotra, Thanks, Merci.
>
> --
>
> =A0 =A0 =A0 Architecte Informatique chez Blueline/Gulfsat:
> =A0 =A0Administration Systeme, Recherche & Developpement
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+261 34 56 000 19
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
