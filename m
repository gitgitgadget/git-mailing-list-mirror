From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] doc: add some crossrefs between manual pages
Date: Wed, 12 Nov 2014 21:47:18 +0100
Message-ID: <96693472-344E-4ED3-B027-49A8303AF8C0@quendi.de>
References: <1415737027-44589-1-git-send-email-max@quendi.de> <xmqqppct5p1q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, spearce@spearce.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoeoy-0005Ev-JW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbaKLUrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:47:16 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:46661 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753248AbaKLUrQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 15:47:16 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Xoeoq-0006tW-7q; Wed, 12 Nov 2014 21:47:12 +0100
In-Reply-To: <xmqqppct5p1q.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1415825236;0369f0f6;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11.11.2014, at 23:51, Junio C Hamano <gitster@pobox.com> wrote:

> Max Horn <max@quendi.de> writes:
> 
>> I did this because I was browsing the remote helper docs online quite a bit,
>> and was wishing for some more direct links between the pages. While I can
>> manyally edit the URL, it seems logical to offer these links directly.
> 
>> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
>> ...
>> +linkgit:git-fast-import[1]
> 
>> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
>> ...
>> +linkgit:git-fast-export[1]
> 
> Makes sense to have these pair refer to each other.
> 
>> diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
>> ...
>> +linkgit:gitremote-helpers[1]
> 
>> diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
>> +linkgit:gitremote-helpers[1]
> 
> Likewise.  git-remote-* are instances of gitremote-helpers.
> 
>> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
>> index 64f7ad2..8edf72c 100644
>> --- a/Documentation/gitremote-helpers.txt
>> +++ b/Documentation/gitremote-helpers.txt
>> @@ -452,8 +452,14 @@ SEE ALSO
>> --------
>> linkgit:git-remote[1]
>> 
>> +linkgit:git-remote-ext[1]
>> +
>> +linkgit:git-remote-fd[1]
>> +
>> linkgit:git-remote-testgit[1]
> 
> Makes sense.
> 
>> +linkgit:git-fast-import[1]
> 
> This looks somewhat out of place; fast-import is not the only or
> even the primary way to do a remote-helper, is it?

It depends on how you look at it, I'd say. If you write a remote-helper that
uses the import/export feature, it is absolutely vital.  All remote helpers
I ever worked on are of that kind, so to me it is the primary way ;-),
although of course I realize there are others. So, how would you determine
which of the various methods is the "primary" one?

In fact, this single link is the one that motivated me to write the whole
patch; all the others were afterthoughts ;-).

To elaborate on that: In the past, I did some work on various import/export
remote-helpers; and I recall wishing for this precise link several times.
More recently, I worked on some tweaks and fixes for Felipe's git-remote-hg.
Whenever doing that, the place in the docs I start to refresh my memory on
how remote helpers work is gitremote-helpers. But then at some point I
realize "ah wait, *that* particular bit is actually part of the "fastimport"
protocol". So I need to look that up. And again and again thought "dang, why
isn't there a hyperlink for that here". Fact is, I need both man pages to
understand what's going on.

Now, clearly, I can live without that link. But I feel that there is a clear
connection.  And if you say it doesn't belong here because it is only
relevant for one of multiple ways to do a remote-helper, then shouldn't one
drop the links to git-remote-ext etc., too? After all, they are only
examples for one of multiple ways, too...

In other words, I find it arbitrary to exclude one link that is useful for
some, but not all remote-helper authors, while adding some other links that
are also useful for some, but not all remote-helper authors...

That said, I certainly don't plan to hold that patch hostage to this one
line. :-)


Cheers,
Max