From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Configurable callbacks for missing objects (we Re: upload-pack: 
	support subtree packing)
Date: Tue, 27 Jul 2010 22:00:28 -0400
Message-ID: <AANLkTinDvmQhPH3QtcJTD3mCuCvSjG-pmfu63f9K7Dsb@mail.gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com> 
	<1280187370-23675-2-git-send-email-pclouds@gmail.com> <20100727144605.GA25268@spearce.org> 
	<20100727185127.GD25124@worldvisions.ca> <AANLkTimrp4z0n75Zq7BtTvdWz6nzK3M4J9ohdbE6X3t3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 04:01:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdvxA-0000tP-9s
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 04:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab0G1CAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 22:00:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55428 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0G1CAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 22:00:49 -0400
Received: by wwj40 with SMTP id 40so1931581wwj.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=k5E66XAluyhTgygBBjmWzd/NtIOYvy3JC3awzbC7/iE=;
        b=E3IcWrrWzLbTDMYW89j+D1wqx85ZyavZUnZc0H0/3l7UkOofg4gVVoiFeNR/YBzJ/N
         Ijxy6LkUqnNHCPMKWbwqOK0gnCv/aQVca2NoNctkWhP5gL2BE2J8rCcEfnajoPkUBLdW
         BqK3/ys8WIc5/zU+4zUe/JbPSEHjrBTMV8tlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oydmNlVVsSYiTrVHypRhbFOeS7ETXlGb2Ag8YbsMnw0mOaREiw/5v4GdKF4awoyFbR
         ldZbNyt3p5OIjeZkAoCIx6zS/mTxgH7q2dopm2AQkQ42/RqGqRZao+gFTT20eN7MWgxz
         npsC9VkbArsxkgqQGQanfMHwuOzIaw6N+pYw8=
Received: by 10.227.138.7 with SMTP id y7mr9784475wbt.133.1280282448194; Tue, 
	27 Jul 2010 19:00:48 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 19:00:28 -0700 (PDT)
In-Reply-To: <AANLkTimrp4z0n75Zq7BtTvdWz6nzK3M4J9ohdbE6X3t3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152030>

2010/7/27 Elijah Newren <newren@gmail.com>:
> 2010/7/27 Avery Pennarun <apenwarr@gmail.com>:
>> But I've been thinking that a really elegant way to solve the proble=
m could
>> be to have a user-configurable "get the missing objects" callback. =A0=
If any
>> part of git that *needs* an object can't find it, it calls this call=
back to
>> go try to retrieve it (either just that one object, or it can reques=
t to
>> download the object recursively, ie. everything it points to).
>>
>> Then shallow clones could just auto-fill themselves if you really ne=
ed a
>> prior version, for example.
>
> What counts as "needing" an object? =A0Does 'git log -Sfoo' or 'git l=
og
> --stat' need all missing blobs? =A0I'd personally dislike having such
> commands automatically result in huge downloads, but I'd probably
> dislike the automatic downloading in general so perhaps I'm just a
> misfit for the lazy clone usecase. =A0It's still an interesting quest=
ion
> though -- what counts as needed?

I would say no by default (unless maybe a config option is set) but
you'd want to be able to force it on for a particular command.

Have fun,

Avery
