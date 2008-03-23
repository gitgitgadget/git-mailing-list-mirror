From: Jonathan Watt <jwatt@jwatt.org>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 15:27:45 +0100
Message-ID: <47E668E1.80804@jwatt.org>
References: <47E64F71.3020204@jwatt.org>	 <alpine.LSU.1.00.0803231401340.4353@racer.site>	 <47E658D3.1060104@jwatt.org>	 <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>	 <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdRBY-0003Dq-JE
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758402AbYCWO1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757954AbYCWO1v
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:27:51 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:47923 "EHLO
	spunkymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757912AbYCWO1v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 10:27:51 -0400
Received: from [192.168.1.6] (ip1-182-173-82.adsl2.versatel.nl [82.173.182.1])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id 6BFEC212D2;
	Sun, 23 Mar 2008 07:27:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77907>

Elijah Newren wrote:
> On Sun, Mar 23, 2008 at 7:54 AM, Jonathan Watt <jwatt@jwatt.org> wrote:
>> Elijah Newren wrote:
>>  > On Sun, Mar 23, 2008 at 7:19 AM, Jonathan Watt <jwatt@jwatt.org> wrote:
>>  >>  Hi Dscho. I think you've misread my email. (Or not read it. ;-)) I do not expect
>>  >>  git-push to update the working copy of the repository being pushed to. In fact
>>  >>  my complaint would be more that it *does* appear to modify the working copy
>>  >>  (well, not so much modify the working copy as get confused about which revision
>>  >>  the working copy came from) when the working copy came from HEAD.
>>  >
>>  > Ah, I hadn't thought of it that way before.  I think you are
>>  > suggesting that pushing to the active branch of a repository with an
>>  > associated working copy should cause the HEAD to become detached.  Is
>>  > that right?
>>
>>  To be honest, I'm not sure what you mean by "HEAD to become detached". If you
>>  mean that the git-push should, if necessary, stop associating the working copy
>>  with HEAD if it's going to change HEAD, then absolutely. It wasn't the same
>>  solution as I was thinking of (stop associating the working copy with HEAD and
>>  instead associate it with the sha1 HEAD currently points to), but I guess it's
>>  the same result. :-)
> 
> In git, HEAD always refers to the currently active branch...if there
> is one.  (Also note that each branch tracks its most recent commit.)
> If there is no currently active branch because you checked out a tag
> or some arbitrary commit, then HEAD is said to be detached, and HEAD
> will track the particular commit you checked out.  The end result is
> that HEAD is always the most recent commit to which your working copy
> is relative to.  See also
> http://www.kernel.org/pub/software/scm/git/docs/glossary.html

I see. Thanks.

> So, it sounds like we're both saying that in your case, you'd like the
> HEAD become detached and track the sha1 that it previously pointed to
> before your push rather than continuing to track the updated branch.

Yes, indeed. From my novice perspective it seems like that's absolutely what
should happen, since that's where the working copy came from. Certainly I see no
reason for git-push to leave the working copy/revision relationship in a bad state.

Jonathan
