From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 02/14] t5500: add tests of fetch-pack --all --depth=N $URL $REF
Date: Wed, 19 Sep 2012 00:37:20 +0100
Organization: OPDS
Message-ID: <012B3B00ED9F48E5B0A8A4E21B944754@PhilipOakley>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu> <1347171589-13327-3-git-send-email-mhagger@alum.mit.edu> <7vmx0xmwr9.fsf@alter.siamese.dyndns.org> <504E6141.1080306@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Git List" <git@vger.kernel.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7LJ-0001eV-4A
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab2IRXg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:36:26 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61998 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751326Ab2IRXgY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:36:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuEKADrwWFBZ8rU+/2dsb2JhbABFDos6r3QCgQSBCYIbBQEBBQgBAS4eAQEhCwIDBQIBAw4HAQIJJRQBBBoGBxcGARIIAgECAwGHcwe6SYsbgXMEF4QCYAOIIYVEiRKPDYIsOw
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="404115877"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip01ir2.opaltelecom.net with SMTP; 19 Sep 2012 00:36:23 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205896>

From: "Michael Haggerty" <mhagger@alum.mit.edu>
Sent: Monday, September 10, 2012 10:53 PM
> On 09/10/2012 10:46 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Document some bugs in "git fetch-pack":
>>>
>>> 1. If "git fetch-pack" is called with "--all", "--depth", and an
>>> explicit existing non-tag reference to fetch, then it falsely
>>> reports
>>> that the reference was not found, even though it was fetched
>>> correctly.
>>>
>>> 2. If "git fetch-pack" is called with "--all", "--depth", and an
>>> explicit existing tag reference to fetch, then it segfaults in
>>> filter_refs() because return_refs is used without having been
>>> initialized.
>>

This probably isn't the right place in the series but I've just see a
question on SO
http://stackoverflow.com/questions/12475210/git-shallow-clone-along-with-branch
which gives a user case that may or may not be covered by the
pack-fetch.

The user was looking for 'git clone --depth 1 -b master' and comparing
it to a plain 'git clone --depth 1' and to 'git clone -b master' with
the follow up question "That is, why when passing -b it seems like it's
changing behaviour of --depth ?"

Perhaps something to test out.

Philip
