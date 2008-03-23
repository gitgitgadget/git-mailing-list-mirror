From: Jonathan Watt <jwatt@jwatt.org>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 16:25:17 +0100
Message-ID: <47E6765D.2020103@jwatt.org>
References: <47E64F71.3020204@jwatt.org>  <alpine.LSU.1.00.0803231401340.4353@racer.site>  <47E658D3.1060104@jwatt.org>  <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>  <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com> <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 16:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdS5E-0003N6-AE
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 16:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbYCWPZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYCWPZX
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 11:25:23 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:40902
	"EHLO spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750917AbYCWPZX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 11:25:23 -0400
Received: from [192.168.1.6] (ip1-182-173-82.adsl2.versatel.nl [82.173.182.1])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 2CE987FA8;
	Sun, 23 Mar 2008 08:25:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <alpine.LSU.1.00.0803231555380.4353@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77916>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 23 Mar 2008, Jonathan Watt wrote:
> 
>> Would detaching HEAD really be a problem in git workflows?
> 
> If recovering is painful?  Yes.
> 
> If it is not what you want?  Yes.

If you push to the current branch of a non-bare repository, then as things
stand, whatever was pushed to the current branch will be reverted on the next
commit(!). Push hasn't just pushed changesets to the repository, it's
essentially screwed up the working copy. I personally can't see how this
behavior is useful or in any way "right", or why you'd want it that way. On the
other hand detaching HEAD makes sure that all push has done is push changesets,
and you've essentially created a branch. To me that seems like the only correct
thing to do. (It also happens to be the way Mercurial behaves.)

I'd venture that if you're pushing into a non-bare repository then you know the
state of the working copy, and you know if you're going to cause pain. (And it's
probably local.) If it's a shared repository, why is there a working copy? If
it's someone else's repository, the two of you probably know what you're doing.
These two seem like relative edge cases though, and even then, detaching HEAD
seems like the right think to me.

> Just to give you a small clue what other people would like: 
> http://utsl.gen.nz/git/post-update
> 
> BTW that was in the link I sent you earlier.

As I said, I don't want to update the files in the working copy. Seems like a
different issue to me.

Jonathan
