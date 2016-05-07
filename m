From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: t6044 broken on pu
Date: Sat, 7 May 2016 14:15:45 +0100
Message-ID: <572DEA81.4050605@ramsayjones.plus.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
 <878tzmrrfg.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newren@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 07 15:16:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az25O-00026d-3b
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 15:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbcEGNPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 09:15:49 -0400
Received: from avasout07.plus.net ([84.93.230.235]:58355 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbcEGNPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 09:15:48 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id rRFl1s0012D2Veb01RFmnN; Sat, 07 May 2016 14:15:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=yzYAvAggsFbV4yUoh90A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <878tzmrrfg.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293895>



On 07/05/16 13:19, Andreas Schwab wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> The "seq" is not understood by all shells,
>> using printf fixes this,
>>
>> index 20a3ffe..48d964e 100755
>> --- a/t/t6044-merge-unrelated-index-changes.sh
>> +++ b/t/t6044-merge-unrelated-index-changes.sh
>> @@ -20,7 +20,7 @@ test_description=3D"merges with unrelated index ch=
anges"
>>  #   Commit E: renames a->subdir/a, adds subdir/e
>>
>>  test_expect_success 'setup trivial merges' '
>> -       seq 1 10 >a &&
>> +       printf 1 2 3 4 5 7 8 9 10 >a &&
>=20
> $ printf 1 2 3 4 5 7 8 9 10
> 1

yep, I think:

    printf "%d\n" 1 2 3 4 5 6 7 8 9 10 >a &&

would be equivalent.

ATB,
Ramsay Jones
