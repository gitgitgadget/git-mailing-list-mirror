From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sat, 14 Apr 2012 13:18:23 -0500
Message-ID: <20120414181823.GB4560@burratino>
References: <4F89ADCD.6000109@pileofstuff.org>
 <20120414171431.GA4161@burratino>
 <4F89B5C5.3030606@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 20:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ7YO-00065r-Gk
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 20:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab2DNSS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 14:18:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53517 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2DNSS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 14:18:27 -0400
Received: by iagz16 with SMTP id z16so5637462iag.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YrLqNMtdNil6xqiusUZOJ5NXaw8LVIAjgcpJYrdmF7A=;
        b=yYA9Td62MeNTYuIO9zb1tw8PuTF+ZQFwoBql2IsKB30lBfM37BB963Ggv1w2hqOaO6
         BfrklgPk4U+8ZLs/QfN163euYrrwwUUbdus6SdN4Thi1oooU6Medvss5PXRabIweI87v
         Ft04KLitabXhlmJbe4Wg0GGeUtXPdW9fPevwxkItpMU5cTJ7ilOMo1vFb0VUvGtLyEIG
         leWSZTPJHN/VPKwxM4JW3tyuz/LKMqYgVXdl8VKqE791XQPv4xbWsV7rl5cm66MvEe4q
         DdNg8ugThNloegas8Z1Qphz6rzv/+GneoUI55kjij6Yso57DV7HMUy4CTexZ3pUiTucx
         tZ9Q==
Received: by 10.50.190.197 with SMTP id gs5mr1688900igc.37.1334427507146;
        Sat, 14 Apr 2012 11:18:27 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id en3sm7919648igc.2.2012.04.14.11.18.26
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 11:18:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F89B5C5.3030606@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195500>

Andrew Sayers wrote:

>                  For example, the handling of NUL characters is worse
> than newlines

Filenames are C strings.  Filenames with NUL bytes simply do not
exist, at least as long as one is using the ANSI C or POSIX interfaces
for file access.

So as far as I can tell the story really is only about newlines.  (If
svn-fe tried to push history back to Subversion, life would presumably
be more complicated.)

Hoping that clarifies a little,
Jonathan
