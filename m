From: Elijah Newren <newren@gmail.com>
Subject: Re: Configurable callbacks for missing objects (we Re: upload-pack: 
	support subtree packing)
Date: Tue, 27 Jul 2010 19:53:59 -0600
Message-ID: <AANLkTimrp4z0n75Zq7BtTvdWz6nzK3M4J9ohdbE6X3t3@mail.gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
	<1280187370-23675-2-git-send-email-pclouds@gmail.com>
	<20100727144605.GA25268@spearce.org>
	<20100727185127.GD25124@worldvisions.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 03:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odvqc-0007Q4-3V
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab0G1ByM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 21:54:12 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61190 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0G1ByJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 21:54:09 -0400
Received: by qyk8 with SMTP id 8so3145463qyk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eIJCRpXF7/fhqa1R+OByF0rGe+/ECD/QMxxu4124Xrc=;
        b=Vaxugi8FypE4okIBbguIEkG+qa+PdCuIq8DdyY4sVSagCsFQ79/kqvkA9b8atuET05
         DZHjyqOIHGgRbP3c41EpVt7AzYnz8Wa5huX3KzTuYZprTuneWaN5XbJJYcsvGjdu3tqS
         7Sgi1ODcvXCroSGxDY2vfNSp1EKTEnyPqLkMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x9fTC4F/PCuCRGpbBciYKOnqmtoOb98fHqtnly8CzfwCqmX0/Pa5zvyLR+XfIJV8IP
         wrgfl+yoIstn/W583toFwGjBHsmhCzAieJpw7us4g+pv3aq/R3lFNgzQSsCXggj4WNHP
         GzBDiKZiilM9obQ80D4Wz6i/qNDj7ao+qLdqM=
Received: by 10.220.187.5 with SMTP id cu5mr3634350vcb.0.1280282039347; Tue, 
	27 Jul 2010 18:53:59 -0700 (PDT)
Received: by 10.220.97.15 with HTTP; Tue, 27 Jul 2010 18:53:59 -0700 (PDT)
In-Reply-To: <20100727185127.GD25124@worldvisions.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152029>

2010/7/27 Avery Pennarun <apenwarr@gmail.com>:
> But I've been thinking that a really elegant way to solve the problem=
 could
> be to have a user-configurable "get the missing objects" callback. =C2=
=A0If any
> part of git that *needs* an object can't find it, it calls this callb=
ack to
> go try to retrieve it (either just that one object, or it can request=
 to
> download the object recursively, ie. everything it points to).
>
> Then shallow clones could just auto-fill themselves if you really nee=
d a
> prior version, for example.

What counts as "needing" an object?  Does 'git log -Sfoo' or 'git log
--stat' need all missing blobs?  I'd personally dislike having such
commands automatically result in huge downloads, but I'd probably
dislike the automatic downloading in general so perhaps I'm just a
misfit for the lazy clone usecase.  It's still an interesting question
though -- what counts as needed?
