From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Identify all summary metadata table rows
Date: Thu, 02 Oct 2008 18:04:56 -0700 (PDT)
Message-ID: <m3hc7uqyix.fsf@localhost.localdomain>
References: <1222957505-5150-1-git-send-email-pasky@suse.cz>
	<20081003003053.GT21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Petr Baudis <petr.baudis@novartis.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlZ7S-0004r2-HK
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 03:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbYJCBFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 21:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753793AbYJCBFA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 21:05:00 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:38941 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbYJCBE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 21:04:59 -0400
Received: by ik-out-1112.google.com with SMTP id c30so916115ika.5
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 18:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=chDNmIT0F6+y/rMmKUQybsSePMpYyguBpvT8WwYUPrk=;
        b=fiSOxurOWztfFknCh5dMGGXnarZmzARt/IDZFWhJ9A3bY1wdi1LruDp0iTMkbH3cuB
         CvGAtneCg6jOV/KMIzIYKLRlb6rU/kiHKRkZHsx6Kichg4gFBKStELcuebWcuh6a9uIM
         tiq+gSnbZr4tH7HtZr97bA593JoLGu8v/UePE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=OGRcN5iDv31SoBTTSLq+6RlloyA3mxxMgwZTG7N49e9f4PJmroq/KwqdRQjLauMKnn
         YMH/xAhyFKS8rwDT1Qqit7giyVJktuFAN7O99sCrHcpLWPVRij1GyvptfjvKtQcLkKxN
         Nz+gg+bwimHgd6R/3l4HuxassVw0OlG1hymsk=
Received: by 10.210.54.19 with SMTP id c19mr418833eba.106.1222995897716;
        Thu, 02 Oct 2008 18:04:57 -0700 (PDT)
Received: from localhost.localdomain (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 10sm3313391eyd.6.2008.10.02.18.04.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 18:04:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9314vHG023385;
	Fri, 3 Oct 2008 03:04:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9314tf5023382;
	Fri, 3 Oct 2008 03:04:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081003003053.GT21310@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97386>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> Petr Baudis <pasky@suse.cz> wrote:

> > In the metadata table of the summary page, all rows have their
> > id (or class in case of URL) set now. This for example lets sites
> > easily disable fields they do not want to show in their custom
> > stylesheet (e.g. they are overly technical or irrelevant for the site).
> > 
> > Many of my other patches depend on this, so I would appreciate to hear
> > as soon as possible if someone has an issue with this patch.
> 
> Its pretty trivial and painless.  So its applied.  Marking up unique
> elements so you can control them via CSS isn't rocket science.  ;-)

Somehow original patch didn't appear (yet) on git mailing list;
perhaps it ran afoul vger anti-SPAM filter...
 
> > +	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
> > +	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
> > +		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
> > +		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";

I like the idea, and I think this can be seen as beginning to use
either microformats, or RDFa.  You have marked those fragments for CSS
to show or hide; microformats are about marking those fragments for
machine to parse.  Although microformats usually use 'class' (or 'rel'
for links), not 'id' attribute for classifying data...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
