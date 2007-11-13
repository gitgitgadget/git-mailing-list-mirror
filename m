From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/11] Use is_absolute_path() in sha1_file.c.
Date: Tue, 13 Nov 2007 21:39:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132138360.4362@racer.site>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3UK-0003aN-7z
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762371AbXKMVjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762588AbXKMVjk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:39:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:54182 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762379AbXKMVjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:39:39 -0500
Received: (qmail invoked by alias); 13 Nov 2007 21:39:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 13 Nov 2007 22:39:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZoftNDJ2ZraG4eleA6vJyrDaqvBaxOf8QS1GutQ
	3IbmefLzVHAWYh
X-X-Sender: gene099@racer.site
In-Reply-To: <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64876>

Hi,

On Tue, 13 Nov 2007, Johannes Sixt wrote:

> diff --git a/sha1_file.c b/sha1_file.c
> index f007874..560c0e0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -86,7 +86,7 @@ int safe_create_leading_directories(char *path)
>  	char *pos = path;
>  	struct stat st;
>  
> -	if (*pos == '/')
> +	if (is_absolute_path(path))
>  		pos++;

Is this enough?  On Windows, certain "absolute" paths would need "pos += 
3", no?

Ciao,
Dscho
