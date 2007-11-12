From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:37:50 +0100
Organization: At home
Message-ID: <fh9vgu$u75$1@ger.gmane.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <86pryf7815.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcJA-0005g6-Be
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbXKLQi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbXKLQi3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:38:29 -0500
Received: from main.gmane.org ([80.91.229.2]:51326 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbXKLQi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:38:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrcIb-0003jE-9r
	for git@vger.kernel.org; Mon, 12 Nov 2007 16:38:09 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:38:09 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:38:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64656>

David Kastrup wrote:

> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
> 
>> A bare repository is the way to publish your changes to the public.
>> git-daemon  and http-clones use a bare repository that only contains
>> adminsitrative files.
[...]
> 
> Fine.  So why don't the following commands complain?  Apart from
> git-reset without arguments (which could probably get along without a
> working dir), they are supposed to employ a working directory.
> 
>> On Mon, Nov 12, 2007 at 02:11:58PM +0100, David Kastrup wrote:
>>> 
>>> I have a repository declared as bare.  Some commands treat it as such,
>>> other's don't.  For example, I get
>>> 
>>> git-diff [no complaint]
>>> git-reset [no complaint]
>>> git-reset --hard
>>> HEAD is now at db862c1... installmanager.sh: setze GIT_WORK_TREE

git-diff can compare tree and tree, or tree and index; only for
comparing tree and files of index and files it needs working dir.

git-reset resets only refs and index. git-reset --hard resets also
files, so it needs working directory. Perhaps it should fail completely
and not only after doing mixed (non-hard) reset if we are in bare
repository.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
