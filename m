From: Frans Pop <elendil@planet.nl>
Subject: Re: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 19:38:24 +0200
Message-ID: <200907281938.24960.elendil@planet.nl>
References: <200907280513.59374.elendil@planet.nl> <20090728142219.GA16168@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:38:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVqdH-0005zu-FS
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 19:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZG1Ri0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 13:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbZG1Ri0
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 13:38:26 -0400
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:51294 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753533AbZG1RiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 13:38:25 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML110.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 19:38:25 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090728142219.GA16168@vidovic>
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 17:38:25.0685 (UTC) FILETIME=[35E9C450:01CA0FAA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124263>

On Tuesday 28 July 2009, Nicolas Sebrecht wrote:
> The 28/07/09, Frans Pop wrote:
> > That's a very useful feature. However, on lkml there are frequently
> > also mails with the following structure (example: [1]).
> >
> > [1] http://lkml.org/lkml/2009/7/10/49
>
> This is an example of what not to do. Content after the '---' won't be
> part of the commit message.

Yes, I'm aware of that (and I omitted such a line from my example for that 
reason). But currently that's not really relevant as either with or 
without that line one needs to manually fix up things before the desired 
result is obtained.

If my feature request is implemented I'll of course make sure to omit the
'---' line if needed.

Here are some other examples (some of which would equally need to drop or 
change a separator line).
http://lkml.org/lkml/2009/6/25/62
http://lkml.org/lkml/2009/6/22/114
http://lkml.org/lkml/2009/6/30/109
http://lkml.org/lkml/2009/6/30/224

> IMHO, a better way would be to ignore lines beginning with a defined
> level of quotes in the commit message (the "level" beeing the number of
> '>' or '> ' found at the beginning of a line. Something like
>
> 	--strip-quotes[=N]
>
> where N is the level of quoted lines to remove (if "=N" is
> not given, assume that the level is 1 and remove all the quotes).

As Mark Brown has already said, that won't solve the issue for an 
introduction or comments added by the sender of the mail.
Also, people use all kinds of quoting schemes, not just leading ">".

And I've also seen plenty of cases where quoted lines _were_ a desired 
part of a commit log.

Thanks,
FJP
