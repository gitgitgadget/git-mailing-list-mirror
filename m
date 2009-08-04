From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] gitk: new option to hide remote refs
Date: Tue, 4 Aug 2009 11:08:17 +0200
Message-ID: <200908041108.19108.trast@student.ethz.ch>
References: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch> <7vab2g6qkd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Thell Fowler <tbfowler4@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 11:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYG15-0008GE-Du
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 11:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbZHDJIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbZHDJIx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 05:08:53 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:51009 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522AbZHDJIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 05:08:52 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 4 Aug
 2009 11:08:51 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 4 Aug
 2009 11:08:31 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <7vab2g6qkd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124771>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > -	    if {![string match "*/HEAD" $name]} {
> > +	    if {![string match "*/HEAD" $name] && !$hideremotes} {
> 
> Hmm, I wonder if it would be more useful to extend this by using $skiprefs
> pattern instead, like so:
[...]
> +	if {$skiprefs != "" && [string match $skiprefs $name]} continue

Shortly after sending the patch, I had another idea: how about an
option to only show refs that were given on the command line, if any?
That way 'gitk --branches' or 'gitk HEAD' would hide the whole remotes
mess (and of course also all other refs in the process).  I think I
might be able to voodoo enough Tk to implement this.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
