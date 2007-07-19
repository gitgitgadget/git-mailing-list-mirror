From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add git-sh-setup::set_editor()
Date: Thu, 19 Jul 2007 21:26:56 +0200
Message-ID: <86tzs0yz27.fsf@lola.quinscape.zz>
References: <Pine.LNX.4.64.0707191053230.14781@racer.site> <11848694482569-git-send-email-aroben@apple.com> <Pine.LNX.4.64.0707191944560.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 21:27:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbel-0007B6-BV
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765085AbXGST1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbXGST1M
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:27:12 -0400
Received: from main.gmane.org ([80.91.229.2]:55829 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765085AbXGST1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:27:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBbeT-0006ho-37
	for git@vger.kernel.org; Thu, 19 Jul 2007 21:27:05 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 21:27:05 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 21:27:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:j1ZrKoQQqbuIGwuJpD0CUx9ymz4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53023>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 19 Jul 2007, Adam Roben wrote:
>
>> This function can be used to set the GIT_EDITOR variable to the user's
>> preferred editor.
>
> Much nicer, thank you.
>
> However,
>
>> -	commit_editor=$(git config core.editor || echo ${VISUAL:-$EDITOR})
>> -	case "$commit_editor,$TERM" in
>> +	case "$GIT_EDITOR,$TERM" in
>>  	,dumb)
>
> This can no longer happen, since ...
>
>> +set_editor() {
>> +    GIT_EDITOR=$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})
>> +    export GIT_EDITOR
>> +}

Strictly speaking it can happen when git has an empty string for
core.editor configured.  Not that the behavior chosen in this case
would make any sense, but just for the record...

-- 
David Kastrup
