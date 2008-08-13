From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Wed, 13 Aug 2008 16:31:15 -0400
Message-ID: <48A34493.2000307@gmail.com>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <48A33E70.8060804@gmail.com> <48A34068.9060509@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTN15-0006q7-UK
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYHMUbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 16:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbYHMUbU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:31:20 -0400
Received: from hs-out-0708.google.com ([64.233.178.242]:33568 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbYHMUbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:31:19 -0400
Received: by hs-out-0708.google.com with SMTP id 4so98364hsl.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=STKtHrjf8jFrTZuHMS5ysGGDBEBeSfK4Iy0HnyOzsrk=;
        b=GDyysBOb3CHaMnkj8r7xl08MBPc9iTtTbOtntZDHXVrBxUhVnvWLtfSCgdj2PKs092
         BKjLSI8cjG7XaN+uLUTjrdpv6jjPAzSizKSGHWZC9RK0ZtvLmcx6kY91zYCUmGRCzids
         je2H/JwR/unRZ7HYQQZpTmJpI4Jt7NQ1usb3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=MOlHoXgyplPvO2b6PViUXJk+vLl2tiImOpbQ+2z4b6dGItG3vAZ3o1YQ8EoCdL5P1K
         Db4JRNCcKayNUe7yILaXlmWa9JGrUs/69x+hLVJcb3L1eEN/zg/5TqPPKfwXdM5dr8Lg
         oCKe6CCS6O615b/Y+tZJMp+7FNpyodlHkfgpM=
Received: by 10.90.94.2 with SMTP id r2mr392407agb.49.1218659478240;
        Wed, 13 Aug 2008 13:31:18 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id m75sm283019wrm.31.2008.08.13.13.31.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 13:31:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48A34068.9060509@griep.us>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92265>

Hrmmm...  From what I see in CPAN, File::Spec has been around=20
perl since 1998 (around v5.4.7).  Based on this is it safe-ish=20
to assume availability of File::Spec?

Or, as I said earlier, should we kick out a submodule for the tempfile
functions?

Marcus Griep wrote:
> Yeesh; didn't realize it would create that heavy of a dependency.
> Perhaps this should be split into a submodule so that Git.pm doesn't
> require the newer dependency.  Eric/Junio?
>
> Lea Wiemann wrote:
>> This makes Git.pm dependent on Perl 5.6.1.  Some tests (like
>> t3701-add-interactive.sh) seem to work with pretty much any Perl ver=
sion
>> out there, and requiring File::Spec changes this.  Hence to avoid
>> complaints about failing tests, I suggest that you add a check for
>> File::Spec availability at the beginning of any test that (indirectl=
y)
>> uses Git.pm.
>>
>> (All my statements are untested... ;-))
>>
>> -- Lea
>=20

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
