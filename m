From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: FEATURE REQUEST: Allow SSH style URLS (with extra colon)
Date: Sat, 30 Jan 2010 19:27:30 +0200
Message-ID: <20100130172730.GA28865@Knoppix>
References: <87tyu3cyy3.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 18:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbH6i-0003H3-Us
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 18:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab0A3R1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 12:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799Ab0A3R1f
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 12:27:35 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:43681 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0A3R1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 12:27:34 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id C38B3EF270;
	Sat, 30 Jan 2010 19:27:32 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06D21C0F94; Sat, 30 Jan 2010 19:27:32 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 9DAB341BEE;
	Sat, 30 Jan 2010 19:27:30 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <87tyu3cyy3.fsf@jondo.cante.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138487>

On Sat, Jan 30, 2010 at 06:57:56PM +0200, Jari Aalto wrote:
> 
> According to git-clone[1] the SSH protocol is specied as:
> 
>     ssh://[user@]host.xz[:port]/path
> 
> It woudl be nice if the ":" were allowed, so that the familiar SSH style
> patch notation could be used, making the spec:
> 
>     ssh://[user@]host.xz[:[port]]/path
> 
> An example:
> 
>     ssh://foo@examplecom:/path
>                         |
>                         Allowed
> 

I would use:

ssh://[user@]host.xz[:port][:]/path

Since empty port isn't allowed, this grammar is uniquely parseable,
and would allow specifying port too (if you don't need to specify
it, you could just use the scp syntax)[1].

[1] Of course 'ssh://[user@]host.xz[:port]/~/path' works too..

-Ilari
