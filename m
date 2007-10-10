From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 19:01:48 -0300
Message-ID: <f329bf540710101501q7f7297ebqd6365a51775d17d3@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
	 <20071010213925.GB2963@fieldses.org>
	 <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
	 <f329bf540710101449oad9c9dg85f3821f55fb85ea@mail.gmail.com>
	 <20071010215317.GC2963@fieldses.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 00:02:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifjcv-0006on-Iu
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 00:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbXJJWBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 18:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbXJJWBv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 18:01:51 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:55905 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXJJWBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 18:01:50 -0400
Received: by py-out-1112.google.com with SMTP id u77so647575pyb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=82FQcGJRgO56cHOSmPw52J+VFM7I6D2hz8KapIkeiIo=;
        b=kioR+yT0vAnERCGpnDAW/ZAYiKSQnmc2Y0iZM5VLRw/Hv6g2sKQgCUrv4YNPyseYgp8cfr2AyYwOyFmQ4Jb+ZISNLeFLF1C7aV3zApViS0mOt1Yn1JDk3oiFodl03gBxdSB8vQFHD5H8+NEB6gxdzDze3tRsb/XubjgeMJLYywk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ON/nHtbtWKgX2sRfDb30Ho3Ini04eklxP0NpqPEtT0gjB1QD5av8hWeAnmeFe0i13twN+n7VJSLcWskZyFPzfMbkVQqwficvslv9hi3H7QAnSO9RMxNd5rYl81FfccC0rglZzxrrXOXg7bIUzGzuTC718e2WsVEF4TTdEQDNYMg=
Received: by 10.64.203.4 with SMTP id a4mr1749668qbg.1192053708882;
        Wed, 10 Oct 2007 15:01:48 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 15:01:48 -0700 (PDT)
In-Reply-To: <20071010215317.GC2963@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60559>

2007/10/10, J. Bruce Fields <bfields@fieldses.org>:
> > Maybe gc --prune could follow the alternates and abort if a cycle was detected?
>
> Don't the alternates point in the wrong direction?  You'd need pointers
> back from the main repository to the repositories that depend on it for
> objects.
>
> Which would be nice....

The development repo was cloned from the main repo; then sometimes I
cherry pick from development into the main repo. Hence alternates in 2
directions.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
