From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Test t9500 fails if Time::HiRes is missing
Date: Fri, 27 Jan 2012 11:15:10 +0100
Message-ID: <69c90e626682e60d33bebcc6d3ff3fdb@ulrik.uio.no>
References: <hbf.20120123rqzg@bombur.uio.no>
 <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 11:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqipz-0000Z5-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 11:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2A0KPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 05:15:13 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:52215 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab2A0KPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 05:15:12 -0500
Received: from mail-mx5.uio.no ([129.240.10.46])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Rqipr-0004Vu-Fq; Fri, 27 Jan 2012 11:15:11 +0100
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx5.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Rqipr-00051D-25; Fri, 27 Jan 2012 11:15:11 +0100
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Fri, 27 Jan 2012 11:15:10 +0100
In-Reply-To: <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 1 sum rcpts/h 4 sum msgs/h 1 total rcpts 2112 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 13FFC0A3CFFF9FD0BB378C196941EBFC0837CD27
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 82 total 2045172 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189213>

 On Mon, 23 Jan 2012 10:42:02 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason=20
 <avarab@gmail.com> wrote:
> On Mon, Jan 23, 2012 at 05:50, Hallvard Breien Furuseth
> <h.b.furuseth@usit.uio.no> wrote:
>> Or pacify the test and expect gitweb@RHEL-users to install the RPM:
>>
>> --- git-1.7.9.rc2/t/gitweb-lib.sh~
>> +++ git-1.7.9.rc2/t/gitweb-lib.sh
>> @@ -113,4 +113,9 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_done
>> =C2=A0}
>>
>> +perl -MTime::HiRes -e 0 >/dev/null 2>&1 || {
>> + =C2=A0 =C2=A0 =C2=A0 skip_all=3D'skipping gitweb tests, Time::HiRe=
s module not=20
>> available'
>> + =C2=A0 =C2=A0 =C2=A0 test_done
>> +}
>> +
>> =C2=A0gitweb_init
>
> [Adding Jakub to CC]
>
> This doesn't actually fix the issue, it only sweeps it under the rug
> by making the tests pass, gitweb will still fail to compile on Red
> Hat once installed.

 Is that relevant?  gitweb-lib.sh already has code to pass the tests if
 Encode, CGI, CGI::Util or CGI::Carp are missing.  I just added another=
=2E

--=20
 Hallvard
