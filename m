From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v4 00/26] Return of smart HTTP
Date: Thu, 29 Oct 2009 01:12:17 -0700 (PDT)
Message-ID: <m3my3ad3gp.fsf@localhost.localdomain>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 09:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Q7a-0000Sw-OS
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 09:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbZJ2IMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 04:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZJ2IMS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 04:12:18 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:49793 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbZJ2IMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 04:12:15 -0400
Received: by bwz27 with SMTP id 27so1963750bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=w/fnw/9iYHprndYb4WKysMg7gC/UNaizTe8f6fQLTak=;
        b=YVpQr+1uZtp6waqUn9k1I6fdUXv9qmj/bNE0GqvSMqGwI4ZyMd1bTMmbaHMbV+1K0K
         +xhoBsouvfCqGTCEH6NlDAyXu7pzYneOnFkQ7WVZseKqdjOcsg3TZc2vehciGB6eguKI
         21R2T+oRJo6C6P1BbwQaMf6L1U0l3mDKKCZyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=W4UbDlz8qU6GWov0nHiZzeUG7U9yNznbh5Wo4y5rFEWwp8AHzU6+rmLQJwG9pqvxVp
         cVBEYXq3bR3++Th9W5Syy70ap0lAd0pavVsp7QanPbRfd3WPUBfNcvGsa8eriPqH/4pG
         12t/BpUcZfgTcVNHdRV6Zv9RVHljEbd90KmBE=
Received: by 10.204.32.146 with SMTP id c18mr4657945bkd.88.1256803938284;
        Thu, 29 Oct 2009 01:12:18 -0700 (PDT)
Received: from localhost.localdomain (abwt44.neoplus.adsl.tpnet.pl [83.8.243.44])
        by mx.google.com with ESMTPS id 18sm3509876fkq.37.2009.10.29.01.12.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 01:12:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9T8Bqbs003176;
	Thu, 29 Oct 2009 09:11:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9T8BbLs003169;
	Thu, 29 Oct 2009 09:11:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131574>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I think this is the final spin of the smart HTTP series.  I've
> collected patches from a few others (thanks folks!)  and added
> tests specific to the smart variant of the HTTP transport.
> 
> At this point, I think it is "next ready"... but would appreciate
> any additional feedback if folks identify something we should
> address before hitting next.
[...]

>  .gitignore                           |    1 +
>  Documentation/config.txt             |    8 +
>  Documentation/git-http-backend.txt   |  170 ++++++++
>  Documentation/git-remote-helpers.txt |   85 ++++-
>  Makefile                             |    1 +
[...]

>  32 files changed, 2574 insertions(+), 223 deletions(-)
>  create mode 100644 Documentation/git-http-backend.txt
>  create mode 100644 http-backend.c
>  create mode 100755 t/t5541-http-push.sh
>  create mode 100755 t/t5551-http-fetch.sh
 
If it is a final spin, then what of missing RFC-like documentation of
Git HTTP protocol in Documentation/technical/http-protocol.txt
(it was present only in first version of new series)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
