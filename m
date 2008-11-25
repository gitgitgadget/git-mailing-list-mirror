From: david@lang.hm
Subject: Re: git fast-export | git fast-import doesn't work
Date: Tue, 25 Nov 2008 15:53:16 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0811251548280.20120@asgard.lang.hm>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>  <492C367D.3030209@drmicha.warpmail.net>  <20081125204108.GF4746@genesis.frugalware.org> <85b5c3130811251539n6cb175b4p185d37385bf43d1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L57iB-0005cO-NZ
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 00:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbYKYXvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYKYXvk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 18:51:40 -0500
Received: from mail.lang.hm ([64.81.33.126]:51561 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbYKYXvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 18:51:39 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mAPNpACq029115;
	Tue, 25 Nov 2008 15:51:10 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <85b5c3130811251539n6cb175b4p185d37385bf43d1e@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101696>

On Wed, 26 Nov 2008, Ondrej Certik wrote:

> On Tue, Nov 25, 2008 at 9:41 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> On Tue, Nov 25, 2008 at 06:31:41PM +0100, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>>> I don't know, I just noticed that turning on rename and copy detection
>>> makes git-fast-import crash, which shouldn't happen either. Something's
>>> not right here. CC'ing the authors of im- and export.
>>
>> Could you please write a testcase that reproduces your problem?
>>
>>> Why export|import directly to git?
>>
>> I guess he did not know about filter-branch. :)
>
> I know about filter-branch (but I am not sure it can do what I want).
> I made a mistake of not explaining what I want, instead I suggested (a
> possibly wrong) solution. I want to export the whole git repository as
> a set of human readable patches, that can be assembled back into a git
> repository (with the same hashes as the original one)

the same hashes on the file is easy, the same hashes on the commits is 
extremely hard. which is it that you are looking for.

that being said, the test of being able to do a export|import is a good 
one to test that the export format and import format actually match.

David Lang

> if needed. The
> reason I want that is that if we later decide to switch to another
> VCS, we have all the information to reproduce the repository. Another
> reason is to be sure that we know all the sources that are needed to
> construct the repository, e.g. that there are no binary blobs
> (possibly containing malicious code). Another reason I want that is to
> be able to rewrite the history, in particular, we have one Mercurial
> repository with some old history and another Mercurial history with a
> newer history and I just want to concatenate them together into one
> git repository.
>
> In each case I know several workarounds, but if there is a way to just
> convert the whole git repository into a set of patches and (and be
> able to convert everything back including the same hashes), then it'd
> be awesome.
>
> See also this thread why people want this (and I assumed git can do
> this from this thread):
>
> http://groups.google.com/group/sage-devel/browse_thread/thread/7b116d902ee20d9c/
>
> Thanks,
> Ondrej
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
