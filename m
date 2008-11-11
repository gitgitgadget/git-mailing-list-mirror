From: Andreas Ericsson <ae@op5.se>
Subject: Re: Install issues
Date: Tue, 11 Nov 2008 10:17:28 +0100
Message-ID: <49194DA8.2030008@op5.se>
References: <20081110121739.15f77a01@pc09.procura.nl>	<20081110113924.GR24201@genesis.frugalware.org>	<20081110173101.3d76613b@pc09.procura.nl>	<20081110175123.GV24201@genesis.frugalware.org> <20081111085923.00213a89@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Nov 11 10:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzpPQ-0006gX-HT
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 10:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbYKKJRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 04:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYKKJRk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 04:17:40 -0500
Received: from mail.op5.se ([193.201.96.20]:47779 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbYKKJRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 04:17:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9B4BA24B0002;
	Tue, 11 Nov 2008 10:11:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVgli405FnDh; Tue, 11 Nov 2008 10:11:39 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 902B01B80007;
	Tue, 11 Nov 2008 10:11:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081111085923.00213a89@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100632>

H.Merijn Brand wrote:
> On Mon, 10 Nov 2008 18:51:23 +0100, Miklos Vajna
> <vmiklos@frugalware.org> wrote:
> 
>> On Mon, Nov 10, 2008 at 05:31:01PM +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
>>> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
>>> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
>>> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>>>  	./test-sha1.sh
>>>  
>>>  check: common-cmds.h
>>> +	@`sparse </dev/null 2>/dev/null` || (\
>>> +	    echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
>>> +	    echo "Did you mean 'make test' instead?" ;\
>>> +	    exit 1 )
>>>  	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
>> Please read Documentation/SubmittingPatches, your patch lacks a signoff
>> and a commit message.
> 
> You're not making things easier for people that do not use git from a
> git repo, something that happens quite a lot when you build from a
> released tarball.
> 

I think it's assumed that most git developers will clone the git repo so
they can send their patches against the very latest code. Usually, that's
part of "how to submit patches" of all projects.

> git-1.6.0.4 $ git format-patch -M
> fatal: Not a git repository
> Exit 128
> 
> I don't like this at all. How much more work is it for you to add the
> subject and sign-off yourself, instead of requiring that from people
> that like to help?
> 

"Ask not what a bunch of oss devs can do for you, but what you can do
for them. Especially if you want your changes accepted".

The harsh reality is that this is your itch. Noone else cares very
much either way, so if you want your change included, you'll have to
do it the way the project maintainer wants it.

> In the perl development, the only thing we *require* is a diff that
> either uses unified (preferred) or context diff.
> 

Nothing's required here, but since nobody else seems to have problems
with the check/test stuff here, noone else will fix it up for you.

Besides that, I'm sure you require a teensy bit more than that. If I
send you a 14k line patch without a reasoning behind it, you won't
just go ahead and apply it, will you? If I send an algorithm for a new
hash that might actually be proprietary code from an anonymous email
address, wouldn't you want some sort of verification that I'm actually
allowed to send that algorithm to you?

In git, those two steps are formalized into "Sign your patches!" and
"Write a proper commit message!". Since they *are* formalized, we
provide handy tools for doing just that. It's up to you if you want to
use them. Dictating the patch submission (or rather, acceptancy policy)
is not. Patches submitted incorrectly will have one of the following
things happen to them:
1. The patch is forgotten entirely, since nobody cares about it enough
   to make it a "proper" patch (by git standards).
2. The patch author resubmits it in the proper format.
3. Someone else resubmits it in the proper format.
4. Junio accepts it anyway.

4 is the least likely to happen, and will pretty much only occur if
someone finds some really horrible bug that absolutely and obviously
has to go in the git code. Even in those cases, 3 usually happens
before Junio wakes up.

3 is not very likely to happen unless the feature you're suggesting
is of interest to a lot of people.

Ofcourse, *after* the patch has been submitted in the proper format,
it can still get rejected. Submitting it properly is only the first
step towards getting any kind of review on it (basically).

> I did follow the ideal patch flow so far:
> --8<---
> An ideal patch flow
> 
> Here is an ideal patch flow for this project the current maintainer
> suggests to the contributors:
> 
>  (0) You come up with an itch.  You code it up.
> 
>  (1) Send it to the list and cc people who may need to know about
>      the change.
> -->8---
> 
> Code speaks louder than words, so I proposed a patch.
> This might be my last patch. git is not just another project I want to
> loose so much time in.
> 

That would be sad. We're a tad short on perl folks, although I guess
that's not much of an issue since we're rewriting most of it in C
anyways.

If you should decide to relent though, I seriously suggest using the
tools git provides for sending patches. If you do, you'll be able to
able to send (properly formatted) patches very easily indeed.

Rant aside, thanks for the re-send. I'm sure Junio can sed s/Author/From/
on the mail and have git accept it properly in case he accepts it.
Otherwise, I'll resubmit it, faking you as the author.

> --8<---
> Author: H.Merijn Brand <h.m.brand@xs4all.nl>
> Date:   Mon, 10 Nov 2008 17:31:01 +0100
> 
>     Make check needs sparse. If sparse is not available, it might as
>     well be a user error who really wanted make test.
> 
> Signed-off-by: H.Merijn Brand <h.m.brand@xs4all.nl>
> ---
> 
> diff --git a/Makefile.org b/Makefile
> index becd008..718ddf2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>         ./test-sha1.sh
> 
>  check: common-cmds.h
> +       @`sparse </dev/null 2>/dev/null` || (\
> +           echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
> +           echo "Did you mean 'make test' instead?" ;\
> +           exit 1 )
>         for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
> 
>  remove-dashes:
> -->8---
> 


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
