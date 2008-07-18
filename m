From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 12:20:13 +0100
Message-ID: <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com>
References: <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
	 <alpine.DEB.1.00.0807171351380.8986@racer>
	 <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
	 <alpine.DEB.1.00.0807171513560.8986@racer>
	 <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
	 <20080717182253.GZ32184@machine.or.cz>
	 <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
	 <20080718091608.GL10151@machine.or.cz>
	 <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com>
	 <20080718100048.GN10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 13:21:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJo1c-00062C-TP
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 13:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbYGRLUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 07:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbYGRLUR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 07:20:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:8003 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbYGRLUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 07:20:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so93578ywe.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7U9Ld3BxUZKVK7DZcbN5KhKAhuG4cskKMoMTie7WmFU=;
        b=hWeTHnFHQITU7Ar9iwkkh6Ad9952jJSZKStciB7Va5iLA6qNWLlJWEuNW9EJfYH9Tb
         VyKNGn25OyKT1X/ikw8xOI1veI3MOzs5BJp8Mzk4yYJDukozOEioNaMra0aR+/7opjm2
         YtXlD6mcYSSywSYKTh7zb7Nf+P37gKTshXfps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lgF8VoAKc43K0X34YonPFarRcKvFTG9TAOY6poWKhDwHasC8UIEl0g8c46O6Hc6wkl
         ejfUOo+n58tQk9MqnqQZJ7eEebnWM1mPkzjhx/3WOlvvln8cHELvDWHll3tQNNJXbEYN
         kUYQLfLbu9H3hK34JVXYyqa+TD4oS0g1H86I0=
Received: by 10.103.213.10 with SMTP id p10mr478muq.46.1216380013754;
        Fri, 18 Jul 2008 04:20:13 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Fri, 18 Jul 2008 04:20:13 -0700 (PDT)
In-Reply-To: <20080718100048.GN10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89030>

On Fri, Jul 18, 2008 at 11:00 AM, Petr Baudis <pasky@suse.cz> wrote:
> On Fri, Jul 18, 2008 at 10:36:51AM +0100, Nigel Magnay wrote:
>> On Fri, Jul 18, 2008 at 10:16 AM, Petr Baudis <pasky@suse.cz> wrote:
>> > snip
>> >
>> >        "How do we mass-supply custom submodule URLs when publishing the
>> >        customized main repository at a custom location too?"
>> >
>> Yes - that is an additional problem.
>
> Wait, I'm lost again - _additional_ problem? How does it differ from the
> _original_ problem, how does it differ from what you're explaining below
> and how does what you're explaining below differ from the original
> problem?
>
In addition to the problem of needing to execute multiple commands and
edit files to acheive what is a rather simple usecase, there is the
additional problem of discovering (for a third party) a url for where
their submodules are stored.

> Or are we talking exclusively about what I summed up above now?
>
In this part of the thread. The first part seems to have broad
agreement that a command could be added / modified, but not yet what
it should look like.

>> If I may expand the usecase just so it's clear (and to check we're
>> talkiing the same language)
>>
>> I do something like
>> $ git remote add fred git://fredcomputer/superproject/.git
>> $ git fetch --submodules fred
>
> I think you mean git pull --submodules fred. Well, actually, you want to
> pull the main repository, then submodule update (_not_ pull in the
> submodules). See? This is part of the "semantic swamp" I mentioned
> before.

Ah - I understand. You're saying "you can't pull submodules when you
pull the supermodule, because you don't know which submodules might be
needed until you also merge / checkout the desired revision" ?

Ack.

>
> I think it should be somehow part of the _main_ project's fred branch
> that in this branch, the subprojects should be fetched from a different
> location; thus, you would still do
>
>        $ git remote add fred git://fredcomputer/superproject/.git
>        $ git pull fred
>        $ git submodule update
>

Yes, that makes sense.

> where either the submodule update takes the info from fred's adjusted
> .gitmodules, or it is an implicit part of the branch as in fred tells
> you to run the update command with some extra arguments.
>
> However, I still believe the information should primarily stem from the
> main repository; consider e.g. if you do not have some of the submodules
> checked out when you switch to fred, then figure out that in fred's
> branch, you really do want them checked out.
>

Yes.
Referring to your earlier mail, I'm now preferring "(4) Something else
that I'm not realizing." ;-)

Hm. It feels like each person could have some 'local' info in their
.gitmodules, and rules around merging; but I'm not sure of exactly
what, or how.
