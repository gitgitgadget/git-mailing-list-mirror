From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Sat, 24 Sep 2011 22:35:26 +0100
Message-ID: <20110924223526.02ca9edf@fenix.utopia.dhis.org>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com>
 <20110924193733.GB10955@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 23:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7a0O-0007tv-Cy
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 23:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab1IXVfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 17:35:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62152 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab1IXVfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 17:35:36 -0400
Received: by wwf22 with SMTP id 22so5094759wwf.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=p0rT2l+VzeIHVFbladp2Eujk1cjsInqOAPlhEZzcc8k=;
        b=TDaScQ3rTX7S5940m3TN/bF1+4iUSu3itM9I/3N2k3UxxhKmzebhfRIOE4g1t7/srV
         DbphlYzmlVAJoC8oRmTDrbAHXr1SaeogOm+dvzZa83+xRYQwSoQ/Fy+SiHinWLUozG+s
         FS5Cu9U1RlUMXVqcKcYxjND+Jn4eLxULwYdC8=
Received: by 10.216.19.75 with SMTP id m53mr6571052wem.73.1316900134972;
        Sat, 24 Sep 2011 14:35:34 -0700 (PDT)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id en20sm22990347wbb.20.2011.09.24.14.35.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 14:35:34 -0700 (PDT)
In-Reply-To: <20110924193733.GB10955@elie>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.6; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182045>

On Sep 24, 2011 8:37 PM, "Jonathan Nieder" <jrnieder@gmail.com> wrote:
> Thanks.  I must have missed the earlier discussion.  What are the
> semantics of this command and its intended purpose?  For example, what
> happens if the branch already existed or if there is a checkpoint
> (perhaps triggered by the impatient user sending SIGUSR1 to
> fast-import) before the "drop" command is processed?

In the tests I made there are checkpoints triggered before using the
command. I tried to remove the branch within fast-import variables as well
as the already processed objects in git.

This command is required because I need to reset a given branch multiple
times in order to be able to "guess" its origin commit in the parent branch.
To make this analysis I also need to use "checkpoint" at each try.

(Resending... apparently gmail Android app sends a HTML attachment)
