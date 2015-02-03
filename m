From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Tue, 03 Feb 2015 16:11:06 +0100
Message-ID: <54D0E50A.5030601@alum.mit.edu>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com> <cover.1422737997.git.johannes.schindelin@gmx.de> <060e1e6a5530dfb311074b0aa854b281@www.dscho.org> <54CF70DA.5090506@alum.mit.edu> <d5ebe9aeb5f4dd5cbe8673ae2076ba04@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:11:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIf8R-0001wl-6T
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 16:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbbBCPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 10:11:17 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:65490 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306AbbBCPLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2015 10:11:16 -0500
X-AuditID: 12074411-f79fa6d000006b8a-5c-54d0e50c1701
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 28.F8.27530.C05E0D45; Tue,  3 Feb 2015 10:11:08 -0500 (EST)
Received: from [192.168.69.130] (p4FC96E08.dip0.t-ipconnect.de [79.201.110.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t13FB6wv021582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 3 Feb 2015 10:11:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <d5ebe9aeb5f4dd5cbe8673ae2076ba04@www.dscho.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqMvz9EKIQd8PNYuuK91MFg29V5gt
	+pd3sVn8aOlhdmDx+PAxzuNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M7YsuIlW8F2
	hYoJc54xNTBOl+pi5OSQEDCRaL+7lhHCFpO4cG89WxcjF4eQwGVGiVsrr0I5Z5kkznZvYu9i
	5ODgFdCWuPctCKSBRUBVYtqK6awgNpuArsSinmYmEFtUIEjiSstmZhCbV0BQ4uTMJywgtgjQ
	snkv1oDZzAKWEqefTWYDsYUFYiW2LDnDBLHrHaPEgskbwZo5BWwl9i5YwgzRoCex4/ovVghb
	XqJ562zmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJT
	SjcxQsJZcAfjjJNyhxgFOBiVeHgdlC6ECLEmlhVX5h5ilORgUhLljb0BFOJLyk+pzEgszogv
	Ks1JLT7EKMHBrCTCe+YRUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8Gh
	JMHr/xioUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Uq/HFwGgFSfEA7W0Aaect
	LkjMBYpCtJ5iVJQS560CSQiAJDJK8+DGwpLUK0ZxoC+FeZeBVPEAExxc9yugwUxAg2Uvgg0u
	SURISTUwWlxYbMTutsXw/bX4p53P2O39duW/tX93IuQ3h3jS1UU3VtzcUXH6xfker36uEB55
	bme7nIOLqmWydyRnffJQjWpRE316be5t6yVVV3wlDPWTdz48I8eisKDpxO9Xc5wY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263320>

On 02/02/2015 05:48 PM, Johannes Schindelin wrote:
> On 2015-02-02 13:43, Michael Haggerty wrote:
>> On 02/02/2015 12:41 PM, Johannes Schindelin wrote:
>>> Hi all (in particular Junio),
>>>
>>> On 2015-01-31 22:04, Johannes Schindelin wrote:
>>>
>>>> [...] switch to fsck.severity to address Michael's concerns that
>>>> letting fsck.(error|warn|ignore)'s comma-separated lists possibly
>>>> overriding each other partially;
>>>
>>> Having participated in the CodingStyle thread, I came to the
>>> conclusion that the fsck.severity solution favors syntax over
>>> intuitiveness.
>>>
>>> Therefore, I would like to support the case for
>>> `fsck.level.missingAuthor` (note that there is an extra ".level." in
>>> contrast to earlier suggestions).
>>
>> Why "level"?
> 
> "Severity level", or "error level". Maybe ".severity." would be better?

Sorry, I should have been clearer. I understand why the word "level"
makes sense, as opposed to, say, "peanut-butter". What I don't
understand is why a middle word is needed at all. In the config file it
will look like

[fsck "level"]
        missingAuthor = error

, which looks funny. "level" is a constant, so it seems superfluous.

If anything, it might be more useful to allow an optional middle word to
allow the strictness level to be adjusted based on which command
encounters the problem. For example, if you want to tolerate existing
commits that have missing authors, but not allow any new ones to be
pushed, you could set

[strictness]
        missingAuthor = ignore
[strictness "receive-pack"]
        missingAuthor = error

(There's probably a better word than "strictness", but you get the idea.)

>>> The benefits:
>>>
>>> - it is very, very easy to understand
>>>
>>> - cumulative settings are intuitively cumulative, i.e. setting
>>> `fsck.level.missingAuthor` will leave `fsck.level.invalidEmail`
>>> completely unaffected
>>>
>>> - it is very easy to enquire and set the levels via existing `git
>>> config` calls
>>>
>>> Now, there is one downside, but *only* if we ignore Postel's law.
>>>
>>> Postel's law ("be lenient in what you accept as input, but strict in
>>> your output") would dictate that our message ID parser accept both
>>> "missing-author" and "missingAuthor" if we follow the inconsistent
>>> practice of using lowercase-dashed keys on the command-line but
>>> CamelCased ones in the config.
>>>
>>> However, earlier Junio made very clear that the parser is required to
>>> fail to parse "missing-author" in the config, and to fail to parse
>>> "missingAuthor" on the command-line.
>>>
>>> Therefore, the design I recommend above will require two, minimally
>>> different parsers for essentially the same thing.
>>>
>>> IMHO this is a downside that is by far outweighed by the ease of use
>>> of the new feature, therefore I am willing to bear the burden of
>>> implementation.
>>
>> I again encourage you to consider skipping the implementation of
>> command-line options entirely. It's not like users are going to want to
>> use different options for different invocations. Let them use
>>
>>     git -c fsck.level.missingAuthor=ignore fsck
>>
>> if they really want to play around, then
>>
>>     git config fsck.level.missingAuthor ignore
>>
>> to make it permanent. After that they will never have to worry about
>> that option again.
> 
> Unfortunately, I have to pass the `receive.fsck.*` settings from
> `git-receive-pack` to `git-unpack-objects` or `git-index-pack` via the
> command-line, because it is `git-receive-pack` that consumes the config
> setting, but it is one of `git-unpack-objects` and `git-index-pack` that
> has to act on it...

Wouldn't that work automatically via the GIT_CONFIG_PARAMETERS
mechanism? If I run

    git -c foo.bar=baz $CMD

, then git-$CMD is invoked with GIT_CONFIG_PARAMETERS set to
"'foo.bar=baz'", which causes child processes to treat that value as a
configuration setting. I don't have a lot of experience with this but I
think it should do what you need.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
