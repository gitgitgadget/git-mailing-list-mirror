From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git and linux kernel source
Date: Mon, 13 Aug 2007 11:38:03 -0400
Message-ID: <20070813153803.GG3122@fieldses.org>
References: <1186701106.3073.71.camel@localhost> <20070809231718.GH12875@fieldses.org> <20070813152714.GF3122@fieldses.org> <46C0799A.3090707@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Perches <joe@perches.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 17:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKc0O-0004yw-O5
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 17:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941602AbXHMPiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 11:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S947230AbXHMPiL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 11:38:11 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44993 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S941943AbXHMPiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 11:38:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IKbzX-0002Sg-Tc; Mon, 13 Aug 2007 11:38:03 -0400
Content-Disposition: inline
In-Reply-To: <46C0799A.3090707@dawes.za.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55768>

On Mon, Aug 13, 2007 at 05:32:42PM +0200, Rogan Dawes wrote:
> J. Bruce Fields wrote:
>> On Thu, Aug 09, 2007 at 07:17:18PM -0400, bfields wrote:
>>> On Thu, Aug 09, 2007 at 04:11:46PM -0700, Joe Perches wrote:
>>>> A few linux kernel source and git questions:
>>>>
>>>> What's the best procedure to handle a tree-wide source tranformation?
>>>> For instance:
>>>>
>>>>   git branch foo2bar
>>>>   egrep -r -w --include=*.[ch] -l "foo" * | \
>>>> 	xargs perl -pi -e 's/\bfoo\b/bar/msg'
>>>>   git commit -a -m "use bar not foo"
>>>
>>>> Is there a way to separate the resultant single patch into multiple
>>>> patches by subdirectory?  Perhaps some git-rev-parse option?
>>> Something like
>>>
>>> 	for each sub/dir:
>>> 		git add sub/dir
>>> 		git commit -m "use bar not foo in sub/dir"
>>>
>>> should do it.  (Of course, in the particular case above the patches you
>>> ended up with probably wouldn't compile individually.)
>> OK, now I feel like I have to ask--you're not seriously considering
>> doing anything like that, are you?
>> --b.
>
> Have you seen LKML recently? Maybe that will answer your question. (A 500+ 
> patch mail bomb . . .)

Yes.  And it looks like preparation for doing the above kind of
splitting-by-maintainer.  Which may not be a sensible thing to do for a
variety of reasons that I assume people know.  But the patch bomb
suggests I shouldn't make that kind of assumption.

--b.
