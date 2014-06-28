From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] resolve_gitlink_ref_recursive(): verify format of symbolic
 refs
Date: Sat, 28 Jun 2014 07:34:09 +0200
Message-ID: <53AE53D1.9020905@alum.mit.edu>
References: <1403866877-15733-1-git-send-email-mhagger@alum.mit.edu>	<xmqqa98y2q8k.fsf@gitster.dls.corp.google.com> <xmqq61jm2pz7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 07:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0lHG-0004P2-4a
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 07:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbaF1FeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 01:34:13 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60761 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbaF1FeM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 01:34:12 -0400
X-AuditID: 1207440d-f797f6d000000a4a-44-53ae53d3917b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 48.88.02634.3D35EA35; Sat, 28 Jun 2014 01:34:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB18C2.dip0.t-ipconnect.de [93.219.24.194])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5S5Y91A007798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 28 Jun 2014 01:34:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqq61jm2pz7.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHs5eF2wwd/JBhZdV7qZLBp6rzBb
	TJy2mNmB2ePiJWWPz5vkPG4/28YSwBzFbZOUWFIWnJmep2+XwJ1xdNkRloKJchWPW6+xNzDu
	FO9i5OCQEDCR+DulsIuRE8gUk7hwbz0biC0kcJlRYs/FvC5GLiD7PJPEgu3XGUESvALaEmdO
	NbGA2CwCqhKbP55gBrHZBHQlFvU0M4HYogJBErM/z2OHqBeUODnzCVi9iICaxMS2Q2A2s4C1
	xIRfD1lBbGGBMImfRzqZIZYtYpTouTMLbCgnUNG1RQuYIQ4Vl+hpDILo1ZF41/eAGcKWl9j+
	dg7zBEbBWUjWzUJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsY
	IQHNu4Px/zqZQ4wCHIxKPLwf2tYGC7EmlhVX5h5ilORgUhLl/WS+LliILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO8pL6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC
	d2IQUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KH7ji4ERDJLiAdo7GaSdt7gg
	MRcoCtF6ilFRSpx3CkhCACSRUZoHNxaWpl4xigN9Kcw7C6SKB5ji4LpfAQ1mAhpsXrAKZHBJ
	IkJKqoGRvXbXzwf9+V9jdH4wJk4SX+XKtOdktw7vD4kDxRGKCRpx2ioLww5U/Ta8Xau5aZMe
	88yb9+adrP7lofprQ9mPaTqrXZe0N7S47wz25Ju20cBb5bPq6uS7Jz7IzpMq3p/R 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252597>

On 06/27/2014 07:59 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> When reading a symbolic ref via resolve_gitlink_ref_recursive(), check
>>> that the reference name that is pointed at is formatted correctly,
>>> using the same check as resolve_ref_unsafe() uses for non-gitlink
>>> references.  This prevents bogosity like
>>>
>>>     ref: ../../other/file
>>>
>>> from causing problems.
>>
>> I do agree that a textual symref "ref: ../../x/y" that is stored in
>> ".git/HEAD" or in ".git/refs/L" will step outside ".git/" and it is
>> problematic.  But if ".git/refs/heads/a/b/LINK" has "ref: ../../x"
>> in it, shouldn't we interpret it as referring to the ref at
>> "refs/heads/x"?

I've never seen that usage, nor seen it advocated.  Symrefs are not
propagated via the Git protocol, so even if somebody were doing this
privately, it could hardly be a project-wide practice.  I can't think of
a practical use for this feature.  And it would be mildly annoying to
implement.  So my inclination is to forbid it.

> Actually, the textual symrefs have been invented to replace symbolic
> links used for .git/HEAD on symlink-incapable filesystems, and we do
> even not let the filesystem follow symlinks.  The rule we have there
> are like so:
> 
> 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
> 		if (S_ISLNK(st.st_mode)) {
> 			len = readlink(path, buffer, sizeof(buffer)-1);
> 			if (len < 0) {
> 				if (errno == ENOENT || errno == EINVAL)
> 					/* inconsistent with lstat; retry */
> 					goto stat_ref;
> 				else
> 					return NULL;
> 			}
> 			buffer[len] = 0;
> 			if (starts_with(buffer, "refs/") &&
> 					!check_refname_format(buffer, 0)) {
> 				strcpy(refname_buffer, buffer);
> 				refname = refname_buffer;
> 				if (flag)
> 					*flag |= REF_ISSYMREF;
> 				continue;
> 			}
> 		}
> 
> So we should do exactly the same check, I would think, no?

I think you overlooked that if the (starts_with() &&
!check_refname_format()) check fails, execution falls through, ending up
here:

		/*
		 * Anything else, just open it and try to use it as
		 * a ref
		 */
		fd = open(path, O_RDONLY);
		if (fd < 0) {
			if (errno == ENOENT)
				/* inconsistent with lstat; retry */
				goto stat_ref;
			else
				return NULL;
		}
		len = read_in_full(fd, buffer, sizeof(buffer)-1);
		close(fd);
		[...etc...]

This has been the behavior since time immemorial [1].

In fact, another bug (which I probably introduced) is that in the case
of a symlink that points at a non-existent file, this code goes into an
infinite loop due to the "if (errno == ENOENT) goto stat_ref" in the
code that I quoted.  My mistake was forgetting that lstat() is statting
the link whereas open() follows the link, so the success of the former
does not imply that the latter should not ENOENT.

I suggest we fix both problems by making the code behave the way you
*thought* it behaves: symlinks are never followed via the filesystem,
but if the symlink contents have the form of a legitimate refname that
starts with "refs/", then we follow it the same way as we would follow a
textual-style symref.

> In a typical clone, the ".git/refs/remotes/origin/HEAD" textual
> symref stores "ref: refs/remotes/origin/master" and it is neither
> "ref: master" nor "ref: ./master", so it should be sensible to
> insist on "must start with 'refs/' and its format valid."

Yes, we don't even have a notation for "relative refnames" because we
would have no way to distinguish them from "absolute refnames" except
maybe via some artifice like a "./" prefix.

Michael

[1] Where by "time immemorial" I mean "since before I ever touched refs.c".

-- 
Michael Haggerty
mhagger@alum.mit.edu
