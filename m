From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD
 as refs
Date: Fri, 10 Jul 2015 06:30:13 +0200
Message-ID: <559F4A55.1070309@alum.mit.edu>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>	<1436316963-25520-2-git-send-email-dturner@twopensource.com>	<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>	<559D92CF.7000408@kdbg.org>	<xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>	<1436399058.4542.26.camel@twopensource.com>	<xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>	<1436478800.4542.61.camel@twopensource.com> <xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 06:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDPxL-0001NX-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 06:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbbGJEa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 00:30:29 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51611 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805AbbGJEa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2015 00:30:27 -0400
X-AuditID: 12074411-f797e6d000007df3-7c-559f4a584752
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CF.06.32243.85A4F955; Fri, 10 Jul 2015 00:30:16 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96889.dip0.t-ipconnect.de [79.201.104.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6A4UDci031181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jul 2015 00:30:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqBvhNT/U4NZ3Pov5m04wWnRd6Way
	aOi9wmzxZO5dZgcWj4evutg9Ll5S9ljw/D67x+dNcgEsUdw2SYklZcGZ6Xn6dgncGS++32Qq
	+KRZMeNhK1sD42PFLkZODgkBE4njj+cwQthiEhfurWfrYuTiEBK4zCjx5fhxJgjnApNEy7Ne
	JpAqXgFtibt7D4PZLAKqErPOXWAFsdkEdCUW9TQDxTk4RAWCJF6/zIUoF5Q4OfMJC4gtIhAh
	0fCqBWwZs4CpxK2HM9lAbGGBSIm553rYIXadZZZ4vHcq2HxOAWuJM3d/s0A06EnsuP6LFcKW
	l2jeOpt5AqPALCQ7ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU
	0k2MkIAW3ME446TcIUYBDkYlHt4AtvmhQqyJZcWVuYcYJTmYlER591sChfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nw8ksA5XhTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxK
	ErzpnkCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBYjS8GRitIigdobwxIO29x
	QWIuUBSi9RSjopQ4Ly9IQgAkkVGaBzcWlqZeMYoDfSnMqwNSxQNMcXDdr4AGMwENjpaeBzK4
	JBEhJdXA2KY2VaXs6mqWUEaNrI8zV7PmHq+VDt/Z2e/vEDcn47bhmd1NhnpTL8w6nc4jWs22
	7IaROs/m7CKDp1nzpwg+Cn924WxN0dt3vAvu2Bze9P/lTgetB75vhPx+2x9Rs/we 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273800>

On 07/10/2015 12:06 AM, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
>> OK, here's my current best idea:
>>
>> 1. A "pseudoref" is an all-caps file in $GIT_DIR/ that always contains
>> at least a SHA1.  CHERRY_PICK_HEAD and REVERT_HEAD are examples. Because
>> HEAD might be a symbolic ref, it is not a pseudoref. 
>>
>> Refs backends do not manage pseudorefs.  Instead, when a pseudoref (an
>> all-caps ref containing no slashes) is requested (e.g. git rev-parse
>> FETCH_HEAD) the generic refs code checks for the existence of that
>> file and if it exists, returns immediately without hitting the backend.
>> The generic code will refuse to allow updates to pseudorefs.
>>
>> 2. The pluggable refs backend manages all refs other than HEAD.
>>
>> 3. The "files" backend always manages HEAD.  This allows for a reflog
>> and for HEAD to be a symbolic ref.
>>
>> The major complication here is ref transactions -- what if there's a
>> transaction that wants to update e.g. both HEAD and refs/heads/master?
> 
> An update to the current branch (e.g. "git commit") does involve at
> least update to the reflog of HEAD, the current branch somewhere in
> refs/heads/ and its log, so it is not "what if" but is a norm [*1*].

The updating of symlink reflogs in general, and particularly that of
HEAD, is not done very cleanly. You can see the code in
`commit_ref_update()` (some of it helpfully commented to be a "Special
hack"):

* If a reference is modified through a symlink, the symlink is locked
rather than the reference itself.
* If a reference is modified directly, and HEAD points at it, then the
HEAD reflog is amended without locking HEAD.

Aside from the lack of proper locking, which could result in races with
other processes, we also have the problem that the same reference that
is being changed via one of these implicit updates could *also* be being
changed directly in the same transaction. Such an update would evade the
`ref_update_reject_duplicates()` check.

Previously my thinking was that the locking should be done differently:
when the transaction is being processed, extra ref_update records could
be created for the extra reference(s) that have to be modified, then
these could be handled more straightforwardly. So supposing that HEAD
points at refs/heads/master,

* An update of HEAD would be turned into a reflog update and also add a
synthetic update to refs/heads/master.
* An update of refs/heads/master would add a synthetic update to the
HEAD reflog

The first point would obviously apply to any updates via symbolic refs.
The second one should too, thought this is a case that we currently punt
on to avoid the need to do reverse symbolic ref lookups.

>> It may be the case that this never happens; I have not actually audited
>> the code to figure it out.  If someone knows for sure that it does not
>> happen, please say so. But assuming it does happen, here's my idea:
>>
>> If the refs backend is the files backend, we can simply treat HEAD like
>> any other ref.
>>
>> If the refs backend is different, then the refs code needs to hold a
>> files-backend transaction for HEAD, which it will commit immediately
>> after the other transaction succeeds.  We can stick a pointer to the
>> extra transaction in the generic struct ref_transaction, which (as
>> Michael Haggerty suggests) specific backends will extend.
>>
>> A failure to commit either transaction will be reported as a failure,
>> and we'll give an additional inconsistent state warning if the main
>> transaction succeeds but the HEAD transaction fails.
> 
> Yeah, I was thinking along those lines, too.  Thanks for clearly
> writing it down.
> 
>> What do other folks think?
> 
> Me too ;-)

I don't have an answer right now, and I have to get on an airplane in a
few hours so I can't think hard about it at the moment. But let me also
braindump another vague plan that I have had for a long time:
overlayable reference storage schemes. Think of the way that loose refs
are currently overlaid on top of packed refs. I think it might be useful
to support overlaying more generally.

In this particular case there could be a workspace-local reference
storage that only handles HEAD and perhaps some of the other
pseudoreferences. That could be overlaid onto loose reference storage
(which would then only concern itself with references under "refs/"),
which would in turn be overlaid onto packed refs. The workspace-local
reference storage layer would have evil special-cased code for dealing
with the references that live outside of "refs/".

A `ref_transaction_commit()` would be broken into phases: first each of
the stacked backends would be asked to verify that the transaction is
possible and acquire any necessary locks, then each backend would get
the final "commit" command.

This construct would make it easy for different backends to share the
same implementation for HEAD (and potentially other workspace-local)
references, by simply layering that one storage mechanism on top of
their own.

That would probably be overengineering if it were only used to deal with
HEAD, but I think it is a nice general mechanism that could have other
applications.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
