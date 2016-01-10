From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH V3 0/2] specify commit by negative pattern
Date: Sun, 10 Jan 2016 23:36:38 -0000
Organization: OPDS
Message-ID: <72AF834F7D7B46D298EFE697EBF19E0E@PhilipOakley>
References: <xmqq37u82apv.fsf@gitster.mtv.corp.google.com> <1452392429-2578-1-git-send-email-ischis2@cox.net> <1686181.AoEpo53h6D@thunderbird>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Duy Nguyen" <pclouds@gmail.com>
To: "Stephen & Linda Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 00:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIPXZ-00036g-8V
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 00:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbcAJXgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 18:36:49 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38006 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757488AbcAJXgs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2016 18:36:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DqDQDg6pJWPCYvBlxeGQEBAQELAQIBAQECgwpSbYdNgQyxPYQABxgMhWUBAwEBgRQ9EAEBAQEBAQEGAQEBAUEkG4QvBQEBAQEDCAEBLhYIAQEhCwIDBQIBAxUDCSUUAQQYAgYHAxQGCAsIAgECAwEMBIgRCrVJiQkthlaEf4ghgRsFjT86iRoBgTaEDIl0SoxVhWSIbTmENT40AQEBhgMBAQE
X-IPAS-Result: A2DqDQDg6pJWPCYvBlxeGQEBAQELAQIBAQECgwpSbYdNgQyxPYQABxgMhWUBAwEBgRQ9EAEBAQEBAQEGAQEBAUEkG4QvBQEBAQEDCAEBLhYIAQEhCwIDBQIBAxUDCSUUAQQYAgYHAxQGCAsIAgECAwEMBIgRCrVJiQkthlaEf4ghgRsFjT86iRoBgTaEDIl0SoxVhWSIbTmENT40AQEBhgMBAQE
X-IronPort-AV: E=Sophos;i="5.20,550,1444690800"; 
   d="scan'208";a="82876805"
Received: from host-92-6-47-38.as43234.net (HELO PhilipOakley) ([92.6.47.38])
  by out1.ip02ir2.opaltelecom.net with SMTP; 11 Jan 2016 00:17:13 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283626>

From: "Stephen & Linda Smith" <ischis2@cox.net>
> On Sunday, January 10, 2016 01:25:42 PM Philip Oakley wrote:
>> From: "Stephen P. Smith" <ischis2@cox.net>
>> > Add support for negative pattern matching in  <at> ^{/<pattern>} style
>>
>> Has this become mangled by replacing the '@' with ' <at> ' ?
> It looks like the cover letter got mangled.  I will fix after I get any 
> comments
> on the patches themselves.
>

I think I was also confused between the extra ways of spelling @ (listed 
first in revisions.txt), and the extra was of spelling <rev>, i.e. the 
<rev>^{/<text>}, and then in patch 2/2 it actually being the :/<text> 
syntax.

>>
>> When I look at the update to revisions.txt it doesn't look like its 
>> touching
>> the '@' description.
>> Is this '@^' a new (for the documenation) combination. Or has the example
>> confused me?
>>
>> > revision specifiers. So now you can find the first commit whose message
>> > doesn't match a pattern, complementing the existing positive matching.
>> > e.g.:
>> >
>> >    $ git rebase -i  <at> ^{/!-^WIP}
>> >
>> > My use-case is in having a "work, work, work, rebase, push"-style
>> > workflow, which generates a lot of "WIP foo" commits. While rebasing is
>> > usually handled via "git rebase -i origin/master", occasionally I will
>> > already have several "good, but not yet ready to push" commits hanging
>> > around while I finish work on related commits. In these situations, the
>> > ability to quickly "git diff  <at> ^{/!-^WIP}" to get an overview of 
>> > all
>> > changes "since the last one I was happy with", can be useful.
>> >
>> > This is the second version of the patch series. The previous attempt
>> > used the notation  <at> ^{/!WIP}, rather than  <at> ^{/!-WIP}, so the
>> > "modifier"
>> > was the '!' character. Now, '!' is taken as an indicator that the
>> > pattern is to be interpreted differently, and '-' is taken as an
>> > indicator of how it is to be interpreted differently. This follows
>> > recent discussion with "Junio C Hamano" <gitster <at> pobox.com> and
>> > much-less
>> > recent discussion archived at:
>> >
>> > http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477
>> >
>> > In summary, '!' is to be used as an "escape hatch", for further
>> > extension of the "name commit by pattern" functionality. Theorised 
>> > future
>> > extensions indicated things like "what was to be searched",
>> > e.g.:  <at> ^{/!(a=author)}.  With only two interpretations of the '!'
>> > leader, for now (including the '!!' literal notation), adding such a
>> > verbose form, such as ' <at> ^{/!(negative)foo}', seemed inappropriate 
>> > at
>> > this
>> > time. In the event that such verbose forms are ever implemented, this 
>> > new
>> > form may act as a shorthand, for a basic case.
>> >
>> > Will Palmer (2):
>> >  test for '!' handling in rev-parse's named commits
>> >  object name: introduce '^{/!-<negative pattern>}' notation
>> >
>> > Documentation/revisions.txt | 11 +++++-----
>> > sha1_name.c                 | 20 ++++++++++++-----
>> > t/t1511-rev-parse-caret.sh  | 53
>> > ++++++++++++++++++++++++++++++++++++++++++++-
>> > 3 files changed, 73 insertions(+), 11 deletions(-)
>> >
>> --
>> Philip
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
