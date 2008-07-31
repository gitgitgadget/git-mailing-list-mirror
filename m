From: "Gustavo Sverzut Barbieri" <barbieri@profusion.mobi>
Subject: Re: [PATCH 0/2] gitweb use sections
Date: Thu, 31 Jul 2008 17:58:45 -0300
Message-ID: <b1f2b8c40807311358k4132ba8bw931279d7a6a7bcb5@mail.gmail.com>
References: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
	 <b1f2b8c40807311243i5689683avcc3c3c91e4e6a900@mail.gmail.com>
	 <20080731203250.GO10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfFe-0001Dz-6C
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYGaU6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbYGaU6s
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:58:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27145 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbYGaU6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:58:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so376098fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 13:58:45 -0700 (PDT)
Received: by 10.86.57.9 with SMTP id f9mr6519385fga.66.1217537925646;
        Thu, 31 Jul 2008 13:58:45 -0700 (PDT)
Received: by 10.86.90.15 with HTTP; Thu, 31 Jul 2008 13:58:45 -0700 (PDT)
In-Reply-To: <20080731203250.GO10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90988>

On Thu, Jul 31, 2008 at 5:32 PM, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
> On Thu, Jul 31, 2008 at 04:43:35PM -0300, Gustavo Sverzut Barbieri wrote:
>> Since nobody replied and I missed some gitweb guys in CC, I'm adding
>> Petr and Jakub, as some guys said on IRC.
>>
>> Have anyone tried this patch, any problems?
>
>  sorry, I have it in my review queue. At first pass it was looking
> good, but I wanted to look at it better before commenting.

no problem, just to see it was noticed or not :-)


>  One thing I'm wondering about is how to make this stuff configurable,
> since I'm not very comfortable with adding more "unbound" configuration
> variables and would rather prefer stuff to be added to the $features
> array... I'm not at all sure about my own sentiment here, however.

Path comparison (first patch), Sections (second), both?

I know path comparison can be a performance hit on large listings on
sites with heavy traffic. However, I don't see many people accessing
the projects page at the same time for long periods, it's not like
slashdot... people mostly use it to know about repositories and then
use git to track it.
    The slowness is due O(n^2) worst case of sort and each step is not
a bit heavier since it need to split path into components and walk
these. Maybe cache the split?

-- 
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri@gmail.com
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
