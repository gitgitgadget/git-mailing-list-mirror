From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 05/11] Use is_absolute_path() in sha1_file.c.
Date: Wed, 14 Nov 2007 22:57:12 +0100
Message-ID: <200711142257.12962.robin.rosenberg.lists@dewire.com>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0711132138360.4362@racer.site> <200711132243.05877.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Nov 14 22:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsQCf-0002uV-FF
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 22:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbXKNVzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 16:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbXKNVzF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 16:55:05 -0500
Received: from [83.140.172.130] ([83.140.172.130]:2067 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753738AbXKNVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 16:55:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DAC768026EC;
	Wed, 14 Nov 2007 22:45:56 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18856-05; Wed, 14 Nov 2007 22:45:56 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 8E9BE8026E9;
	Wed, 14 Nov 2007 22:45:56 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200711132243.05877.johannes.sixt@telecom.at>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65019>

tisdag 13 november 2007 skrev Johannes Sixt:
> On Tuesday 13 November 2007 22:39, Johannes Schindelin wrote:
> > Hi,
> >
> > On Tue, 13 Nov 2007, Johannes Sixt wrote:
> > > diff --git a/sha1_file.c b/sha1_file.c
> > > index f007874..560c0e0 100644
> > > --- a/sha1_file.c
> > > +++ b/sha1_file.c
> > > @@ -86,7 +86,7 @@ int safe_create_leading_directories(char *path)
> > >  	char *pos = path;
> > >  	struct stat st;
> > >
> > > -	if (*pos == '/')
> > > +	if (is_absolute_path(path))
> > >  		pos++;
> >
> > Is this enough?  On Windows, certain "absolute" paths would need "pos +=
> > 3", no?
> 
> True, but this series is not yet about the MinGW port itself. It will be 
> changed eventually, but not at this time.

D:/FOO and //deathstar/core work fine in cygwin, which is supported. but git
do not work well with such paths in some places.

-- robin
