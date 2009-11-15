From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Sun, 15 Nov 2009 19:44:08 +0100
Message-ID: <200911151944.10630.trast@student.ethz.ch>
References: <cover.1258309432.git.trast@student.ethz.ch> <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch> <fabb9a1e0911151039g7c7373b5o3c14a9056c419f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 19:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9k6J-0002aY-5p
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbZKOSpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 13:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbZKOSpL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:45:11 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:32975 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbZKOSpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 13:45:10 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:45:15 +0100
Received: from thomas.localnet (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:44:53 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <fabb9a1e0911151039g7c7373b5o3c14a9056c419f6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132952>

Sverre Rabbelier wrote:
> Heya,
> 
> On Sun, Nov 15, 2009 at 19:25, Thomas Rast <trast@student.ethz.ch> wrote:
> > +               if test "$STRATEGY" = "-s ours"
> 
> Is this solid? Would "-s  ours" (two spaces) work?

Well, the variable is set by the case immediately before the new test:

	case "$#,$1" in
	*,*=*)
		STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
	1,*)
		usage ;;
	*)
		STRATEGY="-s $2"
		shift ;;
	esac

I didn't want to split that for a direct comparison with the second
half of the value, but unless I'm missing something, you'd have to say
-s ' ours' to make the test fail.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
