From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list (templating)
Date: Thu, 25 Sep 2008 18:52:22 +0200
Message-ID: <200809251852.23315.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com> <20080925133320.GK10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 25 18:53:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiu66-0005sG-C8
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 18:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYIYQwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbYIYQwb
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 12:52:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:65180 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYIYQwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 12:52:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so205455nfc.21
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2+E3blF4Ke+bx9QcxKlGrtzlI9VOPtSr07xOKzTXY7k=;
        b=SN5b4j1Q3m86VkfG5hM8ZdB5qakHabrMMuRX7vcIde7Wzp69qLjsuksf3LpxI3Y0im
         T7LjQ+u8ZJPNnllxFaEhfHANDx0xt/Z/p0LV9388yJNxs/qROnbosZDZK3rfKwMlzs7u
         xDymYkC2f0JuW5hzXvWYooCYMuHDvALYhaefU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eeu1SO0xtIBPe6gBarWp09c7GDoyo6MApCkIHvryXwvThNKdxZ/bGI2fe+aacrnF6r
         ov+/owuhra5b+/frFc12eCG79QChfJONpLH5FV5MouBFwMfK6UHdAo23JzVsGx7q/uyF
         7ngYTUlIrZJzbcDrHhXOaTr1vOhxAfXt/P+Q8=
Received: by 10.86.90.13 with SMTP id n13mr292527fgb.3.1222361548186;
        Thu, 25 Sep 2008 09:52:28 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.235.56])
        by mx.google.com with ESMTPS id d6sm1797112fga.2.2008.09.25.09.52.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 09:52:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080925133320.GK10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96783>

Petr Baudis wrote:
> On Thu, Sep 25, 2008 at 03:19:09PM +0200, Wincent Colaiuta wrote:
> >
> > One which I'm looking at doing is supporting reading the "README.html" from 
> > the tree indicated by the current HEAD instead of reading it from a file in 
> > the .git directory.
[...]
> > Obviously, will have to make this optional and configurable. I'm thinking 
> > of providing a means of specifying the filename to look for (no filename, 
> > the default, means don't look), and also a setting to indicate the content 
> > type of the file (either plain text, which would be wrapped in a 
> > <pre></pre> block with HTML entities used where appropriate, or HTML which 
> > would be included verbatim).
> 
> In my queue and something I will hopefully get to submit tomorrow or at
> the beginning of next week is actually support for full-blown templating
> of gitweb pages (customization of the summary page, even adding extra
> project actions) based on gitconfig-style specification within the
> project HEAD. In its simplest variant, this could be used for including
> a README from the HEAD tree as well, I think. But it's in the same class
> as the git-gui support for the 'publish' dialog, something potentially
> useful for others, but not *universally* useful and in this case,
> unfortunately somewhat invasive.

I think that making gitweb use something like Gitweb::Template, where
action appearance is governed by templates, be it something like
git-for-each-ref --format or StGit *.tmpl files, or XSLT / XSL,
could be a good idea.  But I think _that_ would require almost writing
from scratch, certainly making it long-term gitweb fork, perhaps even
with different name (and not residing inside git.git repository).

We can discuss this idea here in this subthread.  For example: do
create Gitweb::Template like HTML::Template or use Template Toolkit;
which parts put in template and which in "gitweb" driver, etc.

-- 
Jakub Narebski
Poland
