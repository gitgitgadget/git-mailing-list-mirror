From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH, RFC] diff: add option to show context between close  
 chunks
Date: Tue, 21 Oct 2008 14:16:10 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810211403120.19665@iabervon.org>
References: <48FB757B.9030105@lsrfire.ath.cx> <7vabcy3k9l.fsf@gitster.siamese.dyndns.org> <48FD781C.2000103@viscovery.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1791605661-1224612970=:19665"
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 20:17:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsLnJ-00051y-TK
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 20:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbYJUSQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYJUSQM
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 14:16:12 -0400
Received: from iabervon.org ([66.92.72.58]:49061 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbYJUSQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 14:16:12 -0400
Received: (qmail 32578 invoked by uid 1000); 21 Oct 2008 18:16:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2008 18:16:10 -0000
In-Reply-To: <48FD781C.2000103@viscovery.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98802>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1791605661-1224612970=:19665
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Oct 2008, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > René Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> > 
> >> I think it makes sense to make 1, or even 3, the default for this
> >> option for all commands that create patches intended for human
> >> consumption.  The patch keeps the default at 0, though.
> > 
> > I think defaulting to 1 would make sense, or alternatively, just
> > hardcoding that behaviour without any new option.  That would give you
> > more information with the same number of patch lines, iow, upside without
> > any downside.
> 
> Are you sure about the "without any downside" part? The extra context line
> inhibits that the patch applies cleanly to a version of the file that has
> that very line modified (including a different number of lines).

We could start allowing "fuzz" by default in the case of a patch with more 
context than we'd expect to see. That is, git-apply would ignore context 
lines more than 3 lines away from any changed lines, sharing the 
assumption of our patch-generation side that lines that far away don't 
matter in general. (Now, if people were in the habit of including as 
context additional lines in fragile locations, this wouldn't be a good 
assumption, but I doubt anybody would be able to identify such lines to 
include them).

	-Daniel
*This .sig left intentionally blank*
--1547844168-1791605661-1224612970=:19665--
