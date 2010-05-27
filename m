From: Jonathan Callen <abcd@gentoo.org>
Subject: Re: [PATCH 1/3] Support building on systems without poll(2)
Date: Thu, 27 May 2010 05:13:50 -0400
Message-ID: <4BFE37CE.9090105@gentoo.org>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org> <1274948384-167-2-git-send-email-abcd@gentoo.org> <4BFE3286.8070508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mduft@gentoo.org, jrnieder@gmail.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 27 11:14:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHZAC-0001V2-OW
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 11:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166Ab0E0JNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 05:13:55 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:34553 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756732Ab0E0JNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 05:13:53 -0400
Received: from [192.168.0.40] (pool-72-86-43-250.clppva.fios.verizon.net [72.86.43.250])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 71C501B401B;
	Thu, 27 May 2010 09:13:52 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100517 Thunderbird/3.0.4
In-Reply-To: <4BFE3286.8070508@drmicha.warpmail.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147841>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/27/2010 04:51 AM, Michael J Gruber wrote:
> Jonathan Callen venit, vidit, dixit 27.05.2010 10:19:
>> +#ifdef NO_POLL
>>  extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
>> +#endif
> 
> Shouldn't this be "ifndef"? makes me wonder how the test compile worked...
> 

Yeah, that's a mistake.  It should be #ifndef. The test compile worked
because cmd_upload_archive is never called when NO_POLL is defined (and
I didn't test on a system where it wasn't).

- -- 
Jonathan Callen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJL/jfNAAoJELHSF2kinlg4avYP/3CxgTwg1Wcraf0JLxtg590T
r0VPk/FJfN70kCwch1107qrXFH2Lm5j57R2qcJRPbO4xLg3/7SVDo8uh5srRVBwh
jHV/lVHiDofzAwogv0T1dAd02/WrbpBKM8Wt6sT0fz9Y3yMGPfSuYCazQ0uiH6NA
I/Rk2CcTelNNSo4h8+XRTdMwiEVIehw1zUNX9HhH1SYWastMCgoh2PS+cpeGot+q
IvInTpcOJfOsREXTxjer9zf/GeZsTiEVLgDWZG6Uc0JOEvLTKOqk/BcSeOn4L2zv
lHz14vMT8NS68U/rfPvTjscgczyS2E47XHrvM0+1bswLuNVrilHdzgcnH2rhWFFP
tU/dA6qzzFPvpqLwhXOwxECUsnJ8km5i8oR1914Qwfxr88KVR8syYyDl4eSI3qMg
MbFRTAzRC+4KD1FcGaQ7f7f2J/2Um4wtTb5SrKUJVKk2ROI/2KfBFthI4SbIonOf
NYJp+2XEpc3vbwE6YbiFzXBkP2z/F4fFvorYi8epa1neX7YKF7Hp+U5UJIFBb8de
KMKCoX1ClXjsTQ3B72M29D/o52L67/xcyoPDIfmnjuxeBcrJBO82z8pqMCyF4nh+
xa7mU4rrk6D8ZHxv1uULf8Bqz29Eq6dzzeuNkoV/5plLC2XjWJ2qsMxvZY9dED4h
6SUO3TH9eJJW6eAZG9bB
=RkSh
-----END PGP SIGNATURE-----
