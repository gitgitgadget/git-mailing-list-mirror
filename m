From: Sebastien Tardif <sebastien_tardif@oxfordcorp.com>
Subject: RE: Updated tags on repo are not updated when pull
Date: Tue, 3 Apr 2012 12:00:06 +0000
Message-ID: <27353249354D994D8E42D75D75FBA6148967BE@OASBEVEXM01.oaifield.onasgn.com>
References: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>,<CAJsNXTk8R0yjad0T9605v-CMMdCA+C0v3Rqt65h_k6MK88UD9g@mail.gmail.com>,<27353249354D994D8E42D75D75FBA6148965A9@OASBEVEXM01.oaifield.onasgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 14:00:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF2PL-0003i2-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 14:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2DCMAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 08:00:12 -0400
Received: from smtp11.onasgn.net ([166.70.65.165]:58396 "EHLO
	smtp11.onasgn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab2DCMAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 08:00:11 -0400
Received: from pps.filterd (smtp11 [127.0.0.1])
	by smtp11.onasgn.net (8.14.4/8.14.4) with SMTP id q33BuTB5004315
	for <git@vger.kernel.org>; Tue, 3 Apr 2012 05:00:09 -0700
Received: from oasslcexh04.oaifield.onasgn.com ([172.23.1.142])
	by smtp11.onasgn.net with ESMTP id 14009ug6fq-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 03 Apr 2012 05:00:08 -0700
Received: from OASBEVEXH01.oaifield.onasgn.com (172.22.1.46) by
 oasslcexh04.oaifield.onasgn.com (172.23.1.142) with Microsoft SMTP Server
 (TLS) id 14.1.339.1; Tue, 3 Apr 2012 05:00:07 -0700
Received: from OASBEVEXM01.oaifield.onasgn.com ([fe80::693c:1ef:7afc:6e9f]) by
 OASBEVEXH01.oaifield.onasgn.com ([fe80::70a5:31ce:8a13:d1f8%10]) with mapi id
 14.01.0339.001; Tue, 3 Apr 2012 05:00:06 -0700
Thread-Topic: Updated tags on repo are not updated when pull
Thread-Index: Ac0RBRIJ7NuhP9kdRiGOIq5xgbyYnwAXhZQAAAs0nN8AAFH6gA==
In-Reply-To: <27353249354D994D8E42D75D75FBA6148965A9@OASBEVEXM01.oaifield.onasgn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.1.140]
x-loop: 1
X-TM-AS-Product-Ver: SMEX-10.0.0.4152-6.800.1017-18814.005
X-TM-AS-Result: No--26.026800-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194613>

Like almost everything else, if a local repo is not updated, many things like HEAD and branch may not point to the latest thing.

I agree that using branch is somehow a workaround, but it's still wrong that the tag is not updated by default when doing pull. Even if I find a long documentation about this behavior, it will still be wrong.

Let just admit git is still new, this use case is not original at all, it just show some outstanding issue with Git.

I'm used to work with SCM that that is server base, each extra step a developer need to do create issues and productivity lost. They just needed to do commit/update, but end-up forgetting "add" when creating new file.

Now with git beside still forgetting 'add" they forget to push. And now they will forget to do a extra "pull --tag".

Designed for failure.
________________________________________
From: pjweisberg@gmail.com [pjweisberg@gmail.com] on behalf of PJ Weisberg [pj@irregularexpressions.net]
Sent: Monday, April 02, 2012 7:29 PM
To: Sebastien Tardif
Cc: git@vger.kernel.org
Subject: Re: Updated tags on repo are not updated when pull

On Mon, Apr 2, 2012 at 12:16 PM, Sebastien Tardif
<sebastien_tardif@oxfordcorp.com> wrote:
> Default pull behavior does bring new tag that are hitting the revisions involved in the pull, in other words all tags that would point to log entries that are pulled.
>
> I have tag like: LATEST_UIT, LATEST_QA, LATEST_CONTINOUS_BUILD
>
> But with this incoherent behavior of not having the already pulled tag been updated when doing a pull, my developers end-up with misleading information in their log since their tags point to old pointer.
>
> Please fix.

There's a discussion in the git-tag man page about titled "On
Re-tagging," the upshot of which is:

'Just admit you screwed up, and use a different
name. Others have already seen one tag-name, and if you keep the
same name, you may be in the situation that two people both have
"version X", but they actually have different "X"'s. So just call
it "X.1" and be done with it.'

You could use branches instead of tags for your 'latest X' things.  A
branch is basically a tag that moves.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
