From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 3/3] Use die_errno() instead of die() when checking syscalls
Date: Sun, 7 Jun 2009 00:27:41 +0200
Message-ID: <200906070027.44136.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch> <62538974f2c0f4561428507e514daa87dbfcac01.1244299302.git.trast@student.ethz.ch> <200906062302.08616.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 00:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD4Mm-0006qd-Ee
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 00:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbZFFW1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 18:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZFFW1q
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 18:27:46 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:50748 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbZFFW1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 18:27:46 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Jun 2009 00:27:47 +0200
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Jun 2009 00:27:32 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <200906062302.08616.j6t@kdbg.org>
Content-Disposition: inline
X-OriginalArrivalTime: 06 Jun 2009 22:27:32.0073 (UTC) FILETIME=[FBAF8590:01C9E6F5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120944>

Johannes Sixt wrote:
> > @@ -2262,7 +2262,6 @@ int cmd_blame(int argc, const char **argv, const char
> > *prefix)
> >
> >  	if (revs_file && read_ancestry(revs_file))
> >  		die_errno("reading graft file '%s' failed", revs_file);
> > -
> >  	if (cmd_is_annotate) {
> >  		output_option |= OUTPUT_ANNOTATE_COMPAT;
> >  		blame_date_mode = DATE_ISO8601;
> 
> Unrelated and not an improvement.

I used an Emacs macro to turn the die(..., strerror(errno)) [that I
had from v1] into die_errno, and obviously something went terribly
wrong _and_ I missed it.  Sorry :-(

I'll make a new version tomorrow.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
