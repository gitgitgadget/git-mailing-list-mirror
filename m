From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 06 Sep 2007 11:52:33 +0200
Message-ID: <85zm00dsta.fsf@lola.goethe.zz>
References: <vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<20070906045942.GR18160@spearce.org> <46DFC490.3060200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITE2k-00022p-RX
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbXIFJws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757127AbXIFJws
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:52:48 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:51768 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757122AbXIFJwr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 05:52:47 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id EFBB72D2A1E;
	Thu,  6 Sep 2007 11:52:45 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id E046C2D3B2B;
	Thu,  6 Sep 2007 11:52:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 9A20235E716;
	Thu,  6 Sep 2007 11:52:37 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5C3B71CAD71B; Thu,  6 Sep 2007 11:52:34 +0200 (CEST)
In-Reply-To: <46DFC490.3060200@op5.se> (Andreas Ericsson's message of "Thu\, 06 Sep 2007 11\:12\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57853>

Andreas Ericsson <ae@op5.se> writes:

> Shawn O. Pearce wrote:
>> Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
>>> When I first looked at Git source code two things struck me as odd:
>>> 1. Pure C as opposed to C++. No idea why. Please don't talk about
>>> portability, it's BS.
>>
>> It is also a relatively simple language that
>> a large number of open source programmers know.  This makes it easy
>> for them to get involved in the project.
>
>
> This is important. Git contains code from more than 300 people. I'm
> guessing you could cut that number by 2/3 if it had been written in
> C++.

C++ is a language without design discipline.  Its set of features and
syntactic elements is incontingent (for example, its templates started
as a ripoff of Ada generics which would have been ok except for the
completely braindead idea of taking the Ada angle bracket restriction
syntax along with it), and it is the task of each programmer to choose
a sane and manageable subset and style, and implement using that.  As
a consequence, every C++ programmer writes his own personal dialect of
C++, and we have about 20 different incompatible implementations of
multidimensional numeric arrays, making a complete mockery of the
"code reuse" mantra: C++ _projects_ can't actually usefully achieve
"multiple inheritance" on a design/meta level: once you start with one
non-trivial design, fitting other separately evolved components with a
different style causes retrofitting nightmares.

So going to C++ means cutting down the amount of people who find
themselves comfortable with the actual design and layout down to maybe
10% of those who would actually feel ok with the actual _algorithms_
employed.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
