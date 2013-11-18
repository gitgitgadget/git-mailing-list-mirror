From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] RelNotes: Spelling & grammar fixes.
Date: Mon, 18 Nov 2013 14:52:54 -0500
Message-ID: <528A7016.7020307@xiplink.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>	<1384448473-25840-1-git-send-email-marcnarc@xiplink.com> <xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 20:53:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViUsV-0003kA-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 20:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3KRTwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 14:52:55 -0500
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:44682 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab3KRTwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 14:52:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 8DDE52E0895;
	Mon, 18 Nov 2013 14:52:54 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp12.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2AEAE2E0824;
	Mon, 18 Nov 2013 14:52:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238010>

On 13-11-18 01:42 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> Mostly just tweaks, although I did change the "foo^{tag}" description a lot.
> 
> Thanks.  It is surprising that one can make so many typoes in a
> single document ;-)
> 
>> @@ -55,7 +55,7 @@ Foreign interfaces, subsystems and ports.
>>  
>>   * "git-svn" used with SVN 1.8.0 when talking over https:// connection
>>     dumped core due to a bug in the serf library that SVN uses.  Work
>> -   it around on our side, even though the SVN side is being fixed.
>> +   around it on our side, even though the SVN side is being fixed.
> 
> Hmph, is this a grammo?

I like to call it a "wordo".  :)

>> @@ -126,56 +126,58 @@ UI, Workflows & Features
>>     "git status --porcelain" instead, as its format is stable and easier
>>     to parse.
>>  
>> - * Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
>> -   "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" would be
>> -   a more convenient way to say "test $(git cat-file -t v1.0) = tag".
>> + * The ref syntax "foo^{tag}" (with the literal string "{tag}") peels a
>> +   tag ref to itself, i.e. it's a no-op., and fails if
>> +   "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" is
>> +   a more convenient way than "test $(git cat-file -t v1.0) = tag" to
>> +   check if v1.0 is a tag.
> 
> Much easier to read.  Thanks.
> 
>>   * "git branch -v -v" (and "git status") did not distinguish among a
>> -   branch that does not build on any other branch, a branch that is in
>> -   sync with the branch it builds on, and a branch that is configured
>> -   to build on some other branch that no longer exists.
>> +   branch that is not tracking any other branch, a branch that is in
>> +   sync with the branch it is tracking, and a branch that is tracking
>> +   some other branch that no longer exists.
> 
> People use the verb "track" to mean too many different things, and
> the original deliberately tried to avoid use of that word.
> 
> Specifically, we try to limit the use of "track" to mean "to keep a
> copy of what we observed from the remote" as in "remote-tracking
> branch remotes/origin/master is used to track the 'master' branch at
> your 'origin'", which is very different from "your 'master' branch
> builds on your upstream's 'master'".
> 
> So I dunno about this part of the change.

I see.

My initial motivation for the change was that I thought "does not build on"
could too easily be read as "does not compile on".

The change is literally about how branch.<name>.merge configurations are
interpreted.  The git-config docs describe that item as "the upstream branch
for the given branch."  So maybe we can use "upstream" instead:

 * "git branch -v -v" (and "git status") did not distinguish among a
   branch that is not based on any upstream branch, a branch that is in
   sync with its upstream branch, and a branch that is configured with an
   upstream branch that no longer exists.

		M.
