From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] Add a sample user for the svndump library
Date: Thu, 24 Jun 2010 15:52:56 -0500
Message-ID: <20100624205256.GA2307@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624110752.GI12376@burratino>
 <AANLkTinnB_TRYa0nzJHHqbHuJk9a7tfk8mAhr95Sc98E@mail.gmail.com>
 <20100624203041.GA2262@burratino>
 <AANLkTinSbQbT1tmKIiWnZnX52mJEZOlf9xCV1ENUGFT_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:53:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtQC-0005B0-8X
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab0FXUxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:53:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44174 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0FXUxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:53:09 -0400
Received: by pxi8 with SMTP id 8so385612pxi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1qdA9LtnAMCPPcVymwpcSyouORaTB1V/fWaCeNhsmww=;
        b=uAx08D4Xb1UGLC7eig98Z5hE9HxpBxwfQ6ujM2Gafn22gxKNpN/Ak3lHzWVGbly3FX
         pKXDIvr8Jmyv6SCe9CNTg9NASuyD8xsNwvee0q76zA4o5AB1tgLeX6wxx6KJ33wGH1iE
         yWkzNRV78Yq7c7x2NGEQmui/lU311LQfjS7NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gG7wtR7DitBhuuF04z9mno2tc/n1C5BmKDKyQ0aw3NcldCBOJG42vepwB7LIkFgYaR
         X+xCqtZJdO0qSVSGK/G80VfqlennpW1EcFc55ya1YgVoBImr8+ZhhSukIU9DW9duatOs
         /KjkiIpK9Z8zJrFyK4nyEqMDyNbjm4mE7BvGo=
Received: by 10.115.101.31 with SMTP id d31mr10283153wam.151.1277412788677;
        Thu, 24 Jun 2010 13:53:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm19812268ibg.3.2010.06.24.13.53.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:53:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinSbQbT1tmKIiWnZnX52mJEZOlf9xCV1ENUGFT_@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149648>

Ramkumar Ramachandra wrote:

> Unfortunately, turning off persistence isn't so easy now

Hmm, couldn=E2=80=99t one just leave out some pool_init() calls?

Of course, that would make pool_init() and related functionality unused=
,
and we may or may not want to remove it while at it.

> Yes, the remote helper can use the .git directory, but I thought we
> wanted to keep this in contrib/ even after the remote helper is
> merged?

=46or incremental imports, I suspect the standalone svn-fe is going to
need to invoke =E2=80=98git fast-import=E2=80=99 itself, which implies =
knowledge of
the location of the .git directory.

=46or undeltified nonincremental imports, there is no problem. :)

> Jonathan Nieder wrote:

>> Maybe the file should get a simpler license? =C2=A0e.g.:
>>
>> =C2=A0This file is in the public domain.
>> =C2=A0You may freely use, modify, distribute, and relicense it.
>
> Yes, I like this.

David, would this be okay? (for the short svn-fe.c file only)

>> Do version 3 dumpfiles fail?
>
> Yes, they do. We aren't parsing the extra headers anywhere, and
> deltified dumps aren't supported.

Worth documenting indeed.

Thanks again.
