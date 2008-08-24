From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sun, 24 Aug 2008 21:30:58 +0200
Message-ID: <48B1B6F2.5050301@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:32:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXLJk-00042o-KL
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYHXTbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbYHXTbA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 15:31:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:63002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbYHXTa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 15:30:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so773477fgg.17
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=/c3iMaO/KX7bYwFStnajAzqSz/4kDxV2cl9fXXqo4gw=;
        b=Ipai57pYh0I3jjeVvaXOQs08bPkq4Oqd6A9ikdMeUHDWXGyeUUjjyPbkHNevl0Zkh2
         Q84pz5DtS+l+H8AYOjnyrOjSDQJWa+fRFXKdk9Li5tSU3R5lfHXmIHyqOODzxOU6Zhcm
         9zZCYnka2eqqqxQXElAzIz9C2xT2s8QZm3HnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=euEqCSxn9GLG0moGbZyc9ENJ1VDr6brk1MlYz2PTJAJDpphBjcBZ/0XEoHPI8Yugq8
         3FDE0P4v59SUNm9wuevWfF2oZ12cxdHGgS6EWEqsZ9x1hgDpuwSCI92C/GKCUcYMpny8
         5ILKmw6k8LY19kHJp51AlT9837M1NNDUC5eE0=
Received: by 10.86.52.6 with SMTP id z6mr2711782fgz.48.1219606258157;
        Sun, 24 Aug 2008 12:30:58 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.227.8])
        by mx.google.com with ESMTPS id 4sm4503547fge.8.2008.08.24.12.30.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 12:30:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93553>

Giuseppe Bilotta wrote:
> +			my $git_type = git_get_type($ref);
> [...]
> +				$cgi->a({-href => href(action=>$view{$git_type} || $git_type, hash=>$name)}, $name) .

Since some of this thread seems to be about performance, you might just
make this a link to action => 'object' (and save the git_get_type call)
and let gitweb Do The Right Thing when the link is followed.

[Disclaimer: Haven't read the whole thread, and haven't checked if
action=object is actually doing the right thing here.]

-- Lea
