From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bloom filters for have/want negotiation
Date: Mon, 14 Sep 2015 05:40:53 +0200
Message-ID: <55F641C5.2020007@alum.mit.edu>
References: <55F343F5.6010903@alum.mit.edu> <CAJo=hJstD8c2RPUAj2OznFSCuyJsKFmvymsQMHOPhGdaqPgyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git discussion list <git@vger.kernel.org>,
	Wilhelm Bierbaum <bierbaum@gmail.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 05:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbKdq-0005G9-P7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 05:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbbINDk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 23:40:58 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53793 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926AbbINDk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 23:40:57 -0400
X-AuditID: 1207440d-f79136d00000402c-bf-55f641c858e7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.85.16428.8C146F55; Sun, 13 Sep 2015 23:40:56 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96A58.dip0.t-ipconnect.de [79.201.106.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t8E3essh027253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 13 Sep 2015 23:40:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <CAJo=hJstD8c2RPUAj2OznFSCuyJsKFmvymsQMHOPhGdaqPgyvg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqHvC8VuowYRZshZTn81it+i60s1k
	8aOlh9li/qGJrA4sHjtn3WX3eNa7h9Hjz/k9rB6fN8kFsERx2yQllpQFZ6bn6dslcGec3T+R
	veAqd8W5FZ4NjPM5uxg5OCQETCQ+fhXoYuQEMsUkLtxbz9bFyMUhJHCZUaJ3fQMzhHOeSeL3
	jm4WkCpeAW2JD2sOgNksAqoSXzZvZQex2QR0JRb1NDOB2KICQRIrlr9ghKgXlDg58wlYvYiA
	msT2Cz2sIDazQIXEwXVzwOqFgY74sGoy2BwhgQKJtXf3gsU5BQIl7u3byAhRry7xZ94lZghb
	XqJ562zmCYwCs5CsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJT
	SjcxQsKZdwfj/3UyhxgFOBiVeHhP3PkaKsSaWFZcmXuIUZKDSUmUt/AHUIgvKT+lMiOxOCO+
	qDQntfgQowQHs5IIb4D1t1Ah3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwH
	h5IE7wIHoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UJzGFwMjFSTFA7T3EEg7
	b3FBYi5QFKL1FKMux5rZ99cyCbHk5eelSonz9oAUCYAUZZTmwa2AJa9XjOJAHwvz3gGp4gEm
	PrhJr4CWMAEteV/8CWRJSSJCSqqBMfHXhUXpxb41V+LbjAuee1hPfiDJ1HguaOGmPdvZtCd/
	bZYVP/JPOC+lPL/Z6S3/tN8J/fKH3EoYT60ovcr+2W/dbqd9Qv27K7b6na0qnWIQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277802>

On 09/12/2015 07:16 AM, Shawn Pearce wrote:
> On Fri, Sep 11, 2015 at 2:13 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I have been thinking about Wilhelm Bierbaum's talk at the last GitMerge
>> conference [1] in which he describes a scheme for using Bloom filters to
>> make the initial reference advertisement less expensive.
> ...
>> But it got me thinking about how the client could use a Bloom filter in
>> a later stage of the negotiation, when telling the server what objects
>> it already has, while preserving 100% reliability.
> ...
>> I don't have a gut feeling about the cost of this phase of the
>> negotiation, so I don't know whether this would be a net savings, let
>> alone one that is worth the added complexity. But I wanted to document
>> the idea in case somebody thinks it has promise. (I have no plans to
>> pursue it.)
> 
> Maybe I can help... it just so happens that I have Git servers at
> $DAY_JOB instrumented in the smart HTTP negotiate code. They do "many"
> fetch requests. :)
> [...]
> 
> Ergo, if this is all working correctly on smart HTTP, clients can
> fetch from a server they already "know" with decent efficiency, and
> smaller than your 2 KiB Bloom filter estimate for git.git at 1% error
> rate.

Thanks for the awesome data, Shawn. Your data do indeed seem to prove
that there would be no benefit to using Bloom filters in this part of
the negotiation.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
