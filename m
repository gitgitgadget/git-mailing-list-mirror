From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Wed, 07 Nov 2007 09:52:39 +0100
Message-ID: <47317CD7.5040506@op5.se>
References: <20071106201518.GA6361@ins.uni-bonn.de>	<20071106201809.GD6361@ins.uni-bonn.de>	<20071106202600.GH6361@ins.uni-bonn.de>	<7vtznzf5jb.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0711062317330.4362@racer.site> <7v640ega5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:53:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipgei-0000la-3D
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbXKGIwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbXKGIwp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:52:45 -0500
Received: from mail.op5.se ([193.201.96.20]:48311 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbXKGIwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:52:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 42F6C173064A;
	Wed,  7 Nov 2007 09:52:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BQMPRnkYFB9l; Wed,  7 Nov 2007 09:52:13 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 97BAD17305BB;
	Wed,  7 Nov 2007 09:52:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7v640ega5q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63789>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
>> new file mode 100644
>> index 0000000..622b80b
>> --- /dev/null
>> +++ b/Documentation/CodingStyle
>> @@ -0,0 +1,87 @@
>> +As a popular project, we also have some guidelines to keep to the
>> +code.  For git in general, two rough rules are:
>> +
>> + - Most importantly, we never say "It's in POSIX; we'll happily
>> +   screw your system that does not conform."  We live in the
>> +   real world.
>> +
>> + - However, we often say "Let's stay away from that construct,
>> +   it's not even in POSIX".
>> +
> 
> I am not sure if we want to have CodingStyle document, but the
> above are not CodingStyle issues.
> 
> If we are to write this down, I'd like to have the more
> important third rule, which is:
> 
>  - In spite of the above two rules, we sometimes say "Although
>    this is not in POSIX, it (is so convenient | makes the code
>    much more readable | has other good characteristics) and
>    practically all the platforms we care about support it, so
>    let's use it".  Again, we live in the real world, and it is
>    sometimes a judgement call, decided based more on real world
>    constraints people face than what the paper standard says.
> 
>> +For C programs:
>> +
>> + - Use tabs to increment, and interpret tabs as taking up to 8 spaces
> 
> What's the character for decrement?  DEL? ;-)
> 
>> +   Double negation is often harder to understand than no negation at
>> +   all.
>> +
>> +   Some clever tricks, like using the !! operator with arithmetic
>> +   constructs, can be extremely confusing to others.  Avoid them,
>> +   unless there is a compelling reason to use them.
> 
> I actually think (!!var) idiom is already established in our
> codebase.
> 

Not very widely for arithmetic expressions though. I believe this
alludes to the (!!a + !!b + !!c) idiom used earlier, where it's not
exactly clear *why* a, b and c can be > 1 if != 0 is the only thing
we care about.

>> + - Use the API.  No, really.  We have a strbuf (variable length string),
>> +   several arrays with the ALLOC_GROW() macro, a path_list for sorted
>> +   string lists, a hash map (mapping struct objects) named
>> +   "struct decorate", amongst other things.
> 
>  - When you come up with an API, document it.
> 
>> + - if you are planning a new command, consider writing it in shell or
>> +   perl first, so that changes in semantics can be easily changed and
>> +   discussed.  Many git commands started out like that, and a few are
>> +   still scripts.
> 
> No Python allowed?


Perhaps with this addendum?

- Think very, very hard before introducing a new dependency into git. This
  means you should stay away from scripting languages not already used in
  the git core command set unless your command is clearly separate from it,
  such as an importer to convert random-scm-X repositories to git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
