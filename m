From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs import
Date: Wed, 13 Sep 2006 17:38:11 -0400
Message-ID: <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <450872AE.5050409@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org
X-From: git-owner@vger.kernel.org Wed Sep 13 23:38:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcQz-0005e0-S2
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWIMViN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIMViN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:38:13 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:56773 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751200AbWIMViM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:38:12 -0400
Received: by py-out-1112.google.com with SMTP id n25so3315013pyg
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 14:38:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dpBwBaKshwPALUcKb+ZxsJi1KW2X2EJF0J4Tu4kTF/2V2tSJCruvaGUcw5ALkyp5sHjbk9lNWN2KTF9rPEl2UmO+5J4m3YelXVas/jBbv6zZo7pvJQGNhW7VoSsQ2vwMq+WIenZJSuRF8XDD9IMtK7FaJsa+kdK63T9ZxdRvBLI=
Received: by 10.35.96.7 with SMTP id y7mr13792881pyl;
        Wed, 13 Sep 2006 14:38:11 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 13 Sep 2006 14:38:11 -0700 (PDT)
To: "Markus Schiltknecht" <markus@bluegap.ch>
In-Reply-To: <450872AE.5050409@bluegap.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26953>

On 9/13/06, Markus Schiltknecht <markus@bluegap.ch> wrote:
> Martin Langhoff wrote:
> > On 9/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> Let's copy the git list too and maybe we can come up with one importer
> >> for everyone.
> >
> > It's a really good idea. cvsps has been for a while a (limited, buggy)
> > attempt at that.
>
> BTW: good point, I always thought about cvsps. Does anybody know what
> 'dump' format that uses?

cvsps has potential but the multiple missing branch labels in the
Mozilla CVS confuse it and its throws away important data. It's
algorithm would need reworking too. cvs2svn is the only CVS converter
that imported Mozilla CVS on the first try and mostly got things
right.

Patchset format for cvsps
http://www.cobite.com/cvsps/README

AFAIK none of the CVS converters are using the dependency algorithm.
So the proposal on the table is to develop a new converter that uses
the dependency data from CVS to form the change sets and then outputs
this data in a form that all of the backends can consume. Of course
each of the backends is going to have to write some code in order to
consume this new import format.

>
> For sure it's algorithm isn't that strong. cvs2svn is better, IMHO. The
> proposed dependency resolving algorithm will be even better /me thinks.
>
> Regards
>
> Markus
>


-- 
Jon Smirl
jonsmirl@gmail.com
