From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #01; Sun, 3)
Date: Mon, 04 Apr 2011 02:16:26 -0700 (PDT)
Message-ID: <m3aag64bt5.fsf@localhost.localdomain>
References: <7v62quc464.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 11:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ftk-0002cX-MA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 11:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab1DDJQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 05:16:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55170 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1DDJQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 05:16:30 -0400
Received: by bwz15 with SMTP id 15so3860246bwz.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=pJj2MvTr18uRB/mldGYDitwKHd3SMTqd6/w6aBjvL40=;
        b=P82+T9nmc06WpGB2SGsSHjufnnAFjB7xOCQ8QFG6FwYVJHFTdhOoOv1uFTI8gZyBuq
         oxZn0MXq2MrfMbl6ZaX1f+mle1nlBh5SjGZ1Bk+Bp43cHgJArf3DDTj33oEmwSym17be
         f3eRbUNRsaB6+JI2TWe/qcknSfgezA9mLIxYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Mbg12tE1GYeTVw7Y3jV+w/TQ/xGlK+yhEsnYbIPcBBGt8wM4WVhLmVVIwi/S3tti46
         5lP2h0/SWEHi944lpYlrc1xgbQatY06nU6p1Qj9gDpIAozezMyKHLAtte0rwx4IvGBH1
         xYQu84PXKOYTuXZF8ilZFrls/2yskmZ1UZ2gg=
Received: by 10.204.84.5 with SMTP id h5mr5671995bkl.201.1301908588320;
        Mon, 04 Apr 2011 02:16:28 -0700 (PDT)
Received: from localhost.localdomain (abvf154.neoplus.adsl.tpnet.pl [83.8.203.154])
        by mx.google.com with ESMTPS id c11sm2930777bkc.14.2011.04.04.02.16.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 02:16:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p349Fq6s011874;
	Mon, 4 Apr 2011 11:16:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p349FYSJ011870;
	Mon, 4 Apr 2011 11:15:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v62quc464.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170800>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
> 
> Hopefully we will have 1.7.5-rc1 coming Wednesday.

 
> --------------------------------------------------
> [Cooking]

> * jh/gitweb-localtime (2011-03-23) 1 commit
>  - gitweb: javascript ability to adjust time based on timezone

I am slowly working on this, but for various reasons most probably
I wouldn't have time to finish it before 8th April at earliest.

The split series would look something like this:
 - gitweb: Split JavaScript for maintability, combining on build
 - gitweb: Introduce and use format_timestamp
 - gitweb.js: Cookies library
 - gitweb.js: Parse W3CDTF date (ISO-8601 variant), format in RFC-2822
 - gitweb: javascript ability to adjust time based on timezone


BTW I guess that 

  [PATCH (BUGFIX)] gitweb: Fix parsing of negative fractional timezones in JavaScript
  Message-Id: <20110401190239.9686.12000.stgit@localhost.localdomain>
  http://article.gmane.org/gmane.comp.version-control.git/170606

didn't made it into this "What's cooking..." because it was send too
late (2011-04-01 19:06:28 GMT), isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
