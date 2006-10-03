From: Stuart Rackham <srackham@methods.co.nz>
Subject: Re: pull-fetch-param.txt
Date: Wed, 04 Oct 2006 11:38:35 +1300
Message-ID: <4522E66B.4080103@methods.co.nz>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 00:39:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUsun-00010V-BD
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 00:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbWJCWi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWJCWi6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 18:38:58 -0400
Received: from fep03.xtra.co.nz ([210.54.141.243]:13054 "EHLO fep03.xtra.co.nz")
	by vger.kernel.org with ESMTP id S1030631AbWJCWi4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 18:38:56 -0400
Received: from falcon.methods.co.nz ([222.154.105.140]) by fep03.xtra.co.nz
          with ESMTP
          id <20061003223840.CJK25540.fep03.xtra.co.nz@falcon.methods.co.nz>;
          Wed, 4 Oct 2006 11:38:40 +1300
Received: from [192.168.1.6] (quark.methods.co.nz [192.168.1.6])
	by falcon.methods.co.nz (Postfix) with ESMTP id 25DA92786FB;
	Wed,  4 Oct 2006 11:38:40 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64f1np8i.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28310>

 From the AsciiDoc User Guide 
(http://www.methods.co.nz/asciidoc/userguide.html#X53):

If you want to disable unconstrained quotes, the new alternative 
constrained quotes syntax and the new index entry syntax then you can 
define the attribute asciidoc7compatible (for example by using the -a 
asciidoc7compatible command-line option).

--
Stuart Rackham


Junio C Hamano wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> writes:
> 
>> Junio C Hamano wrote:
>>> It's a bit sad that asciidoc's nicer quoting features
>>> are not backward compatible.
>> Yes, this is awkward. Here comes the next candidate for quoting.
> 
> [Stuart Rackham CC'ed]
> 
> At this point I have to say
> 
> 	What the h*ck AsciiDoc people are thinking?
> 
> Heck, I thought we were one of the more important customers of
> asciidoc project and not breaking us meant at least something to
> them; our name is at the top of "Project using AsciiDoc" section
> of their website, http:/www.methods.co.nz/asciidoc/.  Apparently
> I was delusional.
> 
> Introducing nicer new features is a good thing, but you do not
> break existing documents without a good reason and an escape
> hatch.
> 
> Put it more mildly, I think we need to find out what their
> policy on backward compatibility is, and if it is "screw it --
> you should re-mark-up your documents to match the newer rule
> every time we have a new release.  By the way, you always have
> the option to stay at older releases of ours", then we should
> seriously consider switching the documentation format to
> something else.  I honestly hope it does not have to come to
> that.
> 
>> In pull-fetch-param.txt:
>>
>> ----8<----
>> <refspec>::
>> 	The canonical format of a <refspec> parameter is
>> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
>> 	by the source ref, followed by a colon `:`, followed by
>> 	the destination ref.
>> +
>> The remote ref that matches <src>
>> is fetched, and if <dst> is not empty string, the local
>> ref that matches it is fast forwarded using <src>.
>> Again, if the optional plus `+` is used, the local ref
>> ---->8----
>>
>> "man git-fetch" and "man git-pull" show:
>> ----8<----
>>        <refspec>
>>               The  canonical  format of a <refspec> parameter is ?<src>:<dst>;
>>               that is, an optional plus, followed by the source ref,  followed
>>               by a colon :, followed by the destination ref.
>>
>>               The  remote  ref  that matches <src> is fetched, and if <dst> is
>>               not empty string, the local ref that matches  it  is  fast  for-
>>               warded  using  <src>. Again, if the optional plus + is used, the
>> ---->8----
>>
>> I.e. the first and second + were swallowed, but not the third one.
>> This is the fix for asciidoc 8.0.0:
>> 	`$$+$$?<src>:<dst>`; that is, an optional plus `+`, followed
> 
> Without looking at asciidoc 8.0 source, my guess is that it
> treats _anything_ that has two pluses on the same input line as
> quoted by some magical '+'-pair quote.   Can you try
> reformatting the original
> 
>> <refspec>::
>> 	The canonical format of a <refspec> parameter is
>> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
>> 	by the source ref, followed by a colon `:`, followed by
>> 	the destination ref.
> 
> to something like
> 
>> <refspec>::
>> 	The canonical format of a <refspec> parameter is
>> 	`+?<src>:<dst>`; that is, an optional plus
>> 	`+`, followed
>> 	by the source ref, followed by a colon `:`, followed by
>> 	the destination ref.
> 
> and verify that conjecture?
> 
> We already had to deal with this with your patch for tilde.
> Arguably tilde and caret are rare enough in plain text so we can
> live with having to spell it as {caret} and {tilde}, but if my
> guess is correct, that means we have to spell plus '+' as {plus}
> with an appropriate entry in asciidoc.conf (or "\+" if it works
> in both older and newer versions).  As more ordinary characters
> are taken for special mark-up purposes, we would need to keep
> adding them to our list.  Where does the madness end?
> 
> Fortunately AsciiDoc 8.0 is still young.  Maybe they can find a
> fix for this in a way that does not break documents written for
> (at least recent versions of) AsciiDoc 7; it might have to break
> documents written for early betas and the initial release of
> 8.0, but that is _much_ better than breaking existing documents,
> in my extremely biased opinion as a very unhappy user.
> 
