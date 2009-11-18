From: Philip Hofstetter <phofstetter@sensational.ch>
Subject: Re: [PATCH] git am/mailinfo: Don't look at in-body headers when 
	rebasing
Date: Thu, 19 Nov 2009 00:47:15 +0100
Message-ID: <aa2993680911181547p4cbbf12cq74b482f63e59d007@mail.gmail.com>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com> 
	<20091118155154.GA15184@coredump.intra.peff.net> <20091118164208.GB15184@coredump.intra.peff.net> 
	<4B0478ED.30306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 00:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAuFY-0005YY-36
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 00:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbZKRXrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 18:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbZKRXrd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 18:47:33 -0500
Received: from mail.sensational.ch ([195.226.6.199]:55617 "EHLO
	mail.sensational.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbZKRXrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 18:47:32 -0500
Received: from [209.85.222.181] (helo=mail-pz0-f181.google.com)
	by mail.sensational.ch with esmtp (Exim 4.50)
	id 1NAuFN-0004il-A5
	for git@vger.kernel.org; Thu, 19 Nov 2009 00:47:37 +0100
Received: by pzk11 with SMTP id 11so1084236pzk.14
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 15:47:35 -0800 (PST)
Received: by 10.140.178.16 with SMTP id a16mr672105rvf.278.1258588055575; Wed, 
	18 Nov 2009 15:47:35 -0800 (PST)
In-Reply-To: <4B0478ED.30306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133207>

Hi,

On Wed, Nov 18, 2009 at 11:45 PM, Lukas Sandstr=F6m <luksan@gmail.com> =
wrote:

> The actual change is that mailinfo doesn't look for in-body headers
> at all if --no-inbody-headers is passed. git-am now passes this optio=
n
> to mailinfo when rebasing.

after all the earlier discussion and a lot of thinking, I have to say,
that IMHO, this is the best option as it doesn't rely on heuristics
and now that you chose a descriptive command line switch, even the
small problem of "why exactly is this switch here?" seems to go away.

As I have no experience in git's codebase at all, I'll leave the
commenting on the patch itself to the people with clue, but
conceptionally, this feels much better than the method 1

> This won't handle the case when a "bad" patch is passed to git-am fro=
m
> somewhere else than git rebase.

of course, that leaves the question what "somewhere else" can contain.
If it's just manual calls to git-am, this is a non-issue as it's
easily fixed by the caller. If it's being called from other
higher-level operations though, you might run into the same issue
again.

Here too, I can't really provide any meaningful input though as I just
don't know well enough what really makes git tick.

Just my two cents :-)

Philip
