From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sun, 7 Dec 2008 19:27:00 +0700
Message-ID: <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
	 <20081128192033.GF23984@spearce.org>
	 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
	 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
	 <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
	 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
	 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
	 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 13:28:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9IkO-0001pz-Lh
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 13:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYLGM1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 07:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYLGM1E
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 07:27:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:26493 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbYLGM1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 07:27:02 -0500
Received: by fg-out-1718.google.com with SMTP id 19so620077fgg.17
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ybmNWiVYkDl56YBReeFq4iOwE/TtE7A506ZKCW1+z34=;
        b=ee7c13RrCK3IXF0KbFLtZDn6xRUox+6OjQm3T2QXs7B/mwu4oXkoQpsUGkeidZycml
         s9OMgejoU2om8lrdYjYj9c0p2an+5aEuyme7smZU/tWuMtu+mwyz1Izb5Ov9vgfStDD9
         IXxg0X110GCTkrYAtl7Az7WjULVa4K5SjnQsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TdPdHggXLMErJiIijNjHe8TA1QyyNZPAaOWhf4Vs2jSdgkiHHg23+idJ4dVYF8ifQA
         tcgv8x+yYWgeJbUxGZpM0Bhap0Ye6QUQmaWTwwvrVHXyvnlX5N0z1fxqengBWai962hQ
         j7yq/cRPankRR+s31OBY2QYT/iRsQca2RnDY4=
Received: by 10.86.80.17 with SMTP id d17mr1911714fgb.55.1228652820378;
        Sun, 07 Dec 2008 04:27:00 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Sun, 7 Dec 2008 04:27:00 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102498>

On 12/7/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  > There is not much work for CE_NO_CHECKOUT on plumbling level except
>  > some fixes. The last half of the series, for porcelain level, you will
>  > see more.
>
>
> For the porcelain level, do we need the difference to be in the index? If
>  the porcelain knows the sparse checkout area and can instruct the plumbing
>  appropriately, the information shouldn't need to be stored in the index

This was discussed since the beginning of this feature. I recall that
the index reflects worktree, and because we mark CE_NO_CHECKOUT on
file basis, it's best to save the information there, not separately.
We do save high level information to form the checkout area (sparse
patterns) in the last half, but basically you should be able to live
without that.

>  unless it's ever important to remember whether an entry is CE_VALID due to
>  having been outside the checkout when the index was written, even though
>  the checkout area now includes it. I don't have a good intuition as to
>  what ought to happen if the user manually changes what's specified for
>  checkout without actually updating the index and working tree.

So if a user changes worktree without updating index, they will have
the same results as they do now: files are shown as modified if they
don't have CE_NO_CHECKOUT set. If those files do, they are considered
'orphaned' or staled and are recommended to be removed/updated to
avoid unexpected consequences (not availble this this first half
series because that belongs to "git status").
-- 
Duy
