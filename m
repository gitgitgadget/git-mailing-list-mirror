From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'commit -a' safety
Date: Sun, 25 Apr 2010 01:47:14 +0200
Message-ID: <201004250147.16197.jnareb@gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com> <20100424164247.GM3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 25 01:47:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5p4M-0002vr-Jc
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 01:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab0DXXrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 19:47:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:19405 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab0DXXrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 19:47:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1628501fga.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nxGyVUTnsCtFlC1Walbh3wO4ylJZZfDKf2/1xkbCSEY=;
        b=U7AAfW2VlVgEF+9H9L+wraAHC4iIjak3AurSPyn1Ojnly6k2jJVIIfhWC9Bz8+QAAS
         DJI1SqA6OnKH3hdam3W5bsve5bAhK1p9iUDnMNB8X4XUX5eh26jIBAcyoexmFmGW5GrP
         Texk9fhLlVpF+T+hyL1HCEOHqWHN7QvlP/yX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=c1Q2oM0VOC6/fa6WLd5tGOGJLGyk79crSRgcKfu4h9e+QyWvL4zk/NglYRtQ8EQzpf
         iNnp91CKQifoVzVbo32p2x9J2KqMe/UG4F/YD2GU6XQsIw15sRLDWxtW1bqyuQHHZqNo
         UoNJ9Mer/xLAPa5zzpz8mw1t/ZWMbRPzOB5bw=
Received: by 10.86.239.11 with SMTP id m11mr3312690fgh.22.1272152842304;
        Sat, 24 Apr 2010 16:47:22 -0700 (PDT)
Received: from [192.168.1.13] (abvs189.neoplus.adsl.tpnet.pl [83.8.216.189])
        by mx.google.com with ESMTPS id 3sm1336290fge.25.2010.04.24.16.47.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 16:47:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100424164247.GM3563@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145711>

Dnia sobota 24. kwietnia 2010 18:42, Petr Baudis napisa=B3:
> On Sat, Apr 24, 2010 at 01:10:24PM +0200, Wincent Colaiuta wrote:
>> El 24/04/2010, a las 11:40, Jakub Narebski escribi=F3:
>>>
>>> I'd like for 'git commit -a' to *fail* if there are staged changes =
for
>>> tracked files, excluding added, removed and renamed files.
>=20
> Thanks for this suggestion, this is exactly what I wanted to propose!
> +1 here.
>=20
> I think this could even be made a default in some time, I don't see a=
ny
> useful workflows this could prevent and adding -f is trivial enough f=
or
> those who really want to go forward.

Isn't it how (most of) backwards incompatibile changes are made, first
adding an option for new behaviour, then later (optionally) changing
the default?
=20
>> For me this is going to far. While we don't want to make it _easy_
>> for users to shoot themselves in the foot, neither do we want to mak=
e
>> it difficult or impossible for them to get the tool to do things tha=
t
>> _might_ be a mistake. And what's the risk here? Accidentally
>> committing too much is not a destructive change, and can be easily
>> undone.    =20
>=20
> Have you ever done this mistake? If you have done some extensive inde=
x
> editing, it is actually a major PITA to restore, and can be even
> destructive if your index and working tree are too much out-of-sync
> (this does happen to me not so seldom while I also use -a a lot for
> trivial commits).

That is the situation this *optional* safety is meant to protect agains=
t:
when somebody sometimes use "git add" + "git commit", but sometimes
use "git commit -a", to protect carefully index against accidental
"git commit -a" instead of "git commit".

Is it worth additional code complication?  Shoult it be turned on by
default?  Does it promote unsafe workflow of committing untested change=
s?
=20
>> IMO, the fact that the commit message editor is populated with
>> a list of changed files that will be included in the commit is enoug=
h
>> for people to see what's actually going to happen. =20
>=20
> BTW, I almost always use -m instead of the commit editor. ;-)

So restructuring commit message template so the information is more
visible in the case of accidental "git commit -a" wouldn't always help.=
=2E.

--=20
Jakub Narebski
Poland
