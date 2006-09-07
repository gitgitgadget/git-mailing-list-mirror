From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 19:33:06 -0700
Message-ID: <44FF84E2.5040201@gmail.com>
References: <44FF41F4.1090906@gmail.com>	 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>	 <Pine.LNX.4.64.0609062037560.18635@xanadu.home> <9e4733910609061759m2aae9e31ja146e309dc449628@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 04:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL9hb-0001T8-2V
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 04:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWIGCdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWIGCdL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 22:33:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:19802 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422670AbWIGCdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 22:33:09 -0400
Received: by nz-out-0102.google.com with SMTP id n1so25922nzf
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:33:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VFWqvWFezyyo91z2jerVJgX/I1rSpKwJ8r6SWAUb+ztZfTRec7ii4oWf6CbMLcHHeSwAUSnOhYnWnDZVXj2vXOfulmsG4Qmr+HTqjeJzWDt7VcWWTAJuuxOnHfTrAGR4W2/oXU2Xy1iNxt+XXKvZmuw8ETnv1O4fQWiJAzhbCXE=
Received: by 10.65.139.9 with SMTP id r9mr195659qbn;
        Wed, 06 Sep 2006 19:33:08 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id f13sm132592qba.2006.09.06.19.33.07;
        Wed, 06 Sep 2006 19:33:08 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609061759m2aae9e31ja146e309dc449628@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26587>

Jon Smirl wrote:
> On 9/6/06, Nicolas Pitre <nico@cam.org> wrote:
>> On Wed, 6 Sep 2006, Jon Smirl wrote:
>>
>> > Shawn is doing some prototype work on true dictionary based
>> > compression. I don't know how far along he is but it has potential for
>> > taking 30% off the Mozilla pack.
>>
>> BTW I'm half-way done with support for deltas which base object is
>> referenced with an offset in the pack instead of a hash.  It is quite
>> messy though since it touches pretty core code all over the place when
>> it comes to fetching objects out of a pack.
> 
> Would it help to change all of the references in the pack from sha1 to
> encoded relative offsets? Then collect all of the object fetch code
> into a single subroutine which would change it algorithm depending on
> which type of pack it is operating on. Now the pack wouldn't mix
> reference types, they would all be encoded relative or sha1.
> 

Support for 'thin' packs would pretty much require mixing IDs and
(relative) offsets in the same pack file.
