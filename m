From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bisect limited to Merge Commits
Date: Wed, 27 Apr 2016 23:33:53 +0200
Message-ID: <57213041.5070506@kdbg.org>
References: <20160427204551.GB4613@virgo.localdomain>
 <xmqq8tzy93ed.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Hagen Paul Pfeifer <hagen@jauu.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:34:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avX60-0005hd-1O
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbcD0VeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:34:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:40461 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753802AbcD0VeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:34:01 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qwCrd5lj6z5tl9;
	Wed, 27 Apr 2016 23:33:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3261D5259;
	Wed, 27 Apr 2016 23:33:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqq8tzy93ed.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292831>

Am 27.04.2016 um 22:56 schrieb Junio C Hamano:
> So being able to stop at only commits on the first-parent chain is a
> valid and useful tool.  "git bisect --first-parent" is one of the
> things that are sometimes asked for.

With origin pointing to git.git, I attempted this:

  git bisect start
  git rev-list --first-parent --boundary origin..origin/pu |
    sed -ne s/-//p | xargs git bisect good
  git bisect bad origin/pu

and it starts bisecting among the 50-something first-parent commits 
between origin and origin/pu.

-- Hannes
