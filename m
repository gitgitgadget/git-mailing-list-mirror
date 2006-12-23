From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Sat, 23 Dec 2006 09:52:06 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061223085206.GA2189@cepheus>
References: <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de> <20061222221913.GA3071@cepheus> <Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Dec 23 09:52:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy2c7-0001gs-4k
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 09:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbWLWIwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Dec 2006 03:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbWLWIwM
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 03:52:12 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:36276 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752703AbWLWIwL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Dec 2006 03:52:11 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Gy2bx-00013Z-OP; Sat, 23 Dec 2006 09:52:09 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBN8q74r005557;
	Sat, 23 Dec 2006 09:52:07 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBN8q711005556;
	Sat, 23 Dec 2006 09:52:07 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35304>

Hallo Johannes,

Johannes Schindelin wrote:
> @@ -127,6 +128,15 @@ int cmd_commit_tree(int argc, const char **argv,=
 const char *prefix)
>  	while (fgets(comment, sizeof(comment), stdin) !=3D NULL)
>  		add_buffer(&buffer, &size, "%s", comment);
> =20
> +	/* And check the encoding */
> +	buffer[size] =3D '\0';
> +	if (!strcmp(git_commit_encoding, "utf-8") && !is_utf8(buffer)) {
Maybe you could be more generous here.  E.g.

	if ((!strcasecmp(git_commit_encoding, "utf-8") ||
	!strcasecmp(git_commit_encoding, "utf8")) && !is_utf8(buffer))

Junio suggested to make this check if i18n.commitEncoding is empty.  I
didn't check the code to see if this case is included.

Gruessle
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D2+to+the+power+of+12
