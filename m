From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Tue, 9 Nov 2010 18:14:32 -0800
Message-ID: <6F2D0BEA-187E-4683-826C-D8582AC16D8F@sb.org>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan> <7vd3qfr7ki.fsf@alter.siamese.dyndns.org> <20101110015327.GB1503@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Yann Dirson <ydirson@free.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 03:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG0Cu-0007ET-Jf
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 03:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab0KJCOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 21:14:36 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56344 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab0KJCOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 21:14:35 -0500
Received: by pwj1 with SMTP id 1so25946pwj.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 18:14:35 -0800 (PST)
Received: by 10.143.4.6 with SMTP id g6mr6931319wfi.374.1289355274863;
        Tue, 09 Nov 2010 18:14:34 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm125916wfh.15.2010.11.09.18.14.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 18:14:34 -0800 (PST)
In-Reply-To: <20101110015327.GB1503@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161122>

On Nov 9, 2010, at 5:53 PM, Jonathan Nieder wrote:

> Junio C Hamano wrote:
>> Yann Dirson <ydirson@free.fr> writes:
> 
>>> #  e, edit = use commit (if specified) but pause to amend/examine/test
> [...]
>>                    would it be crystal clear that, if he changed the insn
>> sheet to
>> 
>>    pick one
>>    edit
>>    pick three
>>    ...
>> 
>> then he will _lose_ the change made by foo, or will the user come back
>> here and complain that a precious change "two" is lost and it is git's
>> fault?
> 
> If we explain it clearly then I think yes, the end user would not
> be confused.
> 
> The above description (that starts with "e, edit") looks more like a
> reminder than a full explanation.  Can we rely on the perplexed
> operator to read the text after the command list?
> 
> If so, some trailing explanation[1] might help.
> 
> # Commands:
> #  p, pick = use commit
> #  r, reword = use commit, but edit the commit message
> #  e, edit = use commit (if specified), but stop to amend/examine/test
> #  s, squash = use commit, but meld into previous commit
> #  f, fixup = like "squash", but discard this commit's log message
> #  x, exec = run command using shell, and stop if it fails
> #
> # The argument to edit is optional; if left out or equal to "-",
> # it means to stop to examine or amend the previous commit.
> #
> # If you remove a line here, THAT COMMIT WILL BE LOST.
> # However, if you remove everything, the rebase will be aborted.
> # Use the noop command if you really want to remove all commits.

I like it. Especially because if we support "-" in place of a sha1, then
we can treat the rest of the line like a comment and display it when
stopped, as the old "shell" version did.

-Kevin Ballard
