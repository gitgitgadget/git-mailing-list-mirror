From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 12/13] dir_iterator: new API for iterating over a
 directory tree
Date: Thu, 9 Jun 2016 14:35:22 +0200
Message-ID: <5759628A.4020704@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
 <38124bd892ac1f4683b7debe721fc69424a347be.1464957077.git.mhagger@alum.mit.edu>
 <CAPig+cRKa2QF9fp0in7wbPBzyY3UQbvNrioFWjxPjQQsoY=F9A@mail.gmail.com>
 <575956FB.9010207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	David Turner <novalis@novalis.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAzBN-0001lP-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 14:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbcFIMf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 08:35:29 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55762 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644AbcFIMf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 08:35:27 -0400
X-AuditID: 1207440c-c3fff70000000b85-b6-5759628ec4d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DC.7A.02949.E8269575; Thu,  9 Jun 2016 08:35:26 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59CZNJH032371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 08:35:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <575956FB.9010207@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqNuXFBluMPuItEXXlW4mi4beK8wW
	Sx6+ZrbonvKW0eJHSw+zxcyr1hZn3jQyOrB77Jx1l92jq/0Im8ez3j2MHhcvKXvsX7qNzWPx
	Ay+Pz5vkAtijuG2SEkvKgjPT8/TtErgztjUFF3zlqViw4QVzA+Miri5GTg4JAROJIw0PmEFs
	IYGtjBJzV+l2MXIB2eeZJM7sms0CkhAWiJRo6L3PBmKLCKhJTGw7xAJR9JFRYtP7LkYQh1lg
	OpPElztXWUGq2AR0JRb1NDN1MXJw8ApoS/z5oAISZhFQkVhw7yQ7iC0qECJxft1WsHJeAUGJ
	kzOfgC3jFNCRWHL/KhOIzSygLvFn3iVmCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCwp1nB+O3dTKHGAU4GJV4eC8kRoQLsSaW
	FVfmHmKU5GBSEuV9Yh0ZLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE92ECUI43JbGyKrUoHyYl
	zcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMH7G6RRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4
	NS8ltSixtCQjHhSR8cXAmARJ8QDtfQK2t7ggMRcoCtF6ilGX48j+e2uZhFjy8vNSpcR5uRKB
	igRAijJK8+BWwJLbK0ZxoI+FeW1BqniAiRFu0iugJUxAS5YfCQdZUpKIkJJqYOwXSlhw8dJx
	wx0Z0fxrYpVNL5wrejS1/lvl1XLrh2v4c+K07+inPH80+9MXZx3fYIbCT/aPeR7y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296883>

On 06/09/2016 01:46 PM, Michael Haggerty wrote:
> On 06/07/2016 07:13 AM, Eric Sunshine wrote:
>> [...]
> Thanks for all your great comments!

Junio,

Given that ref-iterators is in next but also that you will soon be
rewinding next, would you like these tweaks as a re-roll of the branch,
as fixup patches to squash on top, or as a new patch series to be
administered separately? I don't think any of these changes are serious
enough to warrant holding up ref-iterators, so it's mostly a question of
what would be most convenient for you.

For the case that you prefer a re-roll, I have pushed it to my fork on
GitHub [1] as branch ref-iterators. This branch squashes in Ramsay's
patch [2], addresses Eric's comments from this thread, and incorporates
the whitespace fix that you made when incorporating v2.

List of changes relative to v2:

* In "refs: introduce an iterator interface":

  * Make two vtables private.

  * Add a whitespace fix from Junio's mh/ref-iterators.

* In "dir_iterator: new API for iterating over a directory tree":

  * Add and improve some comments and docstrings.

  * Fix some formatting problems.

  * Use a for rather than a while loop in `dir_iterator_abort()` to
    improve the clarity.

  * Warn on failures of `opendir()`, `readdir()`, and `closedir()`
    that can't be explained as a simple race.

* In "for_each_reflog(): reimplement using iterators", make the vtable
  private.

If you'd prefer a separate series, let me know and I'll prepare that.

Michael

[1] https://github.com/mhagger/git
[2] http://thread.gmane.org/gmane.comp.version-control.git/296801
