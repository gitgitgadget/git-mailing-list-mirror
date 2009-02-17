From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH v2 1/8] config: Trivial rename in preparation for parseopt.
Date: Tue, 17 Feb 2009 09:00:15 +0000
Message-ID: <20090217090015.5334.qmail@ea511e23bd6d9a.315fe32.mid.smarden.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com> <7v3aedet0j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 10:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLwO-0006mz-Ni
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbZBQJHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 04:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbZBQJHD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 04:07:03 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:4606 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbZBQJHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 04:07:01 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 04:07:01 EST
Received: (qmail 5335 invoked by uid 1000); 17 Feb 2009 09:00:15 -0000
Content-Disposition: inline
In-Reply-To: <7v3aedet0j.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110342>

On Mon, Feb 16, 2009 at 05:45:00PM -0800, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > When using the --list option general errors where not properly reported,
> > only errors related with the 'file'. Now they are reported, and 'file'
> > is irrelevant.
> > ...
> > @@ -299,10 +300,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >  		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
> >  			if (argc != 2)
> >  				usage(git_config_set_usage);
> > -			if (git_config(show_all_config, NULL) < 0 &&
> > -					file && errno)
> > -				die("unable to read config file %s: %s", file,
> > -				    strerror(errno));
> > +			if (git_config(show_all_config, NULL) < 0)
> > +				die("error processing config file(s)");
> 
> Does the author of 93a56c2 (git-config: print error message if the config
> file cannot be read, 2007-10-12) have any comment on this change (cc:ed)?

Hm, we lose some information from the error message when called with
--file, but it seems to improve on other cases.  The filename doesn't
matter that much, but it would be nice to know the reason.  I wouldn't
object against this hunk though if that isn't possible.

Regards, Gerrit.
