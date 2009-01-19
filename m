From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/7] customizable --color-words
Date: Tue, 20 Jan 2009 00:35:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>  <1232209788-10408-1-git-send-email-trast@student.ethz.ch> <adf1fd3d0901191447n7fc39dect9cf5afd88a02015b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1106748398-1232408160=:3586"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3gL-0004Pc-GH
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbZASXgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbZASXf7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:35:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:58968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753830AbZASXf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:35:58 -0500
Received: (qmail invoked by alias); 19 Jan 2009 23:35:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 20 Jan 2009 00:35:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BX5xpNiLBD5k3u5Cvdr3xZ9AiCT3Q2czBMe32e7
	qibxxsO1cb5Czv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <adf1fd3d0901191447n7fc39dect9cf5afd88a02015b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106404>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1106748398-1232408160=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 19 Jan 2009, Santi Béjar wrote:

> 2009/1/17 Thomas Rast <trast@student.ethz.ch>:
> > Johannes Schindelin (4):
> >  Add color_fwrite_lines(), a function coloring each line individually
> >  color-words: refactor word splitting and use ALLOC_GROW()
> >  color-words: change algorithm to allow for 0-character word
> >    boundaries
> >  color-words: take an optional regular expression describing words
> >
> > Thomas Rast (3):
> >  color-words: enable REG_NEWLINE to help user
> >  color-words: expand docs with precise semantics
> >  color-words: make regex configurable via attributes
> >
> 
> Also, having a config (diff.color-words?) to set the default regexp
> would be great. Thanks.

>From "git log --author==Santi --stat" it seems that you are quite capable 
of providing that patch.

A few pointers:

- Add a global variable to diff.c, maybe "char *diff_word_regex".  
  (Maybe it should be static instead, as it will be used in diff.c only.)

- Add code to set it in diff.c, function git_diff_ui_config().

- In diff.c, where "--color-words" is handled (without "="), add

	if (diff_words_regex)
		options->word_regex = diff_word_regex;

- Add a test to t4034 that tests that the config sets a default, and that 
  the command line can override it.

- Send to this list :-)

Ciao,
Dscho

--8323328-1106748398-1232408160=:3586--
