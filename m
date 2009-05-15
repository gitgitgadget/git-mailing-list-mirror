From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] added --batch option to mktree
Date: Fri, 15 May 2009 01:31:38 -0700
Message-ID: <7vskj6vkb9.fsf@alter.siamese.dyndns.org>
References: <loom.20090514T050424-673@post.gmane.org>
	<loom.20090514T051004-665@post.gmane.org>
	<7vhbzoxl5k.fsf@alter.siamese.dyndns.org>
	<a644352c0905140217h382a4d18h988b229c12577de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Micich <josh.micich@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 10:31:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4spY-00056G-RG
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 10:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013AbZEOIbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 04:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757794AbZEOIbj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 04:31:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34907 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256AbZEOIbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 04:31:37 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515083138.MVHG17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Fri, 15 May 2009 04:31:38 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rkXe1b0034aMwMQ04kXekF; Fri, 15 May 2009 04:31:38 -0400
X-Authority-Analysis: v=1.0 c=1 a=ytj-zW1PikoA:10 a=bIIiVhviu7cA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=CW6wbwl44tLM-sDxO4gA:9
 a=dqMLnsg1t3r4-mwiy1cA:7 a=DzFmOAvRy4OFfPFxovnnwQKk1bEA:4 a=MSl-tDqOz04A:10
 a=qIVjreYYsbEA:10 a=qgmngS_lQXfOtwyW:21 a=_7WwLTwtcPeLtIRd:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119252>

Josh Micich <josh.micich@gmail.com> writes:

> On Wed, May 13, 2009 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> This option enables creation of many tree objects with a single process
>>
>>... which is desirable in what way?  how does this justify the cost of
>>maintenance?  what is it used for?
>
> I have been writing a few of my own utilities on top of basic git commands
> and got mild performance gains from using the existing '--batch' option with
> "git cat-file" instead of executing new "git cat-file -p <sha>" processes
> for each object I wish to read.  Later I was writing a utility for mirroring
> another SCM (creates many trees), and I faced a similar performance issue
> with "git mktree".  After adding the '--batch' option, I experienced about a
> 30% speed increase.

"An operation that some people may want to do but the current toolset is
not very good at is _this_, and this patch rectifies that.  _Here_ is a
number to back up that claim." is a perfect way to justify your new
feature.  Why not have that in the proposed commit log message ;-)?

>>> +             if (is_batch_mode && got_eof && used < 1) {
>>> +                     // allow input to finish with a new-line (or not)
>>
>>Style: have an explicit ";" for an empty statement.
>>
>>But more importantly, what does this comment mean?  Why do you want to be
>>loose in input format validation?
>
> I agree with your implied suggestion that tight input validation is better.
> I was actually trying to keep consistent with the way I believe mktree
> works today.  The final \n is optional as far as I can tell.

Ok.
