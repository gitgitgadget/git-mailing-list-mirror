From: Max Horn <postbox@quendi.de>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sat, 5 Jan 2013 09:27:38 +0100
Message-ID: <1E7F9F86-F040-42E4-98C4-152B8CCE47CE@quendi.de>
References: <20121222173649.04C5B44119@snark.thyrsus.com> <50E5A5CF.2070009@alum.mit.edu> <20130103205301.GD26201@thyrsus.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Yann Dirson <ydirson@free.fr>, Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Jan 05 09:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrPAg-0004A7-65
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 09:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3AEI1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 03:27:51 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:55805 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754753Ab3AEI1u convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 03:27:50 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TrP6R-0002cu-LE; Sat, 05 Jan 2013 09:27:39 +0100
In-Reply-To: <20130103205301.GD26201@thyrsus.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1357374469;92e719ed;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212682>


On 03.01.2013, at 21:53, Eric S. Raymond wrote:

> Michael Haggerty <mhagger@alum.mit.edu>:
>> There are two good reasons that the output is written to two separate files:
> 
> Those are good reasons to write to a pair of tempfiles, and I was able
> to deduce in advance most of what your explanation would be from the
> bare fact that you did it that way.
> 
> They are *not* good reasons for having an interface that exposes this
> implementation detail to the caller - that choice I consider a failure
> of interface-design judgment.  But I know how to fix this in a simple and
> backward-compatible way, and will do so when I have time to write you
> a patch.  Next week or the week after, most likely.
> 
> Also, the cvs2git manual page is still rather half-baked and careless,
> with several fossil references to cvs2svn that shouldn't be there and
> obviously incomplete feature coverage. Fixing these bugs is also on my
> to-do list for sometime this month.
> 
> I'd be willing to put in this work anyway, but it still in the back of
> my mind that if cvs2git wins the test-suite competition I might
> officially end-of-life both cvsps and parsecvs.  One of the features
> of the new git-cvsimport is direct support for using cvs2git as a
> conversion engine.
> 
>> A potentially bigger problem is that if you want to handle such
>> blob/dump output, you have to deal with git-fast-import format's "blob"
>> command as opposed to only handling inline blobs.
> 
> Not a problem.  All of the main potential consumers for this output,
> including reposurgeon, handle the blob command just fine.

Hm, you snipped this part of Michael's mail:

>> However, if that is a
>> problem, it is possible to configure cvs2git to write the blobs inline
>> with the rest of the dumpfile (this mode is supported because "hg
>> fast-import" doesn't support detached blobs).

I would call "hg fast-import" a main potential customer, given that there "cvs2hg" is another part of the cvs2svn suite. So I can't quite see how you can come to your conclusion above...



Cheers,
Max