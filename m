From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 3/6] Test file for git-remote-mediawiki clone
Date: Mon, 11 Jun 2012 23:07:20 +0200
Message-ID: <20120611230720.Horde.Xx4mVHwdC4BP1l4IcI6RWrA@webmail.minatec.grenoble-inp.fr>
References: <4FD654C8.6040208@ensimag.imag.fr>
 <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1339446526-22397-3-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	charles.roussel@ensimag.imag.fr, gitster@pobox.com, peff@peff.net,
	Simon Perrat <simon.perrat@ensimag.imag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:07:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBph-0005N7-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab2FKVHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 17:07:25 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:35522 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab2FKVHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 17:07:25 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 28AF61A02EF;
	Mon, 11 Jun 2012 23:07:21 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Mon, 11 Jun
 2012 23:07:20 +0200
In-Reply-To: <1339446526-22397-3-git-send-email-simon.cathebras@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199730>


Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =E9crit=A0:


> +test_expect_success 'Git clone creates the git log expected with one=
 file' '
> +	wiki_reset &&
> +	cd '"$TRASH_DIR"' &&
> +	rm -rf mw_dir &&
> +	wiki_editpage foo "this is not important" false -c cat -s "this =20
> must be the same" &&
> +	git clone mediawiki::http://localhost/wiki mw_dir &&
> +	cd mw_dir &&
> +	git log --format=3D%s HEAD^..HEAD > log.tmp &&
> +	echo "this must be the same" > msg.tmp &&
> +	diff -b log.tmp msg.tmp &&
> +	cd .. &&
> +	rm -rf mw_dir
> +'
> +

It's best not to chdir around outside a subshell (same comment for all =
the
other tests)

BTW, please be aware of the whitespaces (the first 5 parts of your patc=
h are
full of it - couldn't apply the last one because of the special =20
characters, maybe
something that i haven't configure, i don't know).
