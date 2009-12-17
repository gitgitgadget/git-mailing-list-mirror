From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: link to toggle 'no merges' option
Date: Thu, 17 Dec 2009 22:14:25 +0100
Message-ID: <200912172214.27001.jnareb@gmail.com>
References: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com> <200912171637.45810.jnareb@gmail.com> <cb7bb73a0912171241j56ecd2f1y3dc66cf3b86bd784@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 22:14:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLNgL-0004un-2P
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 22:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765250AbZLQVOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 16:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764580AbZLQVOe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 16:14:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:56783 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbZLQVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 16:14:32 -0500
Received: by fg-out-1718.google.com with SMTP id 22so908479fge.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 13:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yN3bbKmwglCP8uT9vEFXpMpF5y11wJSoBomgki/B/SE=;
        b=jczGgtF+Ll0SJOfxxMGFZvnx7ravL7iRVIw9RapnoSOsl58PyXGSTnRyBxB32U3JH5
         hjFepEbceZq3UJnXqTCv2xGHX3H9I+ePxssWLjtPVsgzb9znWp44EaLRyqNWItmGda73
         iBpas93SD6BVYIXNPGMDHhipmv080bLeBs1KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BBih+wlvbUS1owhcpmS88hj56O6SRVx1n+t2Z+T4cmMZaeIfVam2F/pA8AH1ltm8CU
         dE73wFD1zSyTWKei11JhCQr2sHl1GNQ/IZIBdMKz/3+OPrXG1Tr0GrWB9l+jbr7/ECP8
         DqlkCcw8r6tbEeFV/0/shcwbZK1sNnG/iOSvo=
Received: by 10.87.76.8 with SMTP id d8mr3881803fgl.66.1261084470231;
        Thu, 17 Dec 2009 13:14:30 -0800 (PST)
Received: from ?192.168.1.13? (abvp4.neoplus.adsl.tpnet.pl [83.8.213.4])
        by mx.google.com with ESMTPS id l12sm5993440fgb.10.2009.12.17.13.14.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 13:14:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0912171241j56ecd2f1y3dc66cf3b86bd784@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135383>

Giuseppe Bilotta wrote:
> 2009/12/17 Jakub Narebski <jnareb@gmail.com>:
>> On Thu, 17 Dec 2009 10:05 +0100, Giuseppe Bilotta wrote:

[...]
>>> + =A0 =A0 my $can_have_merges =3D grep(/^$action$/, @{$allowed_opti=
ons{'--no-merges'}});
>>> + =A0 =A0 my $has_merges =3D !grep(/^--no-merges$/, @extra_options)=
;
>>> +
>>
>> Wouldn't it be better to use straight
>>
>> =A0+ =A0 =A0 =A0my $no_merges =3D grep(/^--no-merges$/, @extra_optio=
ns);
>>
>> Because $has_merges is true also for example for 'tree' view... whic=
h
>> absolutely doesn't make any sense whatsoever.
>=20
> The reason why I have two vars is that one checks if we care about th=
e
> option, and the other is to see if it's enabled or not. We don't want
> the 'show merges' toggle to appear in view which don't handle the
> --no-merge option.

Perhaps I didn't made myself clear.

What I wanted to ask is to switch $has_merges to $no_merges, not to rem=
ove
$can_have_merges.  Its a question of semantics of $has_merges, which do=
 not
mean that action has (handles) merges.

This is of course the question of style, but I think this would make co=
de
more maintainable.


Of course if you go %extra_options hash route this issue wouldn't matte=
r.

--=20
Jakub Narebski
Poland
