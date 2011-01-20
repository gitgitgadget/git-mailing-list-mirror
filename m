From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] rebase -i: reword in-editor documentation of "exec"
Date: Thu, 20 Jan 2011 14:09:49 -0600
Message-ID: <20110120200949.GB11702@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
 <20110116020132.GB28137@burratino>
 <vpq39otrvmk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 20 21:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0pi-0007PQ-VI
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 21:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1ATUKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 15:10:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62775 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab1ATUKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 15:10:08 -0500
Received: by wwa36 with SMTP id 36so1063425wwa.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kFJiCRiInm4JtIT+lZif96eWjyS8sducZs27wfvX2o8=;
        b=HxK+YvMNqyXt95LKJK+AJbwHCdQGPDFV1u2AzVGQUUDT6nH2eYo9xH7X4iOKrKi6WD
         8F8ufObHOeA4dUcexY3amKE8dhHBUIwJjrQRwDkN1nX4TOKDd1EpPWfLrXJsFIvgFysc
         yc0b9xk9x9Wg4XBldh0/jXR0LaueSPLnVi7jY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PpkINLS+qYsZowU4BGtB6lEhSEoUQPom799fGeOGzoqOzw9riT+6FZn3w6WYyGxzPO
         51TZb9pF7Ty85qmS00ZDtLjOI1ARn8TJQWwNBHmBxVCXoABWgIMR3hQ3GKIUM6S7M3iU
         y30nBveAcJviCK2UkjBc7BSrwEQH1Fw+ceZN8=
Received: by 10.227.128.21 with SMTP id i21mr2557388wbs.219.1295554206891;
        Thu, 20 Jan 2011 12:10:06 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id f3sm513136wbh.13.2011.01.20.12.10.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 12:10:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpq39otrvmk.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165330>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
>> +#  x, exec = run command using shell, and stop if it fails
>
> I don't think this is a good change to remove the <cmd> part. All
> other commands are used with
>
> <command> <sha1> <subject line>
>
> and I don't think the user would be able to guess that exec is
> different without a hint.
> 
> If the problem is the wording of the sentence that may imply that
> <cmd> should be the shell itself, then why not

Yes, sorry, I combined two problems into a single patch.  That was a
mistake.  The current cheat sheet says:

# Rebase 3f14246..a1d7e01 onto 3f14246
#
# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#

This does not make it clear that the format of each line is

	<instruction> <commit id> <explanatory text that will be printed>

but the reader will probably infer that from the automatically
generated pick examples above.

What about the "exec" instruction?  By analogy, I might imagine that
the format of that line is

	exec <command> <explanatory text that will be printed>

So the "<cmd>" does not address that question for me.  It does succeed
in clarifying that "a shell command" does not mean an arbitrary shell
command but a user-specified one.

Meanwhile, it makes the cheat sheet harder to visually scan as a table

 i, instruction = action performed by instruction

Maybe "exec" should be explained outside this table?  For example,
maybe something along the lines of

	 x, exec = run an arbitrary command (see below)

	A line of the form "exec <command>" will run <command> using your
	shell and stop for investigation or amending if the command fails.

	If you remove a line here, THAT COMMIT WILL BE LOST.
	However, if you remove everything, the rebase will be aborted.
