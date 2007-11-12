From: David Kastrup <dak@gnu.org>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:54:29 +0100
Message-ID: <86abpj76be.fsf@lola.quinscape.zz>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<86pryf7815.fsf@lola.quinscape.zz> <fh9vgu$u75$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcYw-0003VR-9O
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbXKLQyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbXKLQyq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:54:46 -0500
Received: from main.gmane.org ([80.91.229.2]:46515 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbXKLQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:54:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrcYW-00076j-Fu
	for git@vger.kernel.org; Mon, 12 Nov 2007 16:54:36 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:54:36 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:54:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <fh9vgu$u75$1@ger.gmane.org> (Jakub Narebski's message of "Mon\, 12 Nov 2007 17\:37\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:sg2462Yj5GhlqXxLlVk3IYmz3OI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64664>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup wrote:
>
>> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
>> 
>>> A bare repository is the way to publish your changes to the public.
>>> git-daemon  and http-clones use a bare repository that only contains
>>> adminsitrative files.
> [...]
>> 
>> Fine.  So why don't the following commands complain?  Apart from
>> git-reset without arguments (which could probably get along without a
>> working dir), they are supposed to employ a working directory.
>> 
>>> On Mon, Nov 12, 2007 at 02:11:58PM +0100, David Kastrup wrote:
>>>> 
>>>> I have a repository declared as bare.  Some commands treat it as such,
>>>> other's don't.  For example, I get
>>>> 
>>>> git-diff [no complaint]
>>>> git-reset [no complaint]
>>>> git-reset --hard
>>>> HEAD is now at db862c1... installmanager.sh: setze GIT_WORK_TREE
>
> git-diff can compare tree and tree, or tree and index; only for
> comparing tree and files of index and files it needs working dir.

Well, if called without arguments (as above), it compares tree and
index.  So it should complain about not having a tree.  It doesn't.

> git-reset resets only refs and index. git-reset --hard resets also
> files, so it needs working directory. Perhaps it should fail
> completely and not only after doing mixed (non-hard) reset if we are
> in bare repository.

Please reread the above: it does not fail at all.  Neither before nor
after the mixed reset.

-- 
David Kastrup
