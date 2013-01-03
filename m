From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Thu, 03 Jan 2013 17:24:18 +0100
Message-ID: <50E5B0B2.7060205@alum.mit.edu>
References: <20130101172645.GA5506@thyrsus.com> <CAEUsAPYwinmbDkSVu71WJRgUjLfBeNdKDFt6O1f8-Ti9evn6Hw@mail.gmail.com> <7vmwwqyc8w.fsf@alter.siamese.dyndns.org> <CALWbr2xx0beca_LUHO45pGMZ4Y0jZ9-iMWq8WBO6PmW==Ysw=A@mail.gmail.com> <7vip7expd8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Chris Rorvick <chris@rorvick.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 17:24:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqnb4-0007RP-4u
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 17:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab3ACQYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 11:24:23 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:46531 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753402Ab3ACQYW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 11:24:22 -0500
X-AuditID: 1207440e-b7f116d0000008ae-b9-50e5b0b5a374
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 14.A7.02222.5B0B5E05; Thu,  3 Jan 2013 11:24:21 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r03GOIqj011927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 Jan 2013 11:24:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vip7expd8.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqLt1w9MAg2Wb5Cx+nd3FYrFz7j5W
	i6tbfCy6rnQzWTT0XmF2YPXYOesuu8fFS8oeu0+zeiz72sni8XmTXABrFLdNUmJJWXBmep6+
	XQJ3xoNZJ9gL9vJWLDz9mL2BsZG7i5GTQ0LARGL9nZOsELaYxIV769m6GLk4hAQuM0psmLmA
	HcI5xiTx7NxGZpAqXgFtiVdXz7KB2CwCqhLv1k9mArHZBHQlFvU0g9miAgESi5ecY4eoF5Q4
	OfMJC4gtIqAmMbHtEJjNLNDPKLF9tTWILSwQJNH7ZyvUsl4miWNNExhBEpwCZhIz7zxmhGjQ
	kXjX94AZwpaX2P52DvMERoFZSHbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	xnq5mSV6qSmlmxghIc63g7F9vcwhRgEORiUeXqb6JwFCrIllxZW5hxglOZiURHnL1z4NEOJL
	yk+pzEgszogvKs1JLT7EKMHBrCTCy7kCKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2a
	WpBaBJOV4eBQkuC9vR6oUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UrfHFwHgF
	SfEA7Q0FaectLkjMBYpCtJ5iNOZoeHnjKSPHrYabTxmFWPLy81KlxHnPgpQKgJRmlObBLYIl
	t1eM4kB/C/M+A6niASZGuHmvgFYxAa169eYxyKqSRISUVAOj767E7xJ67z7sy+x3/Mx3+WR/
	+AI5v0Uzrldu8GRZLvlw/gvlQ0bzOauMjif5V5cVLFvx4P6L+B9zZm/etjWE+cDV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212596>

On 01/03/2013 04:22 PM, Junio C Hamano wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
> 
>>> Doesn't Python come with a standard subprocess module that lets you
>>> spawn external programs safely, similar to the way Perl's list form
>>> open(), e.g. "open($fh, "-|", 'git', @args)", works?
> 
> ... and of course a more boring "system('git', $subcmd, @args)", as well.

Python's os.system() takes exactly one argument, which must be a string,
and executes it in a subshell.  subprocess is indeed the way to go.

>> You mean something like this:
>>
>>   p1 = subprocess.Popen([backend.command()], stdout=subprocess.PIPE)
>>   subprocess.Popen(["git", "fast-import", "--quiet"] + gitopts,
>> cwd=outdir, stdin=p1.stdout)
>>
>> Assuming gitopts is a list rather than a string. (care must be taken
>> with backend.command() also)
> 
> Yes.
> 
> I vaguely recall that the subprocess module once used to be one
> portability issue but that was between Python 2.3 and 2.4 or some
> ancient history, and it should no longer be relevant.

subprocess was added in Python 2.4, and the above example should work
fine in any version >= 2.4.  But please note that other functions have
been added to the module since then, like check_call() (v2.5),
check_output (v2.7), and some methods were added to the Popen object in
v2.6.

Such things are documented pretty reliably in the Python library
documentation [1]; when in doubt, one can view older versions of the
library documentation, which are all available online [2].

Michael

[1] http://docs.python.org/2/library/
[2] http://www.python.org/doc/versions/

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
