From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 20:29:04 +0700
Message-ID: <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
	 <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807231753240.8986@racer>
	 <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
	 <alpine.DEB.1.00.0807241340490.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM0tW-0004F1-MC
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 15:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYGXN3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 09:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYGXN3I
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 09:29:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:10555 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYGXN3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 09:29:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1400099fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=X5wI4951Yd+gSdoE/xsZhQvamD8stI8mDuJBlZz1s9s=;
        b=MpI/FUcW/hFON4kRKQuuIaAr9JZwSGnegWUAIPegTUVs5vYY7E0hNKZoRfEJ4wFSN6
         vBCYkgFhngoHhE60VinGTyayCJcYKByjrJU7P08xlH97mSBQO/x33riq905PSe95g5/9
         aRq0xWwSMChFpIDEDmg/RvmuIcYU7IfSnbZeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KaW/RODL6zW1fmokbIvdkg9jWr9KhwrzQARp+1kLc743ybM8uYurfE5jbZcDyHhrkX
         EzCbZbYi+H2PsjyvhYSsBnPHT0xOuOoMj4q0c7qZksuvP+4yVp7gHJ2hfcKvhRmolcnn
         iAyFNgfOOiRAmV/UvgczW9nXvCF1cON1FQBoo=
Received: by 10.86.80.5 with SMTP id d5mr882492fgb.11.1216906144076;
        Thu, 24 Jul 2008 06:29:04 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 06:29:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807241340490.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89879>

Hi,

On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > > No, I did mean the index.  This is an attribute of the index: either
>  > > it is sparsely checked out or not.  You can even have multiple indices
>  > > (switching between them by setting GIT_INDEX_FILE) which have
>  > > different prefixes.
>  >
>  > I don't think so. It's a mask for workdir, right? If you save it it
>  > index, you can switch index and the prefix as well, but workdir only has
>  > several subtrees that do not fit any other prefix than the original
>  > prefix.
>
>
> Ah, you adroitly avoided addressing the issue that the user can change the
>  prefix without the index ever noticing.

Forgive my ignorance. I still do not get why index must notice prefix
change? The only reason I can think of is that we must make sure there
won't be any user-modification in index outside the prefix. But that
can be guarded from higher level (plumbings and porcelains) because
index is allowed to have modification outside sparse prefix
(auto-merged entries).
-- 
Duy
