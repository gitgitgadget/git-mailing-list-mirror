From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/8] config: Trivial rename in preparation for
 parseopt.
Date: Tue, 17 Feb 2009 12:58:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171257360.6185@intel-tinevez-2-302>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com> <7v3aedet0j.fsf@gitster.siamese.dyndns.org> <20090217090015.5334.qmail@ea511e23bd6d9a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 13:00:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZOcY-0001lU-2n
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 13:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbZBQL6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 06:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZBQL6p
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 06:58:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:56625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751663AbZBQL6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 06:58:45 -0500
Received: (qmail invoked by alias); 17 Feb 2009 11:58:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp041) with SMTP; 17 Feb 2009 12:58:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/xSxYLku/CSXNVAqSzdNYzyqeOmxWLJrlsaklLV
	uqL2SaBrBenro8
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090217090015.5334.qmail@ea511e23bd6d9a.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110362>

Hi,

On Tue, 17 Feb 2009, Gerrit Pape wrote:

> On Mon, Feb 16, 2009 at 05:45:00PM -0800, Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > > When using the --list option general errors where not properly reported,
> > > only errors related with the 'file'. Now they are reported, and 'file'
> > > is irrelevant.
> > > ...
> > > @@ -299,10 +300,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> > >  		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
> > >  			if (argc != 2)
> > >  				usage(git_config_set_usage);
> > > -			if (git_config(show_all_config, NULL) < 0 &&
> > > -					file && errno)
> > > -				die("unable to read config file %s: %s", file,
> > > -				    strerror(errno));
> > > +			if (git_config(show_all_config, NULL) < 0)
> > > +				die("error processing config file(s)");
> > 
> > Does the author of 93a56c2 (git-config: print error message if the config
> > file cannot be read, 2007-10-12) have any comment on this change (cc:ed)?
> 
> Hm, we lose some information from the error message when called with
> --file, but it seems to improve on other cases.  The filename doesn't
> matter that much, but it would be nice to know the reason.  I wouldn't
> object against this hunk though if that isn't possible.

The point is: when _not_ using --file, the output could be wrong 
(mentioning another config file than the one having an issue), or not be 
shown at all -- I haven't checked, but both options to not look good to 
me.

Ciao,
Dscho
