From: Seb <spluque@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Sun, 21 Feb 2016 11:25:39 -0600
Organization: Church of Emacs
Message-ID: <8737sm6kmk.fsf@gmail.com>
References: <87io1j6laz.fsf@gmail.com> <56C91D21.90306@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 18:26:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXm0-0006BY-2U
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbcBUR0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:26:15 -0500
Received: from plane.gmane.org ([80.91.229.3]:48423 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbcBUR0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:26:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aXXlq-000643-TO
	for git@vger.kernel.org; Sun, 21 Feb 2016 18:26:11 +0100
Received: from s0106503955564c1f.wp.shawcable.net ([24.77.8.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 18:26:10 +0100
Received: from spluque by s0106503955564c1f.wp.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 18:26:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s0106503955564c1f.wp.shawcable.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:TPsClUDXQKGCfAoPqc7Ka4slpcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286801>

On Sun, 21 Feb 2016 03:12:49 +0100,
Moritz Neeb <lists@moritzneeb.de> wrote:

> Hi Seb,
> On 02/20/2016 11:58 PM, Seb wrote:
>> Hello,

>> I've recently learnt how to consolidate and clean up the master
>> branch's commit history.  I've squashed/fixuped many commits thinking
>> these would propagate to the children branches with whom it shares
>> the earlier parts of the its history.  However, this is not the case;
>> switching to the child branch still shows the non-rebased (dirty)
>> commit history from master.  Am I misunderstanding something with
>> this?

> I am not sure what you meand by "child branch". If I understand
> corretly, you have something like:

>             A---B---C topic
>            /
>       D---E---F---G master

Thanks Moritz and sorry for not adequately describing the situation.
The scenario is much simpler; imagine master has a longer history behind
the point where the topic branch started:

                A---B---C topic
               /
  *---D---E---F---G master

And we want to keep both branches separate (no desire to merge them for
now), but we realize that, say, commits D and E should be
squashed/fixup, so we do an interactive rebase.  Now, the problem is
that if I do that from the topic branch, the results are not reflected
in the master branch, even though these commits are certainly shared
with master.  It seems counterintuitive that a part of history that is
shared among branches can be independently manipulated/rewritten with
rebase.  I must be missing something...


-- 
Seb
