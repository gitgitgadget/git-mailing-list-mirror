From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Re* [BUG] "git checkout -b" erronously thinks a branch already exists
Date: Mon, 6 Jun 2011 10:26:38 +0200
Message-ID: <201106061026.38996.stefano.lattarini@gmail.com>
References: <201106051305.13723.stefano.lattarini@gmail.com> <7v62ojbuyh.fsf@alter.siamese.dyndns.org> <7v1uz7bkc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 10:27:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTV9N-0007N4-UC
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 10:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1FFI1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 04:27:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60777 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab1FFI07 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 04:26:59 -0400
Received: by wya21 with SMTP id 21so2596581wya.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=QKZSvxEHawzBgoyazksEsfDqUpGBRe/O31EsgUDoAbA=;
        b=W1BGc8werunoZ0DxeuLsgqd+1GLZlYMomUW+lIAJGcVDWKClgSwGC/yCqFC/23r8Xw
         Ez1ObKTybrXHDK3GgeIwKt7w64lAG7mPb+zdIhLfxQ9YSnCQRnoEMofmjtAyHYr+1Nr3
         K06FvIEHGtoA3NFLQPDwSdBZ9FS9psqGa5rlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=RKQhjFii2THPveNZhkhjoSabFvB+iFI2tjPxzc9EIhonve4g3ZjP4TZjUsUQy/CM8F
         /UBUl9qjEE1jkxKq7iruwrU4GVUHDiXX5Y0X/dJwIukc0t3e+HPFaNX6MHOB0zQuT4LN
         NwU/jByux6YVZTR9xuqyXCxqmO3pdk51pk8N8=
Received: by 10.227.208.65 with SMTP id gb1mr4711464wbb.42.1307348818377;
        Mon, 06 Jun 2011 01:26:58 -0700 (PDT)
Received: from bigio.localnet (host194-90-dynamic.14-87-r.retail.telecomitalia.it [87.14.90.194])
        by mx.google.com with ESMTPS id m8sm2688216wbh.28.2011.06.06.01.26.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 01:26:56 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.30-2-686; KDE/4.4.4; i686; ; )
In-Reply-To: <7v1uz7bkc9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175104>

Hello Junio, and thanks for your quick answer.

On Monday 06 June 2011, Junio C wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think the right fix is to make sure that "refs/heads/<name>" does not
> > exist by checking exactly that.
> >
> > Perhaps something like this.  I am not sure if we want to use the "yield
> > non zero to signal not an error but an early return" trick like I did in
> > this patch, though.
> 
> Let's do this instead. I don't know what I was thinking when I wrote that
> inefficient "loop refs to see if there is that one" patch.
> 
> [CUT PATCH]
>
I can confirm this change fixes the problem for me.

Thanks,
  Stefano
