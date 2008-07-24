From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH v3] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 13:16:26 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807241307020.17634@harper.uchicago.edu>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
 <200807240757.26290.chriscool@tuxfamily.org> <20080724060647.GA24587@glandium.org>
 <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
 <20080724165434.GA26660@glandium.org> <Pine.GSO.4.62.0807241233190.16518@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:18:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5OJ-0000iJ-Eq
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbYGXSQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbYGXSQy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:16:54 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:47040 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYGXSQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:16:53 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6OIGSp0032351;
	Thu, 24 Jul 2008 13:16:29 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6OIGSes017922;
	Thu, 24 Jul 2008 13:16:28 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807241233190.16518@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89929>

Jonathan Nieder wrote:

> -	test_must_fail ls .git/BISECT_* &&
> +	case $(echo .git/BISECT_*) in *\*) ;; *) false ;; esac &&

Actually, if we want to go that route, I prefer the version Dscho gave.
So please ignore my patch v3; I'd rather people choose between
Christian's and Dscho's suggestions.

Personally, without knowing how much time avoiding the ls saves, I
am not sure which is best.  Certainly the version with "ls" is clearer,
which is most important; but if the time savings (of avoiding such
constructs generally) are significant, then that is very much worthwhile
- a faster test suite can be run more often.

Jonathan
