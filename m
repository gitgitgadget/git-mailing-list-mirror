From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: push branch descriptions
Date: Wed, 14 Nov 2012 14:52:23 +0100
Message-ID: <50A3A217.3000902@drmicha.warpmail.net>
References: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com> <CALkWK0meYVEe8OezEU2Oe-dQSZuo0ETwxXq3qWXzopH7x3msJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:52:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYdOS-0004be-1g
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab2KNNw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:52:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56986 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab2KNNwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 08:52:25 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1DC9E20A49;
	Wed, 14 Nov 2012 08:52:25 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 14 Nov 2012 08:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=zypKDr4bI54XkImnXKifa9
	prrn8=; b=ciJ1EZ/WVTISAquSdHrA36jJrOE3eQYMiWxnoxK2iDuMxyzd/ilCUm
	oceEqydK28khcWJJPXOfTAj5vybk6x2uiWCzofQM+dDa485SplMd9Vb/ynmEfpFb
	CyEhTZWohxRd6zN5olz9XK784G4DCEzVpvY4pz63Zky+nyKiBemng=
X-Sasl-enc: PEHrQjqsCcNEDl5FNhxYPCys++OjgqDAslYz4rJ32W9U 1352901144
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 901DC4827D8;
	Wed, 14 Nov 2012 08:52:24 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CALkWK0meYVEe8OezEU2Oe-dQSZuo0ETwxXq3qWXzopH7x3msJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209719>

Ramkumar Ramachandra venit, vidit, dixit 14.11.2012 11:33:
> Hi,
> 
> Angelo Borsotti wrote:
>> currently, there is no means to push a branch description to a remote
>> repository. It is possible to create a branch, but not to set its
>> description.
>> Would not be more correct to push also branch descriptions when
>> branches are pushed?
> 
> Branch descriptions are currently stored in .git/config (see
> branch.<branchname>.description), and are hence intended to be local.
> But yes, it would be nice to have it synced with the remote- I have no
> clue how to make that possible though.

I find that nice, too, but back then I seemed to be the only one, "then"
being the time when I proposed (and implemented) branch notes as notes
(git notes) being attached to the (sha1 of the) branch name (or any
other refname). They are versioned/shareable/syncable just like notes
are. I had all of this working (git branch --notes display, git
format-patch --cover-letter and such); what was missing was a way to
attach/look-up notes for remote branches, which is related to our
current lack of default handling of remote notes refs. That's not a
fundamental problem, just a matter of agreeing about a proper default
setup for remote notes refs.

As I said, others preferred local branch descriptions (no git notes) in
config, and that's what is in git.git now.

Michael
