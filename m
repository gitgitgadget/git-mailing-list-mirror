From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 8 Apr 2013 14:58:24 -0400
Message-ID: <20130408185823.GL27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin>
 <20130408000658.GG27178@pug.qqx.org>
 <7vhajh15w0.fsf@alter.siamese.dyndns.org>
 <20130408145749.GJ27178@pug.qqx.org>
 <7vip3xyr8c.fsf@alter.siamese.dyndns.org>
 <20130408161745.GK27178@pug.qqx.org>
 <7vli8sykf0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHGw-0001gw-LK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935349Ab3DHS60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:58:26 -0400
Received: from pug.qqx.org ([50.116.43.67]:35668 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935294Ab3DHS6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:58:25 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 33DFA57DE5; Mon,  8 Apr 2013 14:58:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vli8sykf0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220492>

At 10:57 -0700 08 Apr 2013, Junio C Hamano <gitster@pobox.com> wrote:
>In general I am in favor of resolving a gitfile given to --reference
>when clone interprets it, and have it use the location of the real
>underlying object store when it grabs objects not in there from the
>origin and store the location of the real underlying object store in
>the objects/info/alternates of the newly created repository.  But
>that is not limited to the gitfile used at the root level of a
>submodule checkout.

Yes, I agree that it's not limited to submodules.  The commit message 
for the second part of this series only mentioned submodules because I 
suspect that is by far the most common use of gitfiles.  The commit 
message for the first didn't even mention submodules at all, they were 
only brought up because I was asked about what lead to me having an 
issue.

>Blindly using .git at the root level of submodule checkout as a
>reference is what I was recommending against as a general
>precaution.

I agree with that.  But I still don't think it's relevant to this patch 
series.

>You may be dealing with an old-style submodule checkout.

No, the submodule in question was done with the new style.  If it were 
an old-style checkout my attempt to clone using that as a reference 
would have worked without issue (at least at clone time).
