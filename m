From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 4/6] Tests for git-remote-mediawiki pull
Date: Mon, 11 Jun 2012 23:09:54 +0200
Message-ID: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
References: <4FD654C8.6040208@ensimag.imag.fr>
 <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1339446526-22397-4-git-send-email-simon.cathebras@ensimag.imag.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 11 23:10:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBsC-0002ZY-IE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2FKVJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 17:09:59 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:35539 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688Ab2FKVJ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 17:09:58 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id C37151A02EF;
	Mon, 11 Jun 2012 23:09:54 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Mon, 11 Jun
 2012 23:09:54 +0200
In-Reply-To: <1339446526-22397-4-git-send-email-simon.cathebras@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199731>


Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =E9crit=A0:

> +test_expect_success 'Git pull works after adding a new wiki page' "
> +        wiki_reset &&
> +	cd $TRASH_DIR &&
> +	rm -rf mw_dir &&
> +	rm -rf ref_page &&
> +
> +        git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_NAME mw_d=
ir &&
> +        wiki_editpage Foo \"page created after the git clone\" false=
 &&
> +
> +        cd mw_dir &&
> +        git pull &&
> +        cd .. &&
> +
> +        rm -rf ref_page &&
> +        wiki_getallpage ref_page &&
> +        test_diff_directories mw_dir ref_page &&
> +        rm -rf ref_page &&
> +        rm -rf mw_dir
> +"

Why are there dquotes here (and all the following tests) ? You used
simple quote in t9360.
