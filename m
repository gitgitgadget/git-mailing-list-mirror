From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with local conflicts in new files
Date: Tue, 16 May 2006 16:28:52 -0700
Message-ID: <7vu07p35xn.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
	<7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
	<8aa486160605161611p4c9ddbc0v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 01:29:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8yJ-00036n-8m
	for gcvg-git@gmane.org; Wed, 17 May 2006 01:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWEPX24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 19:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWEPX24
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 19:28:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41463 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932076AbWEPX2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 19:28:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516232853.FZMX19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 19:28:53 -0400
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605161611p4c9ddbc0v@mail.gmail.com> (sbejar@gmail.com's
	message of "Wed, 17 May 2006 01:11:29 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20149>

Santi <sbejar@gmail.com> writes:

> 2006/5/17, Junio C Hamano <junkio@cox.net>:
>> Santi <sbejar@gmail.com> writes:
>>
>> >       In the case of:
>> >
>> > - You merge from a branch with new files
>> > - You have these files in the working directory
>> > - You do not have these files in the HEAD.
>>
>> and
>>
>>  - You have not told git that these files matter.
>
> For me it is the other way, all my files matter but git can do
> whatever it wants with the ones it controls.

You really do not mean that.

If you told git a file matters, and have local modifications to
the file in the working tree that you have not run update-index
yet, merge and apply should be careful not to overwrite your
changes that is not ready while doing whatever thing they have
to do.  And they are careful, because you have told git that
they matter, and the way you tell git that they matter is to
have entries for them in the index.
