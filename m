From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
	lengths)
Date: Fri, 13 Mar 2009 10:53:24 +0000
Message-ID: <e2b179460903130353p1d3c1cb2n8286c2a284724156@mail.gmail.com>
References: <49B5AF67.6050508@gmail.com>
	 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
	 <49B5F0BA.3070806@gmail.com>
	 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
	 <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
	 <7vsklihsti.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li52o-0001Jx-Fc
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175AbZCMKxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757735AbZCMKxa
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:53:30 -0400
Received: from mail-qy0-f122.google.com ([209.85.221.122]:58432 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZCMKx3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 06:53:29 -0400
Received: by qyk28 with SMTP id 28so2857755qyk.33
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NdsEFakscni4gCqgqqTb/XW3RVsUt4kDRVkWUvGbH28=;
        b=QHONT2tJ0Q3dSxYhxdTQF+/quK/VwiEjkmhSBk7IeqApzRPd4+31jLTk6tN1P6bPLa
         22t6SkG/GLBlfB4tslK+OeX8E/kwd8uliYL7dNFCCIb0frn2mLdiCOCkb9u/EZu0m/40
         0AOOfJGdjSeMB7f+yJ9yiAGMvVpkOCTNGRH8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oBOm+IW+1L2Aamdrzv2WWMXa8OptZtGDjbFril4MEhRLzI0FNeC+gu/XlJI9S0AcJ0
         l0ZyaUSrlb5eDt0envnKMJBZZHXf/RScA0Z3e7LlPJrPI8xJ670zpgw946SDFmbUCe+e
         g66zMvZC3bQhSwyxRotbdom40XqBWBUA3MXCc=
Received: by 10.224.89.82 with SMTP id d18mr1661702qam.134.1236941604713; Fri, 
	13 Mar 2009 03:53:24 -0700 (PDT)
In-Reply-To: <7vsklihsti.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113170>

2009/3/13 Junio C Hamano <gitster@pobox.com>:
> Yeah, I did this as "How about doing it this way without adding a ban=
d-aid
> configuration options" demonstration, and meant to clean it up (rathe=
r,
> meant to wait for the original submitter to clean-up) before moving i=
t
> forward, but I forgot. =C2=A0Sorry about that.
>
> How does this look?

This patch fixes the build breakage for me, thanks. If I can find a
combination of AIX + working gcc + correct 32bit / non-broken 64bit
libraries + necessary Gnu tools + ancient curl + Apache2 in this maze
of twisty turny servers (all different) I'll give the http server
tests a whirl too.

2009/3/13 Daniel Stenberg <daniel@haxx.se>:
>Driven by use cases such as this, I also recently produced the
>"symbols-in-versions" document in the libcurl tree which should
> help apps to know what should works when:

> http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-versions?rev=
=3DHEAD&content-type=3Dtext/vnd.viewcvs-markup

Very helpful, thanks.

Junio, if I check all the unprotected CURL* options against this list,
would that give us our absolute minimum supported version? If so,
would it then be ok to remove any unnecessary ifdefs for lower
versions if they exist?

Mike
