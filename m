From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 05/11] Use is_absolute_path() in sha1_file.c.
Date: Tue, 13 Nov 2007 22:43:05 +0100
Message-ID: <200711132243.05877.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0711132138360.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 22:43:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3Xc-0004sS-0F
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423AbXKMVnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbXKMVnI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:43:08 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:44277 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbXKMVnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:43:07 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 4D76A3424C;
	Tue, 13 Nov 2007 22:43:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 191E359084;
	Tue, 13 Nov 2007 22:43:06 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711132138360.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64877>

On Tuesday 13 November 2007 22:39, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 13 Nov 2007, Johannes Sixt wrote:
> > diff --git a/sha1_file.c b/sha1_file.c
> > index f007874..560c0e0 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -86,7 +86,7 @@ int safe_create_leading_directories(char *path)
> >  	char *pos = path;
> >  	struct stat st;
> >
> > -	if (*pos == '/')
> > +	if (is_absolute_path(path))
> >  		pos++;
>
> Is this enough?  On Windows, certain "absolute" paths would need "pos +=
> 3", no?

True, but this series is not yet about the MinGW port itself. It will be 
changed eventually, but not at this time.

-- Hannes
