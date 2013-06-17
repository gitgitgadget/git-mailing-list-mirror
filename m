From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Mon, 17 Jun 2013 19:10:27 +0100
Organization: OPDS
Message-ID: <F2D994ABCB8442B5A3F71791BAFB7C80@PhilipOakley>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com><7vli69iff2.fsf@alter.siamese.dyndns.org><vpqip1d803r.fsf@anie.imag.fr><7B6316FB423B45559A4698FD35D519FC@PhilipOakley> <vpq61xc1wnd.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 20:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uodsp-0003NQ-Va
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 20:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3FQSKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 14:10:23 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:6614 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753583Ab3FQSKX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 14:10:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhcOAFxQv1FOl3t//2dsb2JhbABbFoJzMYkHtjMEAQMBfRd0gh4FAQEFCAEBLh4BASELAgMFAgEDEQMBAQEKJRQBBBoGBw8IBhMIAgECAwGIAbl9jl1qgwZhA4hohgaUdYUhgxA7
X-IronPort-AV: E=Sophos;i="4.87,882,1363132800"; 
   d="scan'208";a="413383839"
Received: from host-78-151-123-127.as13285.net (HELO PhilipOakley) ([78.151.123.127])
  by out1.ip04ir2.opaltelecom.net with SMTP; 17 Jun 2013 19:10:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228094>

From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
Sent: Monday, June 17, 2013 6:20 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> +       Note that `--force` applies to all the refs that are pushed,
>>> +       hence using `git push --all --force`, or `git push --force`
>>> +       with `push.default` set to `matching` may override refs 
>>> other
>>> +       than the current branch (including local refs that are
>>> +       strictly behind their remote counterpart). To force a push 
>>> to
>>> +       only one branch, use `git push <remote> +<branch>` instead 
>>> of
>>> +       `--force`.
>>
>> It would be useful to include a real example "e.g. `git push origin
>> +master`", or a link to specifying a refspec "see <refspec>... 
>> above",
>> such that the "+" doesn't get lost in the general text, as push is 
>> one
>> of the first few commands a new user is likely to be looking up (and
>> misunderstanding ;-), so let's make the + obvious
>
> Yes, why not. I'll point to the <refspec> section for detail, and just
> give an example here.
>
>> I did notice that the <refspec>... section doesn't actually associate
>> the "+" with the force action - Am I misunderstanding this?
>
> It says:
>
>  By having the optional leading `+`, you can tell Git to update the
>  <dst> ref even if it is not allowed by default (e.g., it is not a
>  fast-forward.)"
>
> I think it's OK.

I was more noting that there is zero direct association in the text 
between the --force option, and the "+", and with that, a funny feeling 
that either (a) they had subtle differences I hadn't understood, or (b) 
they were exactly the same and the documenation was being too subtle and 
a cluebat should be applied to the documenation (on the principle I am 
not a unique fool ;-)

>
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Maybe...
------- 8< ------- 
From 57d8aaac6b7543919aaf09909c13a180722c0a94 Mon Sep 17 00:00:00 2001
From: Philip Oakley <philipoakley@iee.org>
Date: Mon, 17 Jun 2013 18:47:04 +0100
Subject: [PATCH] git-push doc: +<dst> refspec is --force

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-push.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index eb2883c..df92b09 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -136,6 +136,8 @@ already exists on the remote side.
  not an ancestor of the local ref used to overwrite it.
  This flag disables the check.  This can cause the
  remote repository to lose commits; use it with care.
+ See also the optional leading `+` <dst> ref specifier in
+ '<refspec>...' above.

 --repo=<repository>::
  This option is only relevant if no <repository> argument is
-- 
1.8.1.msysgit.1
