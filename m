From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 20:51:32 -0000
Organization: OPDS
Message-ID: <17103971665F4C4495C6C96086A58B8F@PhilipOakley>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com> <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Andrew Ardill" <andrew.ardill@gmail.com>,
	"Tomas Carnecky" <tomas.carnecky@gmail.com>,
	"Woody Wu" <narkewoody@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Chris Rorvick" <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkhec-00087i-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 21:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab2LQUu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 15:50:56 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:10311 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753389Ab2LQUuz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 15:50:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAHyEz1BcHmeG/2dsb2JhbABFi3qyLBdzghkFAQEFCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGIBrohjF2DYmEDiCyFUZhVgnM
X-IronPort-AV: E=Sophos;i="4.84,304,1355097600"; 
   d="scan'208";a="394236095"
Received: from host-92-30-103-134.as13285.net (HELO PhilipOakley) ([92.30.103.134])
  by out1.ip04ir2.opaltelecom.net with SMTP; 17 Dec 2012 20:50:53 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211702>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Monday, December 17,
2012 7:21 AM
> Chris Rorvick <chris@rorvick.com> writes:
>
>> The forms of checkout that do not take a path are lumped together in
>> the
>> DESCRIPTION section, but the description for this group is dominated
>> by
>> explanation of the -b|-B form.  Split these apart for more clarity.
>>
>> Signed-off-by: Chris Rorvick <chris@rorvick.com>
>> ---
>>  Documentation/git-checkout.txt | 26 +++++++++++++++++---------
>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/git-checkout.txt
>> b/Documentation/git-checkout.txt
>> index 7958a47..a47555c 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -22,17 +22,18 @@ also update `HEAD` to set the specified branch as
>> the current
>>  branch.
>>
>>  'git checkout' [<branch>]::
>> +
>> + Update the index, working tree, and HEAD to reflect the
>> + specified branch.
>
> This is to "check out the branch" ;-)
>
> But of course, we cannot define "checkout" in terms of "checkout",
> so we need to phrase it without saying "checkout" and explain what
> it *means* to check out the branch.
>
> I am not sure "Reflect" is a good word.  Making the result similar
> to the branch is only one aspect of the act of checking out the
> branch. The other equally important aspect is that this is done to
> advance the history of the branch.
>
> Perhaps...
>
> Prepare to work on building new history on <branch>, by
> pointing the HEAD to the branch and updating the index and
> the files in the working tree.  Local modifications to the
> files in the working tree are kept, so that they can be
> committed on the <branch>.

>From a user perspective it's better to refer to the working directory
first rather than the internal mechanics. Perhaps:

    Prepare to work on <branch>, by updating the files in the
    working tree and index to the branch's previous content, and
    pointing HEAD to it.

    Local modifications to the files in the working tree are kept,
    so that they can be committed on the <branch>.

>
>>  'git checkout' -b|-B <new_branch> [<start point>]::
>>
>> + Specifying `-b` causes a new branch to be created as if
>> + linkgit:git-branch[1] were called and then checked out.  In
>> + this case you can use the `--track` or `--no-track` options,
>> + which will be passed to 'git branch'.  As a convenience,
>> + `--track` without `-b` implies branch creation; see the
>> + description of `--track` below.
>>  +
>>  If `-B` is given, <new_branch> is created if it doesn't exist;
>> otherwise, it
>>  is reset. This is the transactional equivalent of
>> @@ -45,6 +46,13 @@ $ git checkout <branch>
>>  that is to say, the branch is not reset/created unless "git
>> checkout" is
>>  successful.
>>
>> +'git checkout' [--detach] [<commit>]::
>> +
>> + Update the index and working tree to reflect the specified
>> + commit and set HEAD to point directly to <commit> (see
>> + "DETACHED HEAD" section.)  Passing `--detach` forces this
>> + behavior even if <commit> is a branch.
>
> Prepare to work on building new history on top of <commit>,
>        by detaching HEAD at the commit and ...(likewise)...
