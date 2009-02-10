From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 12:31:57 +0100
Message-ID: <4ac8254d0902100331h4f74df6am6cd514e6ba2c8d6a@mail.gmail.com>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
	 <20090210110330.GB12089@coredump.intra.peff.net>
	 <49916524.4000400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqrw-00019P-T5
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbZBJLcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZBJLcI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:32:08 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38529 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbZBJLcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:32:07 -0500
Received: by bwz5 with SMTP id 5so2528975bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KUyjytP22+ctXLYPGOOttRbJNfPzUwobR9qvVPH/OgY=;
        b=QQaGVOatmOmp3xOS4hUhaJnv+mGgbBDnslSo/niIq6L68MK8Q1amwBnx1+Q8U851j7
         H4lj+JDmfBwVankKp6WNAw1/gj5+GtkafrcewnkVeksWIFibKj7Ze917NWc1JbNQi3YT
         9BaawJneOemt/ntKzllcI3kD1lbo4Mld0vC2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MpmajEXoPiOpoIAV8qCTZ45+/SEe37v3CZATKYa4zR8ZRgnvcTpFqkCh4oF4JmBKam
         kbqn1zUq3qvMSPLcJfOdQhTYhIxtzYpMLzCv+aXkBJtd5aLC9N8V2vuLBacJkBpT8pny
         a6xwGkkR7Dxopi5s/u9jVajk2NJLn6DlttfVk=
Received: by 10.223.109.148 with SMTP id j20mr921227fap.43.1234265517506; Tue, 
	10 Feb 2009 03:31:57 -0800 (PST)
In-Reply-To: <49916524.4000400@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109210>

On Tue, Feb 10, 2009 at 12:29 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jeff King venit, vidit, dixit 10.02.2009 12:03:
>> On Tue, Feb 10, 2009 at 01:51:07AM +0100, Tuncer Ayaz wrote:
> ...
>>   3. What advantage does this have over just doing:
>>
>>        (git diff --name-status;
>>         git diff --cached --name-status) | sort -k2
>
> That is fine, except that it can't list untracked files.
>
>> What options are available? It looks like this is intimately tied with
>> "commit", which I think is one of the _shortcomings_ of the current
>> status. It means the command line options are non-intuitive for what
>> people generally want to say: "what is changed, possibly limiting to
>> some path".
>
> Right now, "git status" is basically "git commit --dry-run", which may
> or may not be good, but certainly is not what people coming from other
> vcs expect. I would suggest having "git commit -n" replace "git status"
> if I hadn't done so already or if I dared to (I can't remember ;) ).
>
> The softer approach was naming "shortstatus" what those people would
> expect for "status".
>
> The "git diff" based solution does almost everything, but back then it
> wasn't clear how to get at the untracked and ignored files. In fact,
> that would have the benefit that output from "git diff --name-status
> commitA commitB" is guaranteed to stay consistent with "git diff
> --name-status HEAD WORKTREE", "git diff --name-status INDEX WORKTREE"
> and the three-way diff between HEAD, INDEX and WORKTREE which
> shortstatus really is (WORKTREE meaning full wt with untrcaked/ignored
> files).
>
> "git ls-files" may do but has a different set of mode characters. I
> think that sums up what preceeded Junio's patch from October.

For reference:
http://markmail.org/message/tqvshvcj2ybgj6ea
