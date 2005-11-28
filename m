From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv: fully detect 'directory moved into itself'
Date: Mon, 28 Nov 2005 01:24:10 -0800
Message-ID: <7vbr05xgzp.fsf@assigned-by-dhcp.cox.net>
References: <200511272206.43113.Josef.Weidendorfer@gmx.de>
	<pan.2005.11.28.06.54.32.809941@smurf.noris.de>
	<200511281015.15188.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 10:25:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgfFB-0002su-WF
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVK1JYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVK1JYM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:24:12 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:11996 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750754AbVK1JYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 04:24:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128092342.WVCD3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 04:23:42 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511281015.15188.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 28 Nov 2005 10:15:15 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12866>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> This is a corrected version.
>
> On Monday 28 November 2005 07:54, Matthias Urlichs wrote:
>> Hi, Josef Weidendorfer wrote:
>> 
>> > +    if (($bad eq "") && ($dst =~ /^$src\//)) {
>> 
>> That should be
>> 
>> > +    if (($bad eq "") && ($dst =~ /^\Q$src\E\//)) {
>> 
>> otherwise you will mistakenly match "foo-bar" with "foo.bar".
>
> Ah, thanks.
> You never end learning.

Why not use $safesrc you already have for this exact purpose?
