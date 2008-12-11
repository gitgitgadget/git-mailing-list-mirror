From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] cgit in git?
Date: Thu, 11 Dec 2008 14:28:21 -0800 (PST)
Message-ID: <m3k5a6gxft.fsf@localhost.localdomain>
References: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Seth Vidal" <skvidal@fedoraproject.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAu2h-00040a-Cq
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953AbYLKW21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758052AbYLKW21
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:28:27 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:48985 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953AbYLKW2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:28:25 -0500
Received: by ey-out-2122.google.com with SMTP id 6so190131eyi.37
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 14:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Tuf2J+SzZjuQ0nRY6fwrYU1KUxHVqEm40inmrcwbi4E=;
        b=HRQZC89JvQ2Gd7jUD97HaQO/eRZkcwVGsK2jaRuiNXYBVko6RJExTh9iAmok4Qy22i
         khNVFgTS26Pr8WmKp6tIy/e1NKrtin7AFIxfLByCyxlt96guP1i5u2o5zizhyDZOD+yh
         PS3qtKcv1lVM0X7AvVO8dJgy4oSY+jc1ik8eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=m9+jq7j9lSNVYV6V1QDrD03QB4XfbWPIW/NgaspncSq2Z1xdquIQnUSGNiwu9N9/yw
         xBg+ADmIg19FGb/iY2wPCalcKSd7zGtW+bC6+21E65H6WR4k0HcSuZVfPqHprpZ/BBX+
         N5vTfNcKrWDWkHK0UCaYSSELWdWpHdaPwhnG8=
Received: by 10.210.117.1 with SMTP id p1mr14662ebc.53.1229034502091;
        Thu, 11 Dec 2008 14:28:22 -0800 (PST)
Received: from localhost.localdomain (abvq79.neoplus.adsl.tpnet.pl [83.8.214.79])
        by mx.google.com with ESMTPS id 5sm141321eyf.38.2008.12.11.14.28.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Dec 2008 14:28:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBBMRPR3026654;
	Thu, 11 Dec 2008 23:27:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBBMR3kt026649;
	Thu, 11 Dec 2008 23:27:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102831>

"Lars Hjemli" <hjemli@gmail.com> writes:

> But the buildsystem/policy used by the fedora project does not allow
> network access during package builds, and since it is quite unlikely
> that the git package always will match the exact release needed by the
> cgit package, I only see four options:
> 1) the fedora project makes a 'git-for-cgit' package containing the
> needed release of the git sources
> 2) the cgit release tarballs includes the needed git sources

2b) make cgit .spec use _two_ tarballs as a source, one with cgit
sources, one with git sources.  This assumes that you always use
released git version as a base.

This is immediate solution.

> 3) the cgit sources are subtree-merged into git

I wonder how likely this would be.

> 4) cgit is modified to link against libgit2

Option 4) would be probably best in long term, but libgit2 doesn't
exists yet.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
