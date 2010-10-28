From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in git-status
Date: Fri, 29 Oct 2010 00:47:23 +0200
Message-ID: <vpqfwvqdjes.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
	<20101028183513.GC14212@burratino>
	<7vaaly9eji.fsf@alter.siamese.dyndns.org>
	<20101028220956.GC16125@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:47:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBbFz-00013Q-CT
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459Ab0J1Wre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:47:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48303 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab0J1Wrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:47:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9SMWcgI032038
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 29 Oct 2010 00:32:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBbFk-00066W-3Q; Fri, 29 Oct 2010 00:47:24 +0200
In-Reply-To: <20101028220956.GC16125@burratino> (Jonathan Nieder's message of "Thu\, 28 Oct 2010 17\:09\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 Oct 2010 00:32:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SMWcgI032038
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288909961.9793@FprQfogdGfQc1bi+IWPE/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160246>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>>  # Changes to be committed:
>>>  #   (use "git reset HEAD <file>..." to unstage)
>>>  #
>>>  #       new file:   foo.c
>>>  #
>>>  # Changes not staged for commit:
> [...]
>> Hmm, perhaps we'd want to restate the first one as well to read
>> 
>>     Changes staged for commit:
>>       (use "git reset HEAD <path>..." to unstage)
>> 
>> for consistency as well?
>
> My first impression is no.  Since the main purpose of this text is to
> be shown by "git commit", it might even make sense to say:
>
> # Changes to be committed:
> #   (use "git reset -- <path>..." to unstage)
> #
> #	new file:    foo.c
> #
> # Changes not to be committed:
> #   (use "git add <path>..." to update what will be committed)
> #   (use "git checkout -- <path>..." to discard changes in working
> #   directory)
> #
> #	typechange:  bar.c

Actually, my formulation also has a subtle advantage: it somehow
teaches the meaning of "staged". By reading "Changes not staged for
commit" close to "Changes to be commited", it makes it rather clear
what "staged for commit" means.

Perhaps changing the hint from "git add" to "git stage" right below
would make that even clearer.

So, I tent to (very slightly) prefer my version.

> It would be nice if the "staged changes" section gave a hint that there
> were unstaged changes present.  Maybe something like the
> "unsaved file" indicator used by some text editors:
>
> 	new file:    foo.c*

I'd argue against the syntax, since it kills cut-and-paste, but a
visual indicator could be nice, yes.

>> I've been wondering ever since this thread started if we can phrase it
>> better to make it even less confusing.  E.g.
>> 
>>     Files with changes to be committed:
>>         new file: foo.c
>>     Files with changes that won't be committed:
>>         modified: foo.c
>> 
>> might help reduce the confusion.
>
> I fear that it can be misparsed as (Files with changes) to be committed.
> More importantly, I think Matthieu was right earlier: it is not the
> files but the changes that matter.

I second that. Furthermore, keeping it short increase the changes that
user will actually read the message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
