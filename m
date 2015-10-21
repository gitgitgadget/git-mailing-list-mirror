From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: t7063-status-untracked-cache.sh test failure on next
Date: Wed, 21 Oct 2015 17:22:58 +0100
Message-ID: <5627BBE2.9000306@ramsayjones.plus.com>
References: <5627A31C.10906@ramsayjones.plus.com> <5627B7DD.3020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 18:23:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZowAP-0005rl-UW
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 18:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbbJUQXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 12:23:04 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55028 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbbJUQXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 12:23:02 -0400
Received: from [10.0.2.15] ([87.114.3.134])
	by avasout07 with smtp
	id XsNy1r0082tV80P01sNz3U; Wed, 21 Oct 2015 17:23:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=qQ71F3v+nKp5qei/W0vv8w==:117 a=qQ71F3v+nKp5qei/W0vv8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=6NG_XSeZAAAA:8 a=kSnk4M1s8-YYxlUn8kUA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5627B7DD.3020909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279987>



On 21/10/15 17:05, Torsten B=C3=B6gershausen wrote:
> On 21.10.15 16:37, Ramsay Jones wrote:
>> Hi Junio,
>>
>> While testing the next branch today, I had a test failure, viz:
>>
>>     $ tail ntest-out-fail
>>     Test Summary Report
>>     -------------------
>>     t7063-status-untracked-cache.sh                  (Wstat: 256 Tes=
ts: 32 Failed: 22)
>=20
> Does this patch help ?
> (Recently send & tested by David. I just copy & paste the diff)
> []
> =20

No, that patch is already in next and was part of the build
that failed:

    $ git log -1 --oneline 9b680fbd3
    9b680fb t7063: fix flaky untracked-cache test
    $ git branch --contains 9b680fbd3
    * next
      pu
    $=20

Again, I haven't been able to reproduce the failure ...

[I should have said the this is today's next branch
@ 3b31934 Sync with master. This is on Linux Mint 17.2]

Thanks.

ATB,
Ramsay Jones


> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  t/t7063-status-untracked-cache.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untra=
cked-cache.sh
> index 37a24c1..0e8d0d4 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -412,7 +412,9 @@ test_expect_success 'create/modify files, some of=
 which are gitignored' '
>  	echo two bis >done/two &&
>  	echo three >done/three && # three is gitignored
>  	echo four >done/four && # four is gitignored at a higher level
> -	echo five >done/five # five is not gitignored
> +	echo five >done/five && # five is not gitignored
> +	echo test >base && #we need to ensure that the root dir is touched
> +	rm base
>  '
>=20
>=20
