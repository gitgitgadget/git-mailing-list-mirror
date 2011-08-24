From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to check out the repository at a particular point in time
Date: Wed, 24 Aug 2011 17:41:55 +0200
Message-ID: <4E551BC3.8080701@op5.se>
References: <201108221525.32982.trast@student.ethz.ch> <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com> <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: rdiezmail-temp2@yahoo.de, Thomas Rast <trast@student.ethz.ch>,
	in-git-vger@baka.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:42:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFah-0001b7-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab1HXPmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 11:42:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60231 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab1HXPl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 11:41:59 -0400
Received: by bke11 with SMTP id 11so994618bke.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 08:41:58 -0700 (PDT)
Received: by 10.204.128.80 with SMTP id j16mr2400140bks.9.1314200517994;
        Wed, 24 Aug 2011 08:41:57 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id f9sm331755bkt.3.2011.08.24.08.41.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 08:41:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.18) Gecko/20110621 Fedora/3.1.11-1.fc14 Thunderbird/3.1.11 ThunderGit/0.1a
In-Reply-To: <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180011>

On 08/23/2011 05:54 PM, Michael Witten wrote:
> On Mon, Aug 22, 2011 at 15:18, R. Diez<rdiezmail-temp2@yahoo.de>  wrote:
>>> The main problem is that your request is not very
>>> well-defined: in
>>> nonlinear history there will in general be more than one
>>> commit at the
>>> time requested.
>>>
>>>      ---a----b----c----M----  (M is a merge)
>>>          \            /
>>>           d-----e----f
>>>
>>>               ^----April 1st
>>>
>>> Suppose you ask git for "the newest commit as of April 1st"
>>> in this history.  Is it supposed to give you b or d?
>>
>> I still don't quite understand how git works, but let me
>> risk a naive statement here. If "a-b-c-M" were 'master',
>> and "d-e-f" were 'new-feature', then on April 1st the
>> current version on 'master' is 'b', because I merged the
>> 'new-feature' branch at a later point in time. Does that
>> make sense?
> 
> O! for the love all that is Holy!
> 
> You see, guys? The term `branch' was a TERRIBLE choice.
> 
> What git calls `branch master' in your example is just a pointer to
> the commit object `M'; it has nothing to do with particular lineages
> like `a-b-c-M'.
> 

Back in 2005 when git was young and fresh, there was a discussion about
what to call things. If memory serves (which it might not), I think
the consensus was that "branch" works just fine, and when someone who
doesn't like it comes along we can just tell them that it's short for
"tip-of-branch pointer", which is far more accurate. A "ref" is always
local though, which is why the reflog (which is used for such date
resolving problems) is never even considered to work on remote refs.
They *can* work on remotes' refs though, which is a slightly different
thing.

Whatever, really. The fact that pretty much everyone seems to know
what a branch is and how it works in git after a (very) brief intro
to it means it's either right on target or that people are so used to
the fact that branch means something different in every scm that they
don't even bother loading the word with some preconceived notion that
used to be right in cvs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
