From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 02:37:39 +0100
Message-ID: <200701100237.40059.jnareb@gmail.com>
References: <87odphgfzz.wl%cworth@cworth.org> <20070110003433.GH30023@spearce.org> <Pine.LNX.4.64.0701092014390.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4SPG-00013O-3J
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbXAJBhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbXAJBhb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:37:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:48630 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbXAJBha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:37:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6750089uga
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 17:37:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z2obu8VeYuUb4EySKs249WvJS8PxNJIy3lAHJNrEU6PGdd3VaqdhNKuB7QYn4uikkelRge5+f3tDwgy41iWT/0NkxFOlFZOhXvNzZdErZHSAu/inYZYK0nO+bb/swVGtlgKhBaGGuX/Se9h/5i2ZGyGfGw3lCVg0bo4BICtduYA=
Received: by 10.67.21.11 with SMTP id y11mr23742757ugi.1168393049211;
        Tue, 09 Jan 2007 17:37:29 -0800 (PST)
Received: from host-81-190-20-31.torun.mm.pl ( [81.190.20.31])
        by mx.google.com with ESMTP id m1sm41691245uge.2007.01.09.17.37.28;
        Tue, 09 Jan 2007 17:37:29 -0800 (PST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0701092014390.4964@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36465>

Nicolas Pitre wrote:
> On Tue, 9 Jan 2007, Shawn O. Pearce wrote:
> 
>> Jakub Narebski <jnareb@gmail.com> wrote:
>>> Shawn O. Pearce wrote:
>>> 
>>>> In my mind that is a small price to pay for making sure the
>>>> commit currently in a detached HEAD doesn't get orphaned off
>>>> into never-never land.
>>> 
>>> By the way, would detached HEAD be reflogged, and if it would
>>> (and certainly it would be nice to have, because protection or
>>> not sh*t happens) how it would be implemented?
>> 
>> Ohhhhh.  It should reflog if .git/logs/HEAD exists, so long as
>> changes to HEAD are done via update-ref and not just by echo (as
>> one of Junio's versions of the feature had done).
>> 
>> Unfortunately .git/logs/HEAD wouldn't be created by default as its
>> not under refs/heads or refs/remotes.  Though it could be made to be
>> on by default, in which case it would only log changes while HEAD
>> is detached.  If HEAD is attached to a branch then .git/logs/HEAD
>> wouldn't be appended to (or even created), while the branch's own
>> log is still appended to.
> 
> Is this worth the trouble and complexity?  After all detached heads
> are not meant to be used for serious development.

I think reflogging detached HEAD is easier than adding safety checks
either on commit (no commits on top of detached HEAD), or on checkouts
and stuff (try not to loose unless forced chain of commits built on top
of detached HEAD).
-- 
Jakub Narebski
Poland
