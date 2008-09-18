From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Thu, 18 Sep 2008 15:12:23 +0400
Message-ID: <bb6f213e0809180412o4559ef95jfba29aa540afa06f@mail.gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	 <18641.31356.147503.708394@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 13:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgHSu-00038z-1Q
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 13:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYIRLM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 07:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbYIRLM0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 07:12:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:24724 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYIRLMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 07:12:25 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1614799eyi.37
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IGf2dGPNO8mFLYpSyIDhn6rrkLZTgSXlnuA02Mdew/g=;
        b=jq2PTWovYFai51xkAdizF3yIVtpNWKzfvCQGYvucW/MAcNuFi1aFTN4XHe+t3OdKfv
         ZaHc2IxOt+A9ImMms3LzIvXtZIQYIa94f/R+IxL/ZmqHjfSX4av4Du0FE5T+qpCMmQbm
         LEpbBPSXASAz1SF3avDTaK339xw2D8I/t/R+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N6PcqQZa0Yzm8lfsaMtsLhPR0Kr+EYjEfLQYJpGu7w5vbD7tgziWzBEJQlijxnDAFm
         KvviVB05+0yXU8+I1j0vOJIIjqPVNsabqUdL0pXZrf4MDndWiARiLLXxepUozHWENz4b
         VUtD67lpwwkCcDG2h8pcnsyfGYLBJ/UPY/D+Y=
Received: by 10.102.228.2 with SMTP id a2mr2775366muh.79.1221736343851;
        Thu, 18 Sep 2008 04:12:23 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 18 Sep 2008 04:12:23 -0700 (PDT)
In-Reply-To: <18641.31356.147503.708394@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96191>

On Thu, Sep 18, 2008 at 1:45 AM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>> Currently GUI tools don't provide any support for
>> viewing files that contain non-ASCII characters.
>
> Well, that's just not true, at least as far as gitk is concerned.

Somehow being able to show files in the system encoding is not good
enough for a tool that is supposed to be used for cross-platform
projects. It is only marginally better than always using ISO-8859-1,
as git-gui, in effect, did.

> If you feel there are deficiencies in how gitk handles encodings (and
> I'm quite willing to believe there are, since ASCII is sufficient for
> my needs), then please give us a detailed explanation of what you
> would like it to do or specifically what is wrong with what it does at
> the moment.  I'd like to see several paragraphs, not just the one or
> two sentences you have put in the descriptions for patches 6-8.

I did not combine this set of patches into a single group without a
reason. This is a policy decision that spans the boundary of
individual tools, although it is initially implemented and documented
on the git-gui side. The gitk commits simply bring back changes to
code originally copied from gitk, tie in new logic that supports
per-file encoding, and fix some obvious breakage (of course, I can
write longer descriptions for them). By the way, patch 4 will apply to
gitk, if you replace 'lib/encoding.tcl' with 'gitk', and specify -C2.

P.S. All changes are build on top of these two commits:
http://repo.or.cz/w/git-gui.git?a=log;h=refs/heads/pu

Alexander
