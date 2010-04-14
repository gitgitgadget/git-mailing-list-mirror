From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 23:42:06 +0200
Message-ID: <201004142342.06873.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004142110.36453.jnareb@gmail.com> <m2xfabb9a1e1004141213t7d4f084bk72a3b72544e11542@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2AL5-00039W-UT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980Ab0DNVlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 17:41:35 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38641 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775Ab0DNVle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:41:34 -0400
Received: by bwz1 with SMTP id 1so1009883bwz.2
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a6XVISoOo8XEsD9N82DmwfK+yMMuMk/HuDXAB+efH4w=;
        b=x/J7Z6XuKaKxRaGb3CCD8ohief16HkSs0tBdscV4w6SDEzz8zGvfpJ5UJtO2w1qIql
         tydMTYGkpz7vs9G7vE5DcesnSCeXLHAixRVkEea0/E9bj6qDgdh2RplMd011pkUpTCI4
         Cz8AHLj8fZ9T0KeD2VNKXH5QI0ngjLSSqOEmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QBOkc43hBEZ18/L+O59Xvor205ILLL2dMfRGf3iBj/xwKRcsEoLy2tU2WTnS4kvJVr
         CMB3KTvxeS//wJ9LWwV9xv9NwfTla7ihFxVip6JA9tF5ZjrSRUCHQXHEJGORlR3R1tOY
         pwvz3QoLGH467QAtKMmaQZj2QhdDkoEXDnu68=
Received: by 10.103.135.25 with SMTP id m25mr4613365mun.32.1271281292367;
        Wed, 14 Apr 2010 14:41:32 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id e10sm4587282muf.38.2010.04.14.14.41.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 14:41:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <m2xfabb9a1e1004141213t7d4f084bk72a3b72544e11542@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144922>

Dnia =C5=9Broda 14. kwietnia 2010 21:13, Sverre Rabbelier napisa=C5=82:
> Heya,
>=20
> On Wed, Apr 14, 2010 at 21:10, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> > I don't think it is needed for either command.
>=20
> Those were just the first two plumbing commands that came to mind tha=
t
> I use myself, do you have any suggestions for others that would be
> more appropriate?

"git config [<type>] --get <name>" and friends... especially that even
in the case of '{ name: "<name>"; value: <value> }' (and without e.g.
"type: <type>" field) we can have <value> of correct JSON type.

"git ls-files" (especially when mixing information about files in
working area and those in index), "git diff-tree" (especially for merge=
s,
as ordinary columnar output do not include all possible information,
like pre-image filename in case of renames), perhaps "git branch" so
people stop trying to parse it in scripts, perhaps "git describe"
(you need "git describe --long" to unambiguously parse its output),
perhaps "git remote show" (I am not sure about this case), "git show-re=
f"
if "git for-each-ref" didn't exists...

--=20
Jakub Narebski
Poland
