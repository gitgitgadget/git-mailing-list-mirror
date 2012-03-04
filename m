From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-svn show-externals and svn version
Date: Sun, 04 Mar 2012 02:46:53 -0800 (PST)
Message-ID: <m3sjhotzhj.fsf@localhost.localdomain>
References: <E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de>
	<994D6101-DD43-4CD9-BB96-34807E3087C4@nikolaus-demmel.de>
	<5B8386D7-3C01-4A58-A7AB-9AA43BB45572@nikolaus-demmel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
X-From: git-owner@vger.kernel.org Sun Mar 04 11:47:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S48xz-0003qv-8n
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 11:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab2CDKq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 05:46:56 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49823 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab2CDKqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 05:46:55 -0500
Received: by eaaq12 with SMTP id q12so1071871eaa.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 02:46:53 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.27.142 as permitted sender) client-ip=10.14.27.142;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.27.142 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.27.142])
        by 10.14.27.142 with SMTP id e14mr9405127eea.70.1330858013807 (num_hops = 1);
        Sun, 04 Mar 2012 02:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=bpJjd41uYUxYQGmfNq3das1KMc+79eQVGvyoqskVvgo=;
        b=IsdSInBzJ05Cs5AnP17qgpa27jM/f1h1TQmI7MIWisq1PaFeQep1MVdB3/7bvo8EER
         ZQK52IMSn3w8srWAPFLmyNpzGfPCN93ZnzTqYM6JXafqGnZtJ6gfEvCsWFvUr7Zeq+76
         gNIvSGyW+t5E5cVU5mXCGmYKZQ28U2uGYGWiSFsqGvhH/Z130hOd5wQebMfHxXSdSkgH
         aJ+1z0Rxq6bNBCWp/ZGWw0v5C/8vCvmG9Q6fnCHn2nvbS9/DMOjN8BCeFOL7h4XklnJ3
         +pKdSnl79o5ZOYycEskKfsY8rSydFH1/E+m81Gdlrlh9f6Wes9fej+veD+3yfA4IOxUg
         KGiw==
Received: by 10.14.27.142 with SMTP id e14mr7165910eea.70.1330858013704;
        Sun, 04 Mar 2012 02:46:53 -0800 (PST)
Received: from localhost.localdomain (abwo57.neoplus.adsl.tpnet.pl. [83.8.238.57])
        by mx.google.com with ESMTPS id z47sm20643300een.5.2012.03.04.02.46.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 02:46:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q24AkoI1022695;
	Sun, 4 Mar 2012 11:46:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q24AkngA022692;
	Sun, 4 Mar 2012 11:46:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5B8386D7-3C01-4A58-A7AB-9AA43BB45572@nikolaus-demmel.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192149>

Nikolaus Demmel <nikolaus@nikolaus-demmel.de> writes:

> I feel a bit like I am talking to myself, but I see from the high
> traffic on this list that people are busy doing great things :-). I will
> write anyway in case someone interested in git-svn listens.
> 
> Is there an appropriate place to file these kinds of feature/enhancement
> requests?
> 
> So I've investigated the matter a bit further. Turns out in the
> subversion SWIG language bindings there is an API function that parses
> svn:externals definitions for you. See [1] for a recent (minimal) change
> to make this function available in python. I guess supporting Perl
> requires equally minimal changes. I haven't attempted it myself since I
> know neither Perl nor SWIG.
> 
> How could this be used in git-svn show-externals? As layed out before, I
> believe that the current output for the svn1.5 syntax is inherently
> broken and we should not worry about backwards compatibility for
> that. To maintain backwards compatibility with the output for the old
> format and to give a canonical, easy to parse, output for any external
> definition, I suggest sticking to the current format, just inserting the
> parsed definition at the appropriate place with relative URLs completely
> resolved to absolute ones.
[...]

> Thoughts, comments, opinions?

Perhaps better support for svn:externals would be a good project for
Git in Google Summer of Code 2012?  You could write a proposal, see

* GSoC 2012 application process
  Message-ID: <20120302091114.GA3984@sigill.intra.peff.net>
  http://thread.gmane.org/gmane.comp.version-control.git/192014 

* [RFC] "Remote helper for Subversion" project
  Message-ID: <1330777646-28381-1-git-send-email-davidbarr@google.com>
  http://thread.gmane.org/gmane.comp.version-control.git/192106

* https://github.com/peff/git/wiki/SoC-2012-Ideas

-- 
Jakub Narebski
