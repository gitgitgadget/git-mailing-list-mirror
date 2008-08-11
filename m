From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 11:40:35 -0400
Message-ID: <32541b130808110840p1287426fpeef967a9ff4fb094@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <20080811150150.GC26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ken Pratt" <ken@kenpratt.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZcY-0004HS-Sp
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYHKPqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbYHKPqo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:46:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:16375 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYHKPqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:46:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so726590yxm.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xWid4md/TnKR2ykhZN47eQzbf000qYpTLSpYoZygwO4=;
        b=OVmFeCZU4bEZr35iCfsJJ42nTMi2lS+vbjoSqZ7eOTHT8+jiFaI7FzvOXVTzJx2Unf
         /ciDiXizDSx3h3PjM4gTPyg+wByBnBJ9d+X4r/w4YdR2ruY4VCyNbdv/r/gqNtVZhLQl
         4dmRaVr9d5pwxpCRtDzpEtgXKvDJPBoVQzZVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Suhm1Rb/a25lwj8JglmFEbRhb+JDW0IWQa0tQBvfmBMOYL+Jn56JfrC3cqvEIDqtSp
         hdTKvZHz3wAJ9mzAd6sD+yX1vV1K8U1+l5sSwdlpb5u/VUQ0ipMumFZ9PQYNd07QX14C
         H5V1lmIJSMQIkE0lZ8dRav22d5err/LfzYE+A=
Received: by 10.151.144.15 with SMTP id w15mr12439832ybn.200.1218469235746;
        Mon, 11 Aug 2008 08:40:35 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 11 Aug 2008 08:40:35 -0700 (PDT)
In-Reply-To: <20080811150150.GC26363@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91948>

On Mon, Aug 11, 2008 at 11:01 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> On the up side, packing should only be consuming huge memory like
> this when it needs to move loose objects into a pack file.  I think
> Martin Langhoff suggested packing this on your laptop then using
> rsync over SSH to copy the pack file and .idx file to the server, so
> the server didn't have to spend time figuring out the deltas itself.

Do you need to also introduce a ".keep" file to get the benefit from
this?  I had a repo with some very large objects, and it was killing
my low-memory server *every* time I did "git gc", until I repacked on
another system, created the .keep file, and rsynced it back.  Does
that make sense?

Thanks,

Avery
