From: Michael Radziej <mir@noris.de>
Subject: Re: [TopGit PATCH v2] tg-graph: print dependency graph like git
	log --graph
Date: Wed, 20 May 2009 12:37:04 +0200
Message-ID: <20090520103703.GS8212@noris.de>
References: <1242801900-30895-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 20 12:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6jAg-00078N-Kr
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 12:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZETKhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 06:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZETKhG
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 06:37:06 -0400
Received: from mail01.noris.net ([62.128.1.221]:43694 "EHLO mail01.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbZETKhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 06:37:04 -0400
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail01.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6jAW-0004eB-BT; Wed, 20 May 2009 12:37:04 +0200
Received: from mir.office.noris.de ([10.2.6.66] ident=postfix)
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6jAW-000862-7G; Wed, 20 May 2009 12:37:04 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id 0D1C411768FF; Wed, 20 May 2009 12:37:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242801900-30895-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119599>

On Wed, May 20, Bert Wesarg wrote:

> ChangeLog:
>  v2:
>    * fix rename bug which caused random segfaults in gvpr
>    * add --decorate option, to print horizontal line from graph node =
to patch
>      name (like gitk do it for commits with tags or branch decoration=
s)
>    * in dfs mode we should maintain the order given by the input
>    * make dfs mode the default

Hmm, still doesn't work, but in a different way ;-)

a) graphviz 2.16-3ubuntu2

mir@mir:topgit (bw/tg-graph-v2)> tg graph
gvpr: "/usr/local/share/topgit/graph.gvpr", line 952: gg_nl_ret +=3D
graph_output_commit_line();<<<=20
 -- cannot convert node_t to string
mir@mir:topgit (bw/tg-graph-v2)> tg summary --graphviz
# GraphViz output; pipe to:
#   | dot -Tpng -o <ouput>
# or
#   | dot -Txlib

digraph G {

	graph [
		rankdir =3D "TB"
		label=3D"TopGit Layout\n\n\n"
		fontsize =3D 14
		labelloc=3Dtop
		pad =3D "0.5,0.5"
	];

	"30154name" -> "master";
	"30154name" -> "master";
	"30154name" -> "master";
}


b) graphviz 2.20.2-3~bpo40+1

mir@asterix:~/src/topgit-mradziej$ tg graph
mir@asterix:~/src/topgit-mradziej$ tg summary --graphviz
# GraphViz output; pipe to:
#   | dot -Tpng -o <ouput>
# or
#   | dot -Txlib

digraph G {

	graph [
		rankdir =3D "TB"
		label=3D"TopGit Layout\n\n\n"
		fontsize =3D 14
		labelloc=3Dtop
		pad =3D "0.5,0.5"
	];

	"7344name" -> "master";
	"7344name" -> "master";
	"7344name" -> "master";
}


Michael

--=20
noris network AG - Deutschherrnstra=DFe 15-19 - D-90429 N=FCrnberg -
Tel +49-911-9352-0 - Fax +49-911-9352-100
http://www.noris.de - The IT-Outsourcing Company
=20
Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk -=
=20
Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=FCrnberg HRB 176=
89
