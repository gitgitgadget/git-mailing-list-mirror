From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 14:49:46 -0500
Message-ID: <slrnevtqaq.1df.jgoerzen@katherina.lan.complete.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 21:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOBq-0006cV-32
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXCSUI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbXCSUI4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:08:56 -0400
Received: from main.gmane.org ([80.91.229.2]:57204 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbXCSUIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:08:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HTO93-0002yS-8x
	for git@vger.kernel.org; Mon, 19 Mar 2007 21:07:53 +0100
Received: from 63.245.179.205 ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 21:07:53 +0100
Received: from jgoerzen by 63.245.179.205 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 21:07:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 63.245.179.205
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42663>

On 2007-03-19, Steven Grimm <koreth@midwinter.com> wrote:
> John Goerzen wrote:
>> 2) For me, a rename is a logical change to the source tree that I want
>>    to be recorded with absolute certainty, not guessed about later.
>>    Sometimes I may make API changes and it is useful to see how module
>>    names changed, with complete precision, later.  I do not want to be
>>    victim to an incorrect guess, which could be possible.
>>   
>
> If you commit your renames separately from your content changes, it'll 
> be unambiguous and you won't have to worry about it. That's what I 
> usually do when this is a concern and it has yet to break for me.

As I have been testing Mercurial and its addremove feature (which does
basically what Git is doing), I encountered some situations where
this broke, sometimes spectacularly.  This generally happened when there
were identical files in the source tree, or when there were identical
resulting files, or 0-byte files (the extreme pathological case, of
course).

Again, sometimes filenames have significance.  The presence or absence
of 0-byte files can impact what make does, for instance.  Not that I
advocate for this behavior, but just pointing out that it exists.

I understand what Linus is saying about applying patches from others and
agree that what git is doing is nice in this case.

But if most of my work is hacking directly on the code, I am going to
know better than the VCS what is being renamed, and would like to record
that.  Sometimes the filenames are part of the code.

I want the option.

-- John
