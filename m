From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Tue, 17 Jul 2007 22:35:45 +0200
Message-ID: <m3wswyojj2.fsf@pc7.dolda2000.com>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com> <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com> <f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com> <f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com> <Pine.LNX.4.64.0707170834040.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 22:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAtmu-0003aT-Jh
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935437AbXGQUgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935363AbXGQUgE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:36:04 -0400
Received: from main.gmane.org ([80.91.229.2]:34976 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935964AbXGQUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 16:36:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAtlz-0004wk-9N
	for git@vger.kernel.org; Tue, 17 Jul 2007 22:35:55 +0200
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 22:35:55 +0200
Received: from fredrik by 1-1-3-7a.rny.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 22:35:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-3-7a.rny.sth.bostream.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:M4CufU9/7wwrF3nYdJ+ouxM2kxM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52799>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 16 Jul 2007, Bradford Smith wrote:
>
>> So, I guess I need to add a GIT_CONFIG_HOME environment variable.  If I 
>> get that done, I'll send a patch to the list including doc updates.
>
> Alternatively, you could actually not ignore my hint at readlink(2) and 
> have a proper fix, instead of playing games with environment variables.

Wouldn't it be nicer to avoid a lot of the complexity in checking
symlinks, environment variables and what not, and just overwrite the
file in place (with open(..., O_TRUNC | O_CREAT))? Does it happen
terribly often that git-config crashes in the middle and leaves the
file broken?

Fredrik Tolf
