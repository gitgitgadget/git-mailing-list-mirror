From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Pluggable backends for refs,wip
Date: Thu, 07 Aug 2014 05:57:17 -0700
Message-ID: <53E377AD.606@alum.mit.edu>
References: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFNG1-0007Vb-AT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbaHGM5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:57:21 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48094 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754413AbaHGM5U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2014 08:57:20 -0400
X-AuditID: 12074414-f79446d000001f1d-59-53e377af25d1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 24.24.07965.FA773E35; Thu,  7 Aug 2014 08:57:19 -0400 (EDT)
Received: from [192.168.1.22] (cpe-24-94-3-86.san.res.rr.com [24.94.3.86])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s77CvHba014892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 7 Aug 2014 08:57:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1F1f/jjYYPsKDouuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGly1iBRukKo5+SGpgXCbaxcjJISFgInFv0kpm
	CFtM4sK99WxdjFwcQgKXGSW2n4ZxTjJJ/Fp0ihGkildAXeL3oQ0sIDaLgKpE+9n9rCA2m4Cu
	xKKeZiYQW1QgSGL253nsEPWCEidnPgGrFxGIl3j04DgbiC0soCPRMHsHWFxIIEBiQlcPWD2n
	QKDE9/f/gWwOoIvEJXoag0BMZqC16+cJgVQwC8hLbH87h3kCo8AsJAtmIVTNQlK1gJF5FaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZIcIrsYDxyUu4QowAHoxIPr0XTo2Ah
	1sSy4srcQ4ySHExKorxuKY+DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwZpUA5XhTEiurUovy
	YVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHiTy4AaBYtS01Mr0jJzShDSTBycIMO5
	pESKU/NSUosSS0sy4kERGl8MjFGQFA/QXhuQdt7igsRcoChE6ylGXY4PvWfamIRY8vLzUqXE
	ectKgYoEQIoySvPgVsBS0StGcaCPhXklQEbxANMY3KRXQEuYgJbIqoItKUlESEk1MLJGfdno
	uXl9uGTDu+UPEl1mz09TOnn6yrSOz847/iqV32+8tN7i7bfMnDMNH+81nTtzlmGf79J+q4KL
	goe/hp/tbcusO6tQJLy92yEz70HTsRNxjG4rFkyeNZuzW63XZ9eP7PvCSTJbXWKD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254959>

On 08/05/2014 02:40 PM, Ronnie Sahlberg wrote:
> Please see
> https://github.com/rsahlberg/git/tree/backend-struct-db-2
> for an example of a pluggable backend for refs storage.
> 
> This series contain changes to make it possible to add new backends
> for handling/storage of refs and implements one new backend :
> refs-be-be.c .
> 
> This new backend offloads the actual refs handling to a small database
> daemon with which ita talks via a very simple rpc protocol. That
> daemon in turn then connects to the datastore and read/writes the
> values to it.
> [...]

Ronnie,

This is awesome!  Congratulations on your progress.

I'm still on vacation and haven't yet looked at the code.  I will be
back next week and hope to find time to check it out, and also to do
some more review of the code that you have already submitted to git core.


Have you thought about how to test alternate reference backends?  This
will be very important to getting one or more of them accepted into git
core (not to mention giving people confidence to actually *use* them!)

It seems to me that a few steps are needed:

* Each backend would need a suite of backend-aware tests that verify
proper operation *within* the backend.  These tests would mostly use
low-level plumbing commands like update-refs to create/modify/delete
references, and would be allowed to grub around in the filesystem, talk
directly with the database, etc. to make sure that the commands have the
correct effects.  For example, for the traditional filesystem backend,
these tests would be the ones to check that creating a reference causes
a file to spring into existence under $GIT_DIR/refs.

The tests for pack-refs, and all tests that care about the distinction
between packed and loose refs, would become part of the backend-aware
tests for the filesystem backend.

All of the backend-aware tests should be run every time the test suite
is run (provided, of course, that the correct prerequisites are
available, and subject to being turned off manually).

* The rest of the test suite has to be made backend-agnostic.  For
example, such tests should *not* be allowed to look under $GIT_DIR for
the existence/absence of loose reference files [1] but would rather have
to inquire about references via git commands.

* It should be possible for the developer to choose easily which
reference backend to use when running the agnostic part of the test
suite.  The chosen backend should be used to run *all* backend-agnostic
tests.

A database-backed backend might even want to be testable in two modes:
one with the DB daemon running constantly, and one where the daemon is
stopped and started between each pair of Git commands.

So after the changes, a single run of the test suite should run the
backend-aware tests for *all* known backends followed by the
backend-agnostic tests for a single selected backend.

Michael

[1] When I was working on my quagga-reference spike [2] I found that a
lot of the test suite uses knowledge about how references and reflogs
are stored by the filesystem backend and just grabs at the files rather
than accessing the references using git commands.  It will take some
work to clean this up.

[2] http://thread.gmane.org/gmane.comp.version-control.git/243726

-- 
Michael Haggerty
mhagger@alum.mit.edu
