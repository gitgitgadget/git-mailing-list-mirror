From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Mon, 30 May 2011 21:46:09 +0200
Message-ID: <vpqzkm4gef2.fsf@bauges.imag.fr>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
	<20110529232405.GA8369@elie>
	<BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
	<20110530173517.GA13539@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?J=E9r=E9mie?= NIKAES <jeremie.nikaes@gmail.com>,
	git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 21:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8QR-0005zc-6p
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 21:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab1E3Tqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 15:46:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45689 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab1E3Tqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 15:46:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p4UJk7f4003205
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2011 21:46:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QR8Ph-0003Tj-M0; Mon, 30 May 2011 21:46:09 +0200
In-Reply-To: <20110530173517.GA13539@elie> (Jonathan Nieder's message of "Mon,
	30 May 2011 12:35:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 May 2011 21:46:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4UJk7f4003205
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307389572.3037@c6QMlk+cnY4ACjVwHpfMBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174771>

Jonathan Nieder <jrnieder@gmail.com> writes:

> J=E9r=E9mie NIKAES wrote:
>
>> No, I actually still have the problem. The version commited on githu=
b
>> is pulling revisions straight to refs/heads/master which is gross
>> After discussing this matter with our teacher Matthieu Moy, I wanted
>> to change this to refs/remotes/origin/master but then this warning
>> gets thrown.
>
> The following fixes it for me.

It seems it does, thanks!

clone does not give the warning anymore, and incremental pull work.

>  sub mw_capabilities {
>  #	print STDOUT "fetch\n";
> +	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";

Is this "mediawiki" comming from the URL (mediawiki::...), or is it jus=
t
a convention you've set?

We've tried with refspec refs/heads/*:refs/remotes/origin/*, but withou=
t
success.

Do I understand correctly that the "pull" is done in 3 stages:

1) import into refs/mediawiki/origin

2) fetch the imported ref into refs/remotes/origin

3) and merge as usual into the current branch

?

If so, I don't understand why the distinction between 1) and 2) is
necessary, and why not to fetch directly into refs/remotes/origin/. IOW=
,
in which case is refs/remotes/origin/master different from
refs/mediawiki/origin/master for example?

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
