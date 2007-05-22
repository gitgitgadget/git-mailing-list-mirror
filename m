From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] Use stringbuf to fix buffer overflows due to broken use of snprintf()
Date: Tue, 22 May 2007 15:43:06 +0200
Message-ID: <20070522134306.GL4489@pasky.or.cz>
References: <1179627879.32181.1286.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 22 15:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqUdq-0006Nb-Hr
	for gcvg-git@gmane.org; Tue, 22 May 2007 15:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062AbXEVNnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 09:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757154AbXEVNnI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 09:43:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59061 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757062AbXEVNnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 09:43:07 -0400
Received: (qmail 1219 invoked by uid 2001); 22 May 2007 15:43:06 +0200
Content-Disposition: inline
In-Reply-To: <1179627879.32181.1286.camel@hurina>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48108>

On Sun, May 20, 2007 at 04:24:39AM CEST, Timo Sirainen wrote:
> @@ -1823,14 +1824,14 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
>  static void run_diff(struct diff_filepair *p, struct diff_options *o)
>  {
>  	const char *pgm = external_diff();
> -	char msg[PATH_MAX*2+300], *xfrm_msg;
> +	stringbuf(msg, PATH_MAX*2+300);

I don't find this style of declaring a variable too clear; I think it
might be worthwhile to make this stand out more and uppercase the
stringbuf() macro.


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
