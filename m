From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH] Make sure that the commit message has Unix	format
 line
Date: Wed, 11 Feb 2009 19:14:00 +0100
Message-ID: <49931568.6000709@pelagic.nl>
References: <34467.77.61.241.211.1234338327.squirrel@hupie.xs4all.nl> <20090211161346.GD30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJcT-0003Qh-AQ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbZBKSOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbZBKSOD
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:14:03 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:43217 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750945AbZBKSOC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:14:02 -0500
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 1040F58BD88;
	Wed, 11 Feb 2009 19:14:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090211161346.GD30949@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109470>

Shawn O. Pearce wrote:
> "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
>   
>> From 2ad66e099fb35ad9a0d97e553843434b68ec82c9 Mon Sep 17 00:00:00 2001 From: Ferry Huberts <ferry.huberts@pelagic.nl>
>> Date: Wed, 11 Feb 2009 08:29:36 +0100
>> Subject: [PATCH] Make sure that the commit message has Unix format line delimiters
>>
>> Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
>>     
>
> Doesn't this change that I committed yesterday also fix this?
>
>   commit 72cb3bd763f17a7d9894a8443e05965ff5e77157
>   Author: Shawn O. Pearce <spearce@spearce.org>
>   Date:   Tue Feb 10 09:13:06 2009 -0800
>
>     Append Signed-off-by text in the commit message editor
>
>     The user can see and edit the Signed-off-by line in the commit
>     dialog before committing.  Toggling the existing checkbox now
>     updates the message to add or remove the user's Signed-off-by
>     line, displaying the final message.
>
>     Updating the committer name and/or email also updates the
>     Signed-off-by line if it is present.
>
>     For new lines in the commit dialog, use Text.DELIMITER for
>     platform neutrality.
>
>     Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
>     Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
>
> Speaking of which, #@!*#@@!*@!!@@!#*, I amended the commit with
> something yesterday and it whacked Yann Simon off as the author
> of that patch and switch it to me.
>
> Crap.
>
>   
>>  .../egit/ui/internal/actions/CommitAction.java     |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
>> b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java index 5996596..a14011a 100644 ---
>> a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java +++
>> b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java @@ -128,7 +128,7 @@ public void
>> run(IAction act) {
>>  		if (commitDialog.open() != IDialogConstants.OK_ID)
>>  			return;
>>
>> -		String commitMessage = commitDialog.getCommitMessage();
>> +		String commitMessage = commitDialog.getCommitMessage().replaceAll("\n\r|\r\n", "\n");
>>  		amending = commitDialog.isAmending();
>>  		try {
>>  			performCommit(commitDialog, commitMessage);
>>     
>
>   
I'm sorry about that. Appearently I was working with an out of date
repository and plugin.
  I also agree that fixing it in the getter is a better idea.
This was my first patch for egit, looking forward to more. I'll try to
double check better though :-)
