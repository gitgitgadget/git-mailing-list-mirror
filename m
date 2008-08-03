From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Sun, 3 Aug 2008 14:25:16 -0700
Message-ID: <20080803212516.GB31762@spearce.org>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <489598C5.6060508@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 23:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPl5o-0003pT-8G
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbYHCVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbYHCVZS
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:25:18 -0400
Received: from george.spearce.org ([209.20.77.23]:47798 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbYHCVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 17:25:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E6E7238419; Sun,  3 Aug 2008 21:25:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <489598C5.6060508@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91275>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>> +#define hex(a) (hexchar[(a) & 15])
>> +static void chunked_write(const char *fmt, ...)
>> +{
>
> Maybe I am slightly confused, but I thought handling HTTP chunking for  
> HTTP/1.1+ clients was usually done by Apache above the level of the CGI  
> script?

You may be right.  Apache undoes the chunking during a POST before
feeding the data to the CGI script.  If we can omit this mess of
code from git-http-backend that's a good thing.

Thanks for the sanity check.

-- 
Shawn.
