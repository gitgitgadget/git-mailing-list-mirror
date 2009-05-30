From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git Confusion
Date: Sat, 30 May 2009 00:41:35 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh2105v.460.sitaramc@sitaramc.homelinux.net>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
 <20090529125853.GB11785@sigill.intra.peff.net>
 <m3d49sauru.fsf@localhost.localdomain>
 <20090529135242.GA30926@coredump.intra.peff.net>
 <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
 <20090529203854.GA14326@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 02:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MACfY-0001hh-3T
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 02:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZE3Als (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 20:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbZE3Alr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 20:41:47 -0400
Received: from main.gmane.org ([80.91.229.2]:42260 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbZE3Alq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 20:41:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MACdu-0005mJ-Rb
	for git@vger.kernel.org; Sat, 30 May 2009 00:41:47 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 May 2009 00:41:46 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 May 2009 00:41:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120327>

On 2009-05-29 20:38:54, Jeff King <peff@peff.net> wrote:
> On Fri, May 29, 2009 at 01:24:59PM -0700, Paul Tarjan wrote:
>
>> The reason I need http is slightly convoluted. The remote machine is
>> shared hosting with 1 ssh login that I don't want to give to my
>> partner AND I don't have root on that box.

[snip]

> You can let him login via ssh key and restrict the actions of that key
> just to running git-upload-pack (which is what "git clone" and "git
> fetch" will invoke to clone or fetch commits). Something like:
>
>   command="git-upload-pack /path/to/repo" ssh-rsa ...
>
> in your .ssh/authorized_keys file. Not that he still won't be able to
> actually push (which is maybe what you want).
>
> For a more featureful solution (with permissions for pushing and pulling
> multiple repos), I think gitosis will do what you want (but I have never
> used it personally).

gitosis is indeed quite featureful.  I use it at work to
admin about 11 projects with between 1-6 devs and it works
very well.  All done with ssh pubkey and the "command="
feature of .ssh/authorized_keys that Jeff mentioned above,
with a bit of python to read a conf file and decide who is
allowed to read/write what repository etc.
