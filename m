From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 12:29:06 -0700
Message-ID: <a6b6acf60808111229u72ffad66kb7a253f2fef44654@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <87vdy71i6w.fsf@basil.nowhere.org>
	 <20080811192208.GK26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andi Kleen" <andi@firstfloor.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSd65-0004Xf-PK
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbYHKT3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbYHKT3I
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:29:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:31615 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbYHKT3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:29:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2400691rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=9GAVUPSAwxk8RdpmcU3aZMXCMq4vJE3RFd5lRrs5W2I=;
        b=MMzYTfpNl0VTBGIv7g8T5MNl2gbpFaqVXTiOe7vEiDk7YZ8L5E0Z9GcmdtCWlKv1Sn
         Skm9EHDJtGvvUQr1lM34ndheq8Lb34ycwVV/Fqm4dgDBZMRBpqEyGuv7YSxVxvTHtDzx
         VUvRGIDPCfU2ZM+IGkSm9q3W4sdoz/KXK70Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ST5XNyDIpfumCpXN0ArAXpvN01YUjyi55iKMe4NGD8YpJ6zkfrbqkPJCB3GbBp2CDV
         uaKqm3kfrTF6rkvwxYzVzWK5HuHVHMv1DzZlKhy5jVUEKvvks0bxw68Vz5h91KcbSKgb
         4NRP+3Cr7kZMnxmTcymDPMllzvglNHsaWMXYc=
Received: by 10.141.107.13 with SMTP id j13mr3745163rvm.276.1218482946781;
        Mon, 11 Aug 2008 12:29:06 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Mon, 11 Aug 2008 12:29:06 -0700 (PDT)
In-Reply-To: <20080811192208.GK26363@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 82167101e4f9d8d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91985>

> Looking at /proc/meminfo only works on Linux, and maybe some other
> OSes which support a /proc like design.  But even then we don't
> really know how much we are competing with other active processes
> and how much memory we can use.

Could we create a git config variable to specify the maximumum amoung
memory to mmap? Any if that variable wasn't explicitly set, it would
fall back on looking at /proc/meminfo?
