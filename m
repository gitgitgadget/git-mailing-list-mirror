From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fetch/push: allow refs/*:refs/*
Date: Tue, 15 May 2012 10:49:46 +0200
Message-ID: <4FB218AA.2060006@alum.mit.edu>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org> <7vwr4r8tpm.fsf@alter.siamese.dyndns.org> <4FA4C2CC.7080205@alum.mit.edu> <7vobq06jt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 10:57:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUDYu-0005g8-U6
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 10:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452Ab2EOI4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 04:56:52 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:51170 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758312Ab2EOI4u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 04:56:50 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 May 2012 04:56:50 EDT
X-AuditID: 12074411-b7f596d000000932-28-4fb218abdd7d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.66.02354.BA812BF4; Tue, 15 May 2012 04:49:47 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4F8nkN8021165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 May 2012 04:49:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vobq06jt7.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLtaYpO/wYOrxhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xr4X/5kLZmtVtP48yNjA2K/UxcjJISFgIvH8
	2yZWCFtM4sK99WxdjFwcQgKXGSUO757CCuEcZ5LYf/AlWBWvgLZE+/8JjCA2i4CqxLKVZ8Di
	bAK6Eot6mpm6GDk4RAXCJFY/0IAoF5Q4OfMJC4gtIqAmMbHtEAtICbOAuET/P7CwMNANS77d
	YYdYtZJR4sf+DWwgCU4BM4mWX33MEPXWEt92F4GEmQXkJba/ncM8gVFgFpINsxCqZiGpWsDI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJEQFdzDOOCl3iFGAg1GJh9dp
	/UZ/IdbEsuLK3EOMkhxMSqK8V/k3+QvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4XUTAcrxpiRW
	VqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR474kDNQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDojS+GBinICkeoL2zQNp5iwsSc4GiEK2nGHU5ZnxadI1RiCUv
	Py9VSpyXFZhShARAijJK8+BWwBLSK0ZxoI+FecVBqniAyQxu0iugJUxASxpZwJaUJCKkpBoY
	t1yZLj3PWbbvkfnX309jokvfzNsoybZ5dvI6u/UVj34/5yjKWP7lxsysNyH77yqdjTF6FnJJ
	gTX/e2DhDNt/it82z+N+wL9591fbIt3uuQ+SGMOOrIh7wbSBqaTJMvoH0+931ucm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197823>

On 05/07/2012 06:24 PM, Junio C Hamano wrote:
> Michael Haggerty<mhagger@alum.mit.edu>  writes:
>
>> This combination "!memcmp(ref->name, "refs/", 5)&&
>> check_refname_format(ref->name, 0)" is the reason that I suggested
>> adding a REFNAME_FULL option [1], in which case it could be written
>> "check_refname_format(ref->name, REFNAME_FULL)".
>
> I personally think that check-refname-format should lose its second
> parameter and always check for a concrete full refs, so that we can
> tighten the current allow-onelevel case a bit further (i.e. ".git/HEAD" is
> OK at the root level, but ".git/refs/heads/HEAD" is asking for trouble,
> and ".git/config" is downright confusing. The function does not get a good
> enough clue by only ONELEVEL).  That would mean REFNAME_FULL will not be
> necessary---it should be the only mode of operation, and the callers need
> to be adjusted accordingly.
>
> We should also introduce another function check-refspec-half-format to be
> used for the checks for left and right halves of refspec ("refs/heads/*"
> is OK but "refs/heads*" is not, perhaps).
>
> A single function trying to do both and not doing a good job in either
> case is not a pretty picture.

Whether the functionality is presented via one function with multiple 
options or multiple functions with no options is of secondary 
importance.  Let's first worry about the desired functionality, since 
even that is not clear.


There's a long weekend coming up in Germany so hopefully I'll have 
another increment of time to work on this.  I'd like to get feedback on 
the requirements.  First let me present a summary of what I know about 
refnames in git.


There are a few categories of refname that come up in the git code:

* Full refnames like "refs/foo" or "refs/bar/baz" (starting with "refs/").

* Top-level special ALL_CAPS reference names like "MERGE_HEAD".

* Refspec-style patterns with wildcards, like "refs/heads/*" or 
"refs/foo/*/bar".

* Short branch names with an implied "refs/heads/" prefix omitted; e.g., 
"master" meaning "refs/heads/master".

* Short tag names with an implied "refs/tags/" prefix omitted; e.g., 
"v1.2.3" meaning "refs/tags/v1.2.3".

* Maybe others...?


Currently, I believe that code usually handles the short branch/tag 
names via one of two mechanisms:

* Explicitly prepend "refs/heads/" or "refs/tags/" to the short name to 
make the corresponding full name, then work exclusively with the full name.

* Use the ref_rev_parse_rules based functions like dwim_ref() to guess 
which prefix can be applied to a short refname to make it into a full 
refname, then work exclusively with the full name.

If code will continue to work this way, then there might be no use for a 
function that can check short refnames; one would always convert the 
short refname into a full refname and check the latter.  On the other 
hand, a short refname check might do special things like *reject* a name 
that starts with "refs/".


In addition to the strict rules governing refnames, there are other 
policies that are enforced at varying levels of strictness or that might 
be helpful in the future; for example,

* Refnames either have to start with "refs/" or have to be ALL_CAPS.

* Refnames cannot be directly under "refs/" but should be in a namespace 
like "refs/heads/".  (This is implied by the old check-ref-format 
documentation:

> . They must contain at least one `/`. This enforces the presence of a
>   category like `heads/`, `tags/` etc. but the actual names are not
>   restricted.

This sentence also implies that check-ref-format was intended to be used 
for refnames shortened by having the "refs/" prefix omitted, which is 
curious.)

* Unlikely refnames like "refs/heads/HEAD" could be handled with 
suspicion, as you suggest.  I would also nominate constructs like 
"refs/heads/refs/heads/mybranch", which I've seen cause confusion at $WORK.


In terms of implementation:

* We want to distinguish between what is acceptable for new refnames 
versus refnames that already exist in the local repository and/or 
refnames received from a remote repo.  So there should be some kind of 
"REFNAME_RELAXED" option.

* It is important for the "old" check_refname_format() and the "new" one 
to coexist during the transition.  This is simply because I don't want 
to have to analyze and rewrite all ~30 callers of check_refname_format() 
in one big bang.  I suggest retaining a copy as 
check_refname_format_legacy() that is deprecated and removed after all 
callers have been rewritten.

* The exact current behavior of "git check-ref-format" will probably not 
map well to the new check_refname_format(), and is anyway inadequate and 
somewhat inconsistent.  We need to decide how strict we need to be about 
backwards-compatibility of this command.

* I've been using "git check-ref-format" for testing 
check_refname_format().  But I think it would be a bad idea to expose 
all of the check_refname_format() options and variants in an installed 
plumbing command.  Therefore I think that there should be a program that 
can be used to call check_refname_format() with all of its option 
combinations to be used only for testing purposes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
