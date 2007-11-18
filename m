From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v4] user-manual: Add section "Why bisecting merge commits can be harder ..."
Date: Sun, 18 Nov 2007 10:47:24 +0100
Message-ID: <C5A2CF54-7055-461A-86B6-5A68489DA2C3@zib.de>
References: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de> <1194702594213-git-send-email-prohaska@zib.de> <20071118035934.GA29374@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItgnC-00019p-6l
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 10:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXKRJuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 04:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbXKRJuA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 04:50:00 -0500
Received: from mailer.zib.de ([130.73.108.11]:50796 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbXKRJt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2007 04:49:57 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAI9kAv4005847;
	Sun, 18 Nov 2007 10:49:42 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1b423.pool.einsundeins.de [77.177.180.35])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAI9k8fb021759
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 18 Nov 2007 10:46:09 +0100 (MET)
In-Reply-To: <20071118035934.GA29374@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65355>


On Nov 18, 2007, at 4:59 AM, J. Bruce Fields wrote:

> On Sat, Nov 10, 2007 at 02:49:54PM +0100, Steffen Prohaska wrote:
>> +[[bisect-merges]]
>> +Why bisecting merge commits can be harder than bisecting linear  
>> history
>> +-------------------------------------------------------------------- 
>> ---
>> +
>> +This section discusses how gitlink:git-bisect[1] plays
>> +with differently shaped histories.  The text is based upon
>> +an email by Junio C. Hamano to the git mailing list
>> +(link:http://marc.info/?l=git&m=119403257315527&w=2[link:http:// 
>> marc.info/?l=git&m=119403257315527&w=2]).
>> +It was adapted for the user manual.
>
> This is not the only text that's been taken from someplace else,  
> but if
> we attributed them all in the text it would get a little  
> cumbersome....
> I think the place for that kind of thing is in the commit message, but
> if we really think we need to include it in the main text, we could  
> add
> a separate "'acknowledgements" section.

ack for this change.

And a general comment: I had two purposes in mind when I
added this paragraph
1) Attribution;
2) Giving a reference to the original discussion.  If someone disagrees,
    or has further questions, the original discussion on the mailing
    list could be useful.

I believe the commit message is sufficient for attribution.
I don't think we need more.  Maybe if the manual goes to print
we need to reconsider.  But who know if this ever will happen.

However, adding a References section with links to other
resources could be a useful thing.  Such resources could give
additional information, without sacrificing the conciseness of
the manual.  An example are links to the original discussion on
the list.  Often they contain more details, which may sometimes
be useful.

Does asciidoc provide a mechanism for this?  Something like
\cite{} in LaTeX.



>> +
>> +Using gitlink:git-bisect[1] on a history with merges can be
>> +challenging.  Bisecting through merges is not a technical
>> +problem. The real problem is what to do when the culprit turns
>> +out to be a merge commit.  How to spot what really is wrong, and
>> +figure out how to fix it.  The problem is not for the tool but
>> +for the human, and it is real.
>
> I think we can pare that down a little.

 From your 7df716bec6bf6e3dafe4c36a6313a4346de2585a

+The gitlink:git-bisect[1] commands deals fine with history that  
includes
+merge commits.  However, when the final commit that ends on is a merge
+commit, the user may need to work harder than usual to figure out
+exactly what the problem was.

If you don't take the text below, first line: s/commands/command/

I'd reverse the order of the sentences.  The section is about
the difficulty, not about praising git-bisect.  How about

When the final commit that a bisect ends on is a merge commit,
the user may need to work harder than usual to figure out
exactly what the problem was.  This is not a technical
problem.  In principle, the gitlink:git-bisect[1] command
deals fine with history that includes merge commits.

It's your call.  I'm also fine with your version.


>> +
>> +Imagine this history:
>> +
>> +................................................
>> +      ---Z---o---X---...---o---A---C---D
>> +          \                       /
>> +           o---o---Y---...---o---B
>> +................................................
>> +
>> +Suppose that on the upper development line, the meaning of one
>> +of the functions that existed at Z was changed at commit X.  The
>> +commits from Z leading to A change both the function's
>> +implementation and all calling sites that existed at Z, as well
>> +as new calling sites they add, to be consistent.  There is no
>> +bug at A.
>> +
>> +Suppose that in the meantime the lower development line somebody
>> +added a new calling site for that function at commit Y.  The
>> +commits from Z leading to B all assume the old semantics of that
>> +function and the callers and the callee are consistent with each
>> +other.  There is no bug at B, either.
>> +
>> +Suppose further that the two development lines were merged at C
>> +and there was no textual conflict with this three way merge.
>> +The result merged cleanly.
>> +
>> +Now, during bisect you find that the merge C is broken.  You
>> +started to bisect, because you found D is bad and you know Z was
>> +good.  The breakage is understandable, as at C, the new calling
>> +site of the function added by the lower branch is not converted
>> +to the new semantics, while all the other calling sites that
>> +already existed at Z would have been converted by the merge.  The
>> +new calling site has semantic adjustment needed, but you do not
>> +know that yet.
>> +

 From your 7df716bec6bf6e3dafe4c36a6313a4346de2585a

+Nevertheless, the code at C is broken, because the callers added
+on the lower line of development have not been converted to the new
+semantics introduced on the upper line of development.  So if all
+you know is that D was bad, Z was good, and that a

s/a//?  I'm not sure; you are the native speaker ;)

+gitlink:git-bisect[1] identified C as the culprit, how will you
+figure out that the problem was due to this change in semantics?



>> +You need to find out what is the cause of the breakage by looking
>> +at the merge commit C and the history leading to it.  How would
>> +you do that?
>> +
>> +Both "git diff A C" and "git diff B C" would be an enormous patch.
>> +Each of them essentially shows the whole change on each branch
>> +since they diverged.  The developers may have well behaved to
>> +create good commits that follow the "commit small, commit often,
>> +commit well contained units" mantra, and each individual commit
>> +leading from Z to A and from Z to B may be easy to review and
>> +understand, but looking at these small and easily reviewable
>> +steps alone would not let you spot the breakage.  You need to
>> +have a global picture of what the upper branch did (and
>> +among many, one of them is to change the semantics of that
>> +particular function) and look first at the huge "diff A C"
>> +(which shows the change the lower branch introduces), and see if
>> +that huge change is consistent with what have been done between
>> +Z and A.
>> +

 From your 7df716bec6bf6e3dafe4c36a6313a4346de2585a

+When the result of a git-bisect is a non-merge commit, you should
+normally be able to discover the problem be examining just that commit.

s/be examining/by examining/

+Developers can make this easy by breaking their changes into small
+self-contained commits.  That won't help in the case above, however,
+because the problem isn't obvious from examination of any single
+commit; instead, a global view of the development is required.  To
+make matters worse, the change in semantics in the problematic
+function may be just one small part of the changes in the upper
+line of development.
+



>> +On the other hand, if you did not merge at C but rebased the
>> +history between Z to B on top of A, you would have get this
>> +linear history:
>> +
>> +................................................................
>> +    ---Z---o---X--...---o---A---o---o---Y*--...---o---B*--D*
>> +................................................................
>> +
>> +Bisecting between Z and D* would hit a single culprit commit Y*
>> +instead.  This tends to be easier to understand why it is broken.
>> +
>> +For this reason, many experienced git users, even when they are
>> +working on an otherwise merge-heavy project, keep the histories
>> +linear by rebasing their work on top of public upstreams before
>> +publishing.
>
> I'd say "partly for this reason", as I don't think this is the only
> reason people do that.
>
> I've done the above revisions and a few others and pushed them to
>
> 	git://linux-nfs.org/~bfields/git.git maint
>
> I'll take another look in the morning.

Besides the minor fixes above, ack from me.  We already spend
a lot of time on this section.  It improved compared to the
first version and I think it's now ready for the manual.

	Steffen
