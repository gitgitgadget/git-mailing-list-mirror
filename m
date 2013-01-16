From: Chris Hiestand <chiestand@salk.edu>
Subject: Re: [PATCH] Add Auto-Submitted header to post-receive-email
Date: Wed, 16 Jan 2013 09:29:14 -0800
Message-ID: <258F0FE2-D014-4624-A1E2-721E51F0E12C@salk.edu>
References: <E4715C92-2BE5-484E-A55B-273CAB5EB6B4@salk.edu> <67C048AA-0DA7-4397-A257-E0BE66089A5D@salk.edu> <7v392b8fv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWvd-00061S-SV
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab3APRhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:37:11 -0500
Received: from riis.snl.salk.edu ([198.202.70.55]:43993 "EHLO
	riis.snl.salk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3APRhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 12:37:10 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2013 12:37:10 EST
Received: from [172.18.0.8] (wsip-68-15-20-133.sd.sd.cox.net [68.15.20.133])
	(Authenticated sender: chiestand)
	by riis.snl.salk.edu (Postfix) with ESMTPSA id 45116EE06E;
	Wed, 16 Jan 2013 09:29:13 -0800 (PST)
In-Reply-To: <7v392b8fv3.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213776>

Andy, do you have any thoughts on adding this email header to
contrib/hooks/post-receive-email? This patch shouldn't cause problems for anyone
with a sanely configured mail delivery agent, and the additional header is very
useful in toggling auto responses.


This conforms to RFC3834 and is useful in preventing eg
vacation auto-responders from replying by default

Signed-off-by: Chris Hiestand <chiestand@salk.edu>
---
 contrib/hooks/post-receive-email |    1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index b2171a0..0e5b72d 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -237,6 +237,7 @@ generate_email_header()
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
 	X-Git-Newrev: $newrev
+	Auto-Submitted: auto-generated
 
 	This is an automated email from the git hooks/post-receive script. It was
 	generated because a ref change was pushed to the repository containing
-- 
1.7.10.4





On Sep 21, 2012, at 10:06 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Chris Hiestand <chiestand@salk.edu> writes:
> 
>> My email in April went unanswered so I'm resending it. An Auto-Submitted header
>> would be an improvement to the standard [git] post receive email.
>> 
>> Thanks,
>> Chris
>> 
>> 
>> Begin forwarded message:
>> 
>>> From: Chris Hiestand <chiestand@salk.edu>
>>> Subject: [PATCH] Add Auto-Submitted header to post-receive-email
>>> Date: April 14, 2012 6:15:10 PM PDT
>>> To: git@vger.kernel.org, gitster@pobox.com
>>> 
>>> Hi,
>>> 
>>> I think the Auto-Submitted header is a useful hook mail header to include by default.
>>> 
>>> This conforms to RFC3834 and is useful in preventing e.g. vacation auto-responders
>>> from replying by default.
>>> 
>>> Perhaps you have already considered this and decided not to include it, but I found
>>> no record of such a conversation on this list.
> 
> I think the lack of response is generally lack of interest, and the
> primary reason for that was because the To/Cc list did not contain
> anybody who touched this particular file in the past (and no, I am
> not among them; as contrib/README says, I am often the wrong person
> to ask if a patch to contrib/ material makes sense).
> 
>>> From 358fc3ae1ebfd7723d54e4033d3e9a9a0322c873 Mon Sep 17 00:00:00 2001
>>> From: Chris Hiestand <chiestand@salk.edu>
>>> Date: Sat, 14 Apr 2012 17:58:39 -0700
>>> Subject: [PATCH] Add Auto-Submitted header to post-receive-email
> 
> These four lines should not be in the body of the e-mail message
> (see Documentation/SubmittingPatches).
> 
>>> Adds Auto-Submitted: auto-generated to post-receive-email header
>>> This conforms to RFC3834 and is useful in preventing eg
>>> vacation auto-responders from replying by default
>>> ---
>>> contrib/hooks/post-receive-email |    1 +
>>> 1 files changed, 1 insertions(+), 0 deletions(-)
> 
> Even for contrib/ material, please always sign-off your patch (see
> Documentation/SubmittingPatches).
> 
>>> 
>>> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
>>> index 01af9df..282507c 100755
>>> --- a/contrib/hooks/post-receive-email
>>> +++ b/contrib/hooks/post-receive-email
>>> @@ -237,6 +237,7 @@ generate_email_header()
>>> 	X-Git-Reftype: $refname_type
>>> 	X-Git-Oldrev: $oldrev
>>> 	X-Git-Newrev: $newrev
>>> +	Auto-Submitted: auto-generated
>>> 
>>> 	This is an automated email from the git hooks/post-receive script. It was
>>> 	generated because a ref change was pushed to the repository containing
> 
> I think the choice of "auto-generated" is a sensible one, as
> responding to a 'push' is like triggered by 'cron'.
> 
> I'd however appreciate comments from people who either worked on
> this code or list regulars who actually use this code in the
> production.
> 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
