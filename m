From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Fri, 01 Feb 2008 15:26:17 -0800
Message-ID: <7vejbw8die.fsf@gitster.siamese.dyndns.org>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL5Hf-0000hs-0Y
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760863AbYBAX00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760338AbYBAX00
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:26:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbYBAX0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 18:26:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B89B52303;
	Fri,  1 Feb 2008 18:26:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3582302;
	Fri,  1 Feb 2008 18:26:20 -0500 (EST)
In-Reply-To: <k5lo716v.fsf@blue.sea.net> (Jari Aalto's message of "Sat, 02 Feb
	2008 00:37:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72191>

Jari Aalto <jari.aalto@cante.net> writes:

> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m33asc94xn.fsf@localhost.localdomain
>> Jari Aalto <jari.aalto@cante.net> writes:
>>
>>> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
>>> * Message-Id: m37iho9b70.fsf@localhost.localdomain
>>> >
>>> >
>>> > 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
>>> > 'git-stash' [save [<message>...]]
>>> >
>>> > Angle brackets if I understand correctly are meant to denote part
>>> > which you have to enter, the user supplied info (the reast ou have to
>>> > enter literally).
>>> 
>>> Nowhere I have seen "(" parenheses to mean "required". 
>>
>> The "(" parentheses does not mean "required". They do mean "group",
>> just like for regular expressions. So "A (B | C)" means "A B" or
>> "A C".
>
> In regexp language yes, but in describing the command syntaxes, I do not
> have come accross this. Would you have descriptive examples?
>
>>> The angle brackets are commonly used to tell that the part is to be
>>> required:
>>> 
>>>     command <option> <file ...>
>> No, the "<" angle brackets are meant to denote: substitute your own
>> (user) input, and not use as literal value. So "command <option>"
>> mean select one of options ant put it in place of "<option>"
>
> The angles primarily denote "required", and secondarily that you put
> there there the asked input.
>
>>       command (subcmd1 | subcmd2) <file ...>
>
> Tat is highly uncommon. In angle bracket notation this is unabiguous:
>
>         command <parameter1|parameter2> <file ...>
>                 A                       B

Actually, I've never seen any less-than-greater-than used to
group alternates command description of traditional manual
pages.  So I'd say both may be unusual, but yours is a lot more
unusual.

For example, GNU 'tar' uses | for alternates, but it does not
mark grouping:

  SYNOPSIS
    tar  [ - ] A --catenate --concatenate | c --create | d --diff --compare
    | --delete | r --append | t --list | u --update | x --extract  --get  [
    options ] pathname [ pathname ... ]

which is horribly confusing to read.

GNU 'cpio' makes it somewhat easier to read by listing
subcommands separately:

  SYNOPSIS
    cpio  {-o|--create} [-0acvABLV] [-C bytes] [-H format] [-M message] [-O
    [[user@]host:]archive]            [-F            [[user@]host:]archive]
    [--file=[[user@]host:]archive]   [--format=format]  [--message=message]
    [--null] [--reset-access-time] [--verbose] [--dot] [--append] [--block-
    size=blocks]      [--dereference]      [--io-size=bytes]      [--quiet]
    [--force-local] [--rsh-command=command] [--help]  [--version]  <  name-
    list [> archive]

    cpio  {-i|--extract} [-bcdfmnrtsuvBSV] [-C bytes] [-E file] [-H format]
    ...

But when they have alternates, they use braces {} to group them.

Solaris 'tar' lists subcommand separately, and seems to use
braces {} for grouping alternates:

  SYNOPSIS
    tar  c   [   bBeEfFhiklnopPqvwX   [  0-7  ]  ]  [ block ]  [
    tarfile ]  [ exclude-file ]  { -I include-file  |  -C direc-
    tory  | file  | file }  ...


In our manual pages, less-than-greater-than around names are
very often used to mark placeholders.  If you want to say zero
or more files, you would typically say:

	command <file>...

Using something other than less-than-greater-than to group
alternates would make things easier to differentiate.  If we
used braces {} it _might_ have been more similar to what other
people have traditionally done.
