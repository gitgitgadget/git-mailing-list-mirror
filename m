From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 14:16:15 -0700
Message-ID: <20150429211615.GR5467@google.com>
References: <1430341032.14907.9.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:16:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZLC-0005nV-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbbD2VQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:16:19 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35120 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbbD2VQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:16:18 -0400
Received: by igbyr2 with SMTP id yr2so131278460igb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BfeSiU9dgx8EtSTPwc2E/BgIGtsQGlLDnciy6mm5Bjw=;
        b=sK/If6RQyuQBGrwZm0ACn0xGSIM8HDdWkdapCSMWVzYR6i+rFuM5PnIg4RZcNt1kPX
         h+258/nJuH2tBKtYAmNMsM9GPPgU2B3BrAbPkabvCYMl9Gw7lyOlalohf6OhqyA68uVj
         lDZhXgVideJnzTzzqsEVXpJtpmBo9yadt4oGtf0ir6HWMjURTVG40kW18R25LMg34ZZf
         C5NLf6jOsG1xULDKtjRBqMPtazCv5zV/gzA2ids2OLDH5XCJKPs3phVkMx5yXTGNVp0n
         tuOGUKpGfQ+jhjZR+T8p9u9JaSlQHs1vT3oB9ehMJITQgT7ipy6ZYwFWHsozrhs2BHEn
         6rmQ==
X-Received: by 10.107.33.21 with SMTP id h21mr1473740ioh.1.1430342177719;
        Wed, 29 Apr 2015 14:16:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:71e2:5d4a:c0e6:7f1b])
        by mx.google.com with ESMTPSA id j2sm175455ioi.8.2015.04.29.14.16.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Apr 2015 14:16:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430341032.14907.9.camel@ubuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268004>

Hi,

David Turner wrote:

> Instead, it would be cool if cat-file had a mode in which it would
> follow symlinks.

Makes sense.

> The major wrinkle is that symlinks can point outside the repository --
> either because they are absolute paths, or because they are relative
> paths with enough ../ in them.  For this case, I propose that
> --follow-symlinks should output [sha] "symlink" [target] instead of the
> usual [sha] "blob" [bytes].

What happens when the symlink payload contains a newline?

Thanks,
Jonathan
