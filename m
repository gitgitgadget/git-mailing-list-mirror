From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv5 2/5] gitweb: Incremental blame (using JavaScript)
Date: Thu, 5 Nov 2009 21:22:03 +0100
Message-ID: <20091105202202.GC17748@machine.or.cz>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
 <1251805160-5303-2-git-send-email-jnareb@gmail.com>
 <1251805160-5303-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68r4-0007r3-8B
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758503AbZKEUWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758447AbZKEUWB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:22:01 -0500
Received: from w241.dkm.cz ([62.24.88.241]:41616 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757896AbZKEUWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:22:01 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 30DE586201A; Thu,  5 Nov 2009 21:22:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1251805160-5303-3-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132243>

  Hi!

  Many thanks for nurturing this patch.

On Tue, Sep 01, 2009 at 01:39:17PM +0200, Jakub Narebski wrote:
> Roads not taken (perhaps that should be part of commit message?):
> * Move most (or all) of "git blame --incremental" output parsing to
>   server side, and instead of sending direct output in text/plain,
>   send processed data in JSON format, e.g.
> 
>     {"commit": {
>        "sha1": "e83c5163316f89bfbde7d9ab23ca2e25604af290",
>        "info": "Kay Sievers, 2005-08-07 21:49:46 +0200",
>        "author-initials": "KS",
>        ...
>      },
>      "src-line": 13,
>      "dst-line": 16,
>      "numlines": 3,
>      "filename": "README"
>      }
> 
>   (line wrapping added for readibility).  This would require however
>   taking care on Perl side to send properly formatted JSON, and on
>   JavaScript side including json2.js code to read JSON in gitweb.js
>   (unless we rely on eval).

  I don't know that much about web programming, what is wrong with
relying on eval?

  (BTW, I have always thought that somewhat inevitable course in the
future will be to provide a web API, and basing it on JSON is probably
most natural choice. However, such an initiative needs to come from
actual web programmers.)

> * Using some lightweight JavaScript library (framework), like jQuery,
>   Prototype, ExtJS, MooTools, etc.  One one hand side this means not
>   having to worry about browser incompatibilities as this would be
>   taken care of by library; on the other hand side we want gitweb to
>   have as few dependences as possible.

  Normally, particular version of the library is simply included within
the project. E.g. in Girocco, I use MooTools for the tiny bit of
javascript I do. It is probably overkill to include it just for
incremental blame, but if we ever do much more, I think the much easier
web programming is worth the little trouble.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
