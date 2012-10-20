From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Sat, 20 Oct 2012 22:03:00 +0200
Organization: Initfour websolutions
Message-ID: <50830374.9090308@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org> <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com> <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl> <nng4npe6zsj.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dag@cray.com, greened@obbligato.org,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 22:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPfGa-0006tx-L3
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 22:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab2JTUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 16:03:04 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:36632 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447Ab2JTUDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 16:03:03 -0400
Received: from [192.168.65.204] (hosted-by.initfour.nl [83.137.144.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 4FED79FC6DD;
	Sat, 20 Oct 2012 22:03:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <nng4npe6zsj.fsf@transit.us.cray.com>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208095>

On 07/11/2012 06:14 PM, dag@cray.com wrote:
> Herman van Rink <rink@initfour.nl> writes:
>
>>> It's hard to tell what's what with one big diff.  Each command should
>>> get its own commit plus more if infrastructure work has to be done.  I
>>> realize it's a bit of a pain to reformulate this but git rebase -i makes
>>> it easy and the history will be much better long-term.
>>>
>>> Each command should be described briefly in the commit log.
>> That would indeed be nice, but as some parts interdependent it would be
>> rather complicated.
> Do the interdependent parts first, then.  These should be pure
> infrastructure.
>
>> And what is the use if their not fully independently testable.
> The command should be testable as soon as they are fully implemented,
> no?
>
> I'm thinking about a sequence like this:
>
> - Infrastructure for command A (and possibly B, C, etc. if they are
>   interdependent).
> - Command A + tests
> - Infrastructure for command B
> - Command B + tests
> - etc.
>
>> If you want to fake a nice history tree then go ahead, I just don't have
>> the energy to go through these commits again just for that.
> Well, I can't do this either, both because it would take time to get up
> to speed on the patches and because I have a million other things going
> on at the moment.  So unfortunately, this is going to sit until someone
> can take it up.
>
> Unless Junio accepts your patches, of course.  :)

Junio, Could you please consider merging the single commit from my
subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates

I've seen a few reactions on the git userlist refer to issues which have
long been solved in these collected updates.


>
>>> Some questions/comments:
>>>
>>> - Is .gittrees the right solution?  I like the feature it provides but
>>>   an external file feels a bit hacky.  I wonder if there is a better way
>>>   to track this metadata.  Notes maybe?  Other git experts will have to
>>>   chime in with suggestions.
>> It's similar to what git submodule does. And when you add this file to
>> the index you can use it on other checkouts as well.
> Well, I guess I'm not strongly opposed, I was just asking the question.
>
>>> - This code seems to be repeated a lot.  Maybe it should be a utility
>>>   function.
>> Yes that's there three times...
> So you agree it should be factored?
>
>>> - I removed all this stuff in favor of the test library.  Please don't
>>>   reintroduce it.  These new tests will have to be rewritten in terms of
>>>   the existing test infrastructure.  It's not too hard.
>> I've left it in to be able to verify your new tests. Once all the new
>> tests are passing we can get rid of the old one, not before.
>> And as all the old tests are contained in test.sh it should not interfere...
> No, I'm very strongly against putting this back in.  The new tests will
> have to be updated to the upstream test infrastructure.
>
>                                       -Dave
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
