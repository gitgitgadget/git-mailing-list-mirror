From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Sun, 05 Aug 2012 11:38:12 +0200
Message-ID: <501E3F04.4050902@alum.mit.edu>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxxPO-0003OK-Q1
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 11:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab2HEJpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 05:45:19 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:61193 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752827Ab2HEJpR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2012 05:45:17 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2012 05:45:17 EDT
X-AuditID: 12074413-b7f786d0000008bb-a3-501e3f07663c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BD.CF.02235.70F3E105; Sun,  5 Aug 2012 05:38:15 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A07.dip.t-dialin.net [87.162.74.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q759cDBQ017375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 5 Aug 2012 05:38:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqMtuLxdg0NYjYdF1pZvJoqH3CrMD
	k8fFS8oenzfJBTBFcdskJZaUBWem5+nbJXBn7Hl2hLWgWaziwb2tzA2MGwS7GDk4JARMJCZ+
	kupi5AQyxSQu3FvPBmILCVxmlPjdwNvFyAVkn2SSePT8AViCV0Bb4va+BhYQm0VAVeLk7qeM
	IDabgK7Eop5mJhBbVCBEYs23KYwQ9YISJ2c+AasXEVCTmNh2iAVkL7OAuET/P7CwsICPxME5
	F9kh9ppK/NqzF6yVU8BMYu+KBmaIcmuJb7uLQMLMAvIS29/OYZ7AKDALyYJZCFWzkFQtYGRe
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESnsI7GHedlDvEKMDBqMTD27lP
	NkCINbGsuDL3EKMkB5OSKG+XpVyAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHen/JA5bwpiZVV
	qUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV53O6ChgkWp6akVaZk5JQhpJg5O
	EMEFsoEHaAMnSCFvcUFibnFmOkTRKUZFKXHeKJCEAEgiozQPbgAskbxiFAf6R5g3FaSKB5iE
	4LpfAQ1mAhrsLQ82uCQRISXVwGhU0S+/f3mu8/rE4KIHO3KNs7ckp55dXvHlg3vdjWINjcdt
	V6yrIvjMsoNiysXMWS8bKiyc9yl6/Z+XQR+KrmuVbOvymxDPPnch29cZn5tPZ315wnb97pm1
	AeF/BGV7YrPqZ0Ru0kraVxtyUC017/b01/qXOw7M/Zz9Lf3RP9Ztb4xdJW7tjFFi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202906>

On 08/05/2012 06:56 AM, Junio C Hamano wrote:
> The "alternates" mechanism [...]
> The UI for this mechanism however has some room for improvement, and
> we may want to start improving it for the next release after the
> upcoming Git 1.7.12 (or even Git 2.0 if the change is a large one
> that may be backward incompatible but gives us a vast improvement).
 >
> Here are some random thoughts as a discussion starter. [...]
[...]
>     - Make the distinction between a regular repository and an object
>       store that is meant to be used for object sharing stronger.
>
>       Perhaps a configuration item "core.objectstore = readonly" can
>       be introduced, and we forbid "clone -s" from pointing at a
>       repository without such a configuration.  We also forbid object
>       pruning operations such as "gc" and "repack" from being run in
>       a repository marked as such.

Must the repository necessarily be "readonly"?  It seems that it would 
be permissible to push new objects to such a repository; just not to 
delete existing objects.  Thus maybe another term would be better to 
describe such a repository, like "appendonly" or "noprune" or even 
something more abstract like "donor".

I have some other crazy ideas for making the concept even more powerful:

* Support remote alternate repositories.  Local repository obtains 
missing objects from the remote as needed.  This would probably be 
insanely inefficient without also supporting...

* Lazy copying of "borrowed" objects to the local repository.  Any 
object fetched from the alternate object store is copied to the local 
object store.

Together, I think that these two features would give fully-functional 
shallow clones.

Such alternates could even be chained together: for example, keep a 
single local lazy clone of the upstream repository somewhere on your 
site or on your computer, and use that as read-through cache for other 
clones.

* To help manage local disk space, allow intelligent curation of the 
objects kept in the local store when they are also available in the 
alternate.  The criteria for what to keep could be things like 
"revisions with depth <= 20 on branches X, Y/*, and Z"; "objects that 
have been accessed within the last 3 months", "all tag objects 
refs/tags/release-*".  It should be possible to cull objects not meeting 
the criteria with or without actively fetching all objects meeting the 
criteria.  Probably the criteria would be stored in the configuration to 
be reused (and perhaps run as part of "git gc").

This would cure a lot of "storing big, non-deltaable files" pain because 
big blobs could be stored on a central server without multiplying the 
size of every clone.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
