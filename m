From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 20:59:29 -0400
Message-ID: <9e4733910609061759m2aae9e31ja146e309dc449628@mail.gmail.com>
References: <44FF41F4.1090906@gmail.com>
	 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
	 <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:59:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL8Ev-0004Q4-7b
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWIGA7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWIGA7a
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:59:30 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:32266 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161044AbWIGA73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:59:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so49220pyg
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 17:59:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pW2WnqFaI2ooJJHfl86dcepeapk1+HBjXentCDp43EyKBv964AXlpD2zDi0iEuYnTZG8bmo4D6gaqAyNEUPoRwW1RlkGDn3I3k4CQXLvOD25AUkf3uCe7cDd27IKlqNfl9a0EhIoUrh9WqkjnQ0VjJXlxTuijQC7r29buvhyiKA=
Received: by 10.35.45.1 with SMTP id x1mr219913pyj;
        Wed, 06 Sep 2006 17:59:29 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 6 Sep 2006 17:59:28 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26583>

On 9/6/06, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 6 Sep 2006, Jon Smirl wrote:
>
> > Shawn is doing some prototype work on true dictionary based
> > compression. I don't know how far along he is but it has potential for
> > taking 30% off the Mozilla pack.
>
> BTW I'm half-way done with support for deltas which base object is
> referenced with an offset in the pack instead of a hash.  It is quite
> messy though since it touches pretty core code all over the place when
> it comes to fetching objects out of a pack.

Would it help to change all of the references in the pack from sha1 to
encoded relative offsets? Then collect all of the object fetch code
into a single subroutine which would change it algorithm depending on
which type of pack it is operating on. Now the pack wouldn't mix
reference types, they would all be encoded relative or sha1.

-- 
Jon Smirl
jonsmirl@gmail.com
