From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [GSoC14][RFC] Proposal Draft: Refactor tempfile handling
Date: Tue, 11 Mar 2014 17:27:05 +0100
Message-ID: <531F3959.4060608@alum.mit.edu>
References: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:27:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNPWR-0003F0-9F
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 17:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbaCKQ1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 12:27:11 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57764 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753055AbaCKQ1I (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 12:27:08 -0400
X-AuditID: 12074411-f79ab6d000002f0e-a7-531f395bab26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 91.C0.12046.B593F135; Tue, 11 Mar 2014 12:27:08 -0400 (EDT)
Received: from [192.168.69.148] (p57A24642.dip0.t-ipconnect.de [87.162.70.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2BGR5qf005563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 11 Mar 2014 12:27:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAN7MxmVQuk96dmXfxZ5kRZPTXNwpz2RY=y8HyqX4mZzrZUVbNg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqBtjKR9s8OkVi0XXlW4mi1+Hn7Bb
	/GjpYXZg9tg56y67x7PePYwenzfJBTBHcdskJZaUBWem5+nbJXBnzN3xh7lgkkTF9v4PLA2M
	04S7GDk5JARMJI5cO8sMYYtJXLi3nq2LkYtDSOAyo8Se78uZIZxzTBIPJn8Fq+IV0JaYfeYO
	kM3BwSKgKjHjhRZImE1AV2JRTzMTiC0qECyx+vIDFohyQYmTM5+A2SICahKPj5xgBLGZBYwk
	Zq75AWYLC7hKLNy7AqxGSCBAYsmbB2BxToFAiYmL25lAVkkIiEv0NAZBtOpIvOt7wAxhy0ts
	fzuHeQKj4Cwk22YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJN
	jJCQFtzBOOOk3CFGAQ5GJR7eGUrywUKsiWXFlbmHGCU5mJREefdZAIX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8H7UBMrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4
	Z4IMFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFb3wxMIJBUjxAe8+AtPMWFyTm
	AkUhWk8x6nLcbvv1iVGIJS8/L1VKnHeDOVCRAEhRRmke3ApYAnvFKA70sTDvdJBRPMDkBzfp
	FdASJpDntsqBLClJREhJNTCaGGTnH9Q88/Ow5sx7nxNTbd54HtQsO+AXcOtwUJf12tra0tmm
	mk+qHq+q/b3t2qIPctoHjPOiJmXkv/0aOSMhs97icVvh1YTMjMubuNfLWsW3lZua 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243869>

On 03/01/2014 10:04 PM, Brian Gesiak wrote:
> Hello all,
> 
> My name is Brian Gesiak. I'm a research student at the University of
> Tokyo, and I'm hoping to participate in this year's Google Summer of
> Code by contributing to Git. I'm a longtime user, first-time
> contributor--some of you may have noticed my "microproject"
> patches.[1][2]
> 
> I'd like to gather some information on one of the GSoC ideas posted on
> the ideas page. Namely, I'm interested in refactoring the way
> tempfiles are cleaned up.
> 
> The ideas page points out that while lock files are closed and
> unlinked[3] when the program exits[4], object pack files implement
> their own brand of temp file creation and deletion. This
> implementation doesn't share the same guarantees as lock files--it is
> possible that the program terminates before the temp file is
> unlinked.[5]
> 
> Lock file references are stored in a linked list. When the program
> exits, this list is traversed and each file is closed and unlinked. It
> seems to me that this mechanism is appropriate for temp files in
> general, not just lock files. Thus, my proposal would be to extract
> this logic into a separate module--tempfile.h, perhaps. Lock and
> object files would share the tempfile implementation.
> 
> That is, both object and lock temp files would be stored in a linked
> list, and all of these would be deleted at program exit.
> 
> I'm very enthused about this project--I think it has it all:
> 
> - Tangible benefits for the end-user
> - Reduced complexity in the codebase
> - Ambitious enough to be interesting
> - Small enough to realistically be completed in a summer
> 
> Please let me know if this seems like it would make for an interesting
> proposal, or if perhaps there is something I am overlooking. Any
> feedback at all would be appreciated. Thank you!

Hi Brian,

Thanks for your proposal.  I have a technical point that I think your
proposal should address:

Currently the linked list of lockfiles only grows, never shrinks.  Once
an object has been linked into the list, there is no way to remove it
again even after the lock has been released.  So if a lock needs to be
created dynamically at a random place in the code, its memory is
unavoidably leaked.

This hasn't been much of a problem in the past because (1) the number of
locks acquired/released during a Git invocation is reasonable, and (2) a
lock object (even if it is already in the list) can be reused after the
lock has been released.  So there are many lock callsites that define
one static lock instance and use it over and over again.

But I have a feeling that if we want to use a similar mechanism to
handle all temporary files (of which there can be more), then it would
be a good idea to lift this limitation.  It will require some care,
though, to make sure that record removal is done in a way that is
threadsafe and safe in the event of all expected kinds of process death.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
