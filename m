From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Mon, 07 May 2012 21:50:49 +0200
Organization: Initfour websolutions
Message-ID: <4FA82799.1020400@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org> <7v8vh78dag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: greened@obbligato.org, dag@cray.com,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 21:51:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRTxT-0002mR-V8
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 21:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108Ab2EGTuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 15:50:55 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:47614 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757822Ab2EGTuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 15:50:54 -0400
Received: from [192.168.65.204] (hosted-by.initfour.nl [83.137.144.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 4125E1954407;
	Mon,  7 May 2012 21:50:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7v8vh78dag.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197302>

On 05/05/2012 06:25 AM, Junio C Hamano wrote:
> greened@obbligato.org writes:
>
>>> I basically did a: git subtree merge --prefix=contrib/subtree <my
>>> git-subtree branch>
>>>
>>> The work in progress in on: https://github.com/helmo/git (the
>>> subtree-updates branch)
>> This branch seems to have a bunch of commits from master or some other
>> branch:
> Isn't the confusing shape of the history a direct result of what Herman
> said he did above, i.e. use of "subtree merge"?  I thought that we agreed
> not to do any more subtree merges for further updates when we slurped the
> subtree history to contrib/ early in this cycle, so if that is the case,
> Herman needs to rebase his work so that the integration will not need any
> "subtree merge" into git.git, perhaps?
>
> I looked at various branches found with ls-remote in that repository but I
> couldn't quite tell which is what, with too many cross merges, among which
> there are unnecessary duplicated commits (e.g. 90275824 and b9a745f7 seems
> to be two equivalent commits) and questionable changes from the overall
> project's point of view.
>
> For example, it renames git-subtree.txt to README.md at a4416ee; while I
> find the idea of departing from asciidoc somewhat attractive (perhaps this
> is only because I haven't been burned by markdown yet), if "git subtree"
> wants to live in the git.git repository, that change is a regression.
> Later the file is renamed back to git-subtree.txt (README.md is lost) at
> 9ffdeb, a commit with a single-liner "fixing typo" log message adds the
> README.md file with full contents of git-subtree.txt again at d9ccd03b,
> and then later merge of the branch at 8861de28 finally decides to revert
> that to have a shorter README.md that the history originally had, or
> something.  In short, it is a mess.
>
> Not very impressed, but I have this suspition that the history I was
> looking at was not what was meant to be sent to me and an older
> incarnation of the project before Herman cleaned it up for public
> consumption, or something.
>
> Confused...

I agree that it's a messy history.  It the result of the many painful
merges I did. In various stages a conflicting indentation and other
changes made it painful to get a clean merge.
In an attempt to get through this in a pragmatic way the history has
taken some damage.

Before  starting this latest subtree merge I actually tried to rebase.
However this failed very quickly, on the I think third commit out of 60,
landing me in conflict resolution as I had already been through.
I'd love to improve git but this was just taking too mush effort.
When I saw the quick result from subtree merge that seemed like a good
thing.

Wouldn't a good rebase have almost just as messy a history as the
subtree merge?

As an alternative I've now applied a patch with all changes on a clean
master branch.
In the commit message I've named all committers from the original history.
Would that be acceptable?
Its now available as https://github.com/helmo/git/tree/subtree-updates
The subtree merge version is still available as
https://github.com/helmo/git/tree/subtree-updates-merged

-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
