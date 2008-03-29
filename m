From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 10:38:48 +0100
Message-ID: <200803291038.48847.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290944.55273.robin.rosenberg.lists@dewire.com> <20080329085304.GC19200@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 10:40:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfXY0-0000e0-4Q
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 10:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbYC2Jjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 05:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbYC2Jjl
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 05:39:41 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27506 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbYC2Jjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 05:39:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AB8218026E9;
	Sat, 29 Mar 2008 10:39:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Sg2N1geaG-d; Sat, 29 Mar 2008 10:39:39 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 292C4802679;
	Sat, 29 Mar 2008 10:39:38 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329085304.GC19200@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78460>

Den Saturday 29 March 2008 09.53.04 skrev Jeff King:
> On Sat, Mar 29, 2008 at 09:44:55AM +0100, Robin Rosenberg wrote:
> > > OK. Do you have an example function that guesses with high probability
> > > whether a string is utf-8? If there are non-ascii characters but we
> > > _don't_ guess utf-8, what should we do?
> >
> > I guess the best bet is to assume the locale. Btw, is the encoding header
> > from the commit (when present) completely lost? (not that it can be
> > trusted anyway).
>
> What do you mean by "assume the locale"?  Is there a portable way to say
> "this is the encoding of the locale the user has chosen?" On my system I
> set LANG=en_US, and behind-the-scenes magic chooses utf-8 versus
> iso8859-1.

The environment variables are only part of the story. There is a langinfo API 
for this. See I18N::Langinfo(3pm) that knows about those and something else.

# perl -e 'require I18N::Langinfo; I18N::Langinfo->import(qw(langinfo 
CODESET)); $codeset = langinfo(CODESET()); print "My codeset=".
$codeset."\n";'
My codeset=ISO-8859-15

-- robin
