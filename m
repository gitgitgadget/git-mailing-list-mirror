From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Sun, 5 Mar 2006 15:11:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603051509480.12799@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
 <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 05 15:11:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFtxT-0002tL-BR
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 15:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWCEOLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 09:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWCEOLe
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 09:11:34 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:14237 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932116AbWCEOLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 09:11:33 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 56D7A20B2;
	Sun,  5 Mar 2006 15:11:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4A9A95DD8;
	Sun,  5 Mar 2006 15:11:30 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B0A9B20AD;
	Sun,  5 Mar 2006 15:11:29 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17230>

Hi,

On Sun, 5 Mar 2006, Junio C Hamano wrote:

> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > +char* format_time(unsigned long time, const char* tz)
> > +{
> > +	static char time_buf[128];
> > +	time_t t = time;
> > +
> > +	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", gmtime(&t));
> > +	strcat(time_buf, tz);
> > +	return time_buf;
> > +}
> 
> I think this shows GMT with time offset, which is compatible
> with the human readable time Johannes did to git-annotate.  I do
> not know what timezone CVS annotate shows its dates offhand (it
> seems to only show dates).  Johannes, is this an attempt to
> match what CVS does?

CVS only shows the date, something like

	strftime("%Y-%b-%d", gmtime($timestamp));

> I am wondering if we want to be in line with the date formatting
> convention used for our commits and tags, that is, to show local
> timestamp with timezone.  The code to use would be show_date()
> from date.c if we go that route.

I like that approach. Sometimes imitating CVS can be overdone.

Ciao,
Dscho
