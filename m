From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Wed, 13 Aug 2008 16:13:28 -0400
Message-ID: <48A34068.9060509@griep.us>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <48A33E70.8060804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMkC-00082A-Ta
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbYHMUNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 16:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbYHMUNf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:13:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:45618 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbYHMUNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:13:33 -0400
Received: by wr-out-0506.google.com with SMTP id 69so143049wri.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=2KrSGX2LR9ylEMsBfgMJ4QlSyDYL0AWprjm6z+9xtNE=;
        b=g7y4vJpbRjs/pwLtCWvHwFiF57nm7olOZI3H0DJER+3/Zj9UM434WF7/gyOsPrLr2T
         C/GckTwcG64OiGahpSF1aL67scH0OShDeMdTFtR/ykj3Jy3CSo4q5E50xzGnxpNaxIuY
         1ANsUTfkgAYA/EJWdphjDSe6eR2p1/vX8oWJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=R0IS+akz4/FYug2H0J2ioa+8Fl9ITB8F4JD8AFtT7BltZbk/VNKB5r45G1ZdIz8J80
         tvDjB+M1uzQqNC9zi5X4EkneGVTMrKNvqvk0GPnW5onj/pzqvsccL/viuULL2rm3vMBu
         pdLsCXLWealgziFwXMs7ncH5DWb1YrEWzptnE=
Received: by 10.90.80.18 with SMTP id d18mr365853agb.44.1218658412784;
        Wed, 13 Aug 2008 13:13:32 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 10sm1305092wrl.11.2008.08.13.13.13.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 13:13:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48A33E70.8060804@gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92263>

Yeesh; didn't realize it would create that heavy of a dependency.  Perh=
aps this should be split into a submodule so that Git.pm doesn't requir=
e the newer dependency.  Eric/Junio?

Lea Wiemann wrote:
> Marcus Griep wrote:
>> diff --git a/perl/Git.pm b/perl/Git.pm
>>
>> +require File::Spec;
>=20
> This makes Git.pm dependent on Perl 5.6.1.  Some tests (like
> t3701-add-interactive.sh) seem to work with pretty much any Perl vers=
ion
> out there, and requiring File::Spec changes this.  Hence to avoid
> complaints about failing tests, I suggest that you add a check for
> File::Spec availability at the beginning of any test that (indirectly=
)
> uses Git.pm.
>=20
> (All my statements are untested... ;-))
>=20
> -- Lea

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
