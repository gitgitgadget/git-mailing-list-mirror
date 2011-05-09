From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Tue, 10 May 2011 08:50:10 +1000
Message-ID: <BANLkTikbtGyP5esExySif074OpEoDMdhfg@mail.gmail.com>
References: <20110506172334.GB16576@sigill.intra.peff.net>
	<BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
	<20110509073535.GA5657@sigill.intra.peff.net>
	<BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
	<20110509081219.GB6205@sigill.intra.peff.net>
	<BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
	<20110509104446.GB9060@sigill.intra.peff.net>
	<BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
	<20110509112428.GE9060@sigill.intra.peff.net>
	<BANLkTikQQNoYf=vZwMwAXPu0-S_2s9Y79w@mail.gmail.com>
	<20110509122137.GA10095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 00:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZHP-0007Kf-12
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab1EIWuM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 18:50:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60325 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab1EIWuL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 18:50:11 -0400
Received: by vxi39 with SMTP id 39so6229850vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XSKU0FmxatArzPW6jmWYEx46wcM8hMAikUNjENLBCTc=;
        b=PdZYkJSUZmOpPdEfprFseb91WOrrcQ36YXFq4rxJLWSj4Zf4r7j2XCHfHp5vqY2zjf
         pVB5K1jRJP7qqYxiicylDp3WykaAL6v6dl0eUoVDXygZwoOL7h4gCeBVcMeo/UJpvZ8U
         M8E0DkEXKnLmzZwrjKW/3+4uMr7XvEW/+EKWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gx6+mDDtRUvUkaPhpLBGOO0ERlxqnThs3WGyrXnJGubPXRpFvZDmfXXPevQNXNz3cz
         SBTF+FP/QDocYMX5nhD0YgwDOldTFO5bMFltzj0jBVXEJ4EWMur/pRDkMxq6Hrfxyj6J
         c/5tSUApHsSeaQc32mtZsN4RJPvpPbmYD3UmQ=
Received: by 10.52.94.170 with SMTP id dd10mr567920vdb.159.1304981410310; Mon,
 09 May 2011 15:50:10 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Mon, 9 May 2011 15:50:10 -0700 (PDT)
In-Reply-To: <20110509122137.GA10095@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173280>

On Mon, May 9, 2011 at 10:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2011 at 09:28:26PM +1000, Jon Seymour wrote:
>
>> > Anyway, with respect to "core.preferredPluginPath", if you do want=
 to go
>> > in that direction, I don't think any extra git support is needed. =
You
>> > can already just do "git config --path core.preferredPluginPath" t=
o get
>> > the value (with tilde-expansion, even).
>>
>> I still think it would be useful for the git wrapper to add
>> core.preferredPluginPrefix/bin to the PATH, so that there is no
>> requirement for the user to do this separately via mechanisms that
>> will differ according to platform, shell etc.
>
> Ah, yeah, that probably does make sense.
>
> My original conception was that it would be more like
> "preferredExtensionType" and would be either "user" or "system", from
> which the installer would select either "$HOME/.gitplugins" or "git
> --system-extension-dir" respectively. And I was still thinking in tho=
se
> terms, even though the example you showed was obviously an arbitrary
> path.
>
> If you want to go the arbitrary path route, then yeah, it would need =
to
> be added to git's expansion list.
>
> There is one drawback with that, though. Consider something like this=
:
>
> =C2=A0$ git config core.preferredPluginPrefix /opt/git-plugins
> =C2=A0$ cd git-foo && ./install
> =C2=A0[installs in /opt/git-plugins/git-foo]
> =C2=A0$ git foo ;# works fine
>
> =C2=A0[time passes; now you decide you want to install new plugins in=
 your
> =C2=A0 home directory]
> =C2=A0$ git config core.preferredPluginPrefix $HOME/.gitplugins
> =C2=A0$ cd git-bar && ./install
> =C2=A0[installs in $HOME/.gitplugins]
> =C2=A0$ git bar ;# works fine
> =C2=A0$ git foo ;# now broken!
>
> So there is some value to separating the concept of "these are the pa=
ths
> git looks in" and "this is the path we install into" and enforcing th=
at
> the latter points to one of the former.

=46air point. I'll ponder this some more.

Thanks,

jon.
