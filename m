From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Thu, 9 Apr 2009 12:15:08 +0200
Message-ID: <adf1fd3d0904090315x10b8c481g311832c40c450c47@mail.gmail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
	 <20090407071656.GE2924@coredump.intra.peff.net>
	 <49DB089A.7080207@drmicha.warpmail.net>
	 <20090409082350.GD17221@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 12:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrrJd-0005Vz-HZ
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 12:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760758AbZDIKPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 06:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758161AbZDIKPM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 06:15:12 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57249 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760075AbZDIKPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 06:15:10 -0400
Received: by fxm2 with SMTP id 2so514129fxm.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 03:15:08 -0700 (PDT)
Received: by 10.103.220.18 with SMTP id x18mr1140788muq.38.1239272108512; Thu, 
	09 Apr 2009 03:15:08 -0700 (PDT)
In-Reply-To: <20090409082350.GD17221@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116159>

2009/4/9 Jeff King <peff@peff.net>:
> On Tue, Apr 07, 2009 at 10:02:34AM +0200, Michael J Gruber wrote:
>
>> > will be interpreted as "origin/master is ahead 5, behind 6" when it is
>> > really the reverse. Maybe "[ahead 5, behind 6 from origin/master]" would
>> > be better?
>>
>> Maybe [origin/master +5 -6]? That should be short enough for sticking it
>> into -v. We could even use [origin/master +0 -0] for an up-to-date
>> branch then.
>
> I am not opposed to that format, but I don't feel strongly. And not many
> people are voicing an opinion in this thread (strange, given that it is
> an opportunity for bikeshedding :) ).

I've been thinking about this and both formats seems OK for me,
although using the +5 -6 format for just -v seems a good point.

Just to bikeshed a bit more :) we could use a format more similar to
the "git fetch" output, like:

  next         c4628f8 [4...6 origin/next] Merge branch 'jk/no-perl' into next
  next         c4628f8 [4.. origin/next] Merge branch 'jk/no-perl' into next
  next         c4628f8 [..6 origin/next] Merge branch 'jk/no-perl' into next

(three dots when they have diverged and two otherwise)

It can suggest that the left number you know it is about things in
next and the right number about things in origin/next. The problem is
that is also looks like revisions.

Just my 2cents, but feel free to ignore ;-)
Santi
