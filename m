From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked file
Date: Mon, 15 Dec 2008 11:45:50 +0000
Message-ID: <e2b179460812150345i29222edesc64f544a9e4db42c@mail.gmail.com>
References: <20081210201259.GA12928@localhost>
	 <20081215004651.GA16205@localhost>
	 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
	 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
	 <20081215095949.GA7403@localhost>
	 <7vskopwxej.fsf@gitster.siamese.dyndns.org>
	 <e2b179460812150250t6e028330xf0e0ff626c1b6b3c@mail.gmail.com>
	 <alpine.DEB.1.00.0812151206360.30933@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 12:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCBuo-0002Yi-Px
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 12:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbYLOLpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 06:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbYLOLpw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 06:45:52 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:62363 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbYLOLpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 06:45:51 -0500
Received: by qyk4 with SMTP id 4so2591464qyk.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k07WiHaFgd/fSdtFr3AIgbCJ8/S7AeU2tUokEY+WMk4=;
        b=HChUVJXYYRYc3wWQC5BOx/j+LXQ4G4IpNbbZl4yn/PeKrsmxJfNzvWpRFy2ed0KC7s
         tmihFS+jciMg+vInR+6/WhE6Ylntu/RsvOhOsZjmWJVvtaK3OYHuJ3GmDhr7dMpWPbWR
         y/r5fFPPoMytfuWOM01kNZ52YJInFYO2XWoak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qQbkAaTuIlj9OWDrCr1Y88SMNotqLBsZaH8r9yInH1K2yHvAaSr7as5L/0LPIP4pB4
         ICgscG/xgDFrAbIvynhICPZW81BWn6SVGCIZ9RUGk18xv/PS29xQome90di0J/+BwLMl
         O5pM46VoaFljInSScHylbqaoRaFoIj0FaviHQ=
Received: by 10.214.217.3 with SMTP id p3mr7395397qag.166.1229341550092;
        Mon, 15 Dec 2008 03:45:50 -0800 (PST)
Received: by 10.214.150.9 with HTTP; Mon, 15 Dec 2008 03:45:50 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812151206360.30933@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103158>

2008/12/15 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Mon, 15 Dec 2008, Mike Ralphson wrote:
>> I wonder if another approach is workable... to read 'vulnerable'
>> untracked working tree files into a new (temporary, uncommittable) stage
>> in the index, perform whatever merging is required, then reinstate all
>> entries from the new stage.
>
> I think the solution is not in making things more complicated, but
> simpler.  I agree with Junio that the recursive merge needs a major
> rewrite which respects d/f conflicts and renames in the _design_, not as
> an afterthought.

Yes, it might also score low on not surprising the user. I bow to more
experienced heads on matters of clean design and merge strategies.

> Besides, I really do not want untracked files to be inserted into a stage.
> Remember, adding something to the index means to hash it, and I do have
> half-a-gigabyte untracked data in some of my worktrees.

Granted, but here we are only talking about files (or clashing
file-names) which someone [else] has already added/removed/modified in
another branch etc.

Mike
