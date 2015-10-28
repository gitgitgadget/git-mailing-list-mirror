From: "Mathias L. Baumann" <mathias.baumann@sociomantic.com>
Subject: Re: Bug: Segfault when doing "git diff"
Date: Wed, 28 Oct 2015 14:35:23 +0100
Message-ID: <5630CF1B.9000706@sociomantic.com>
References: <5630B876.7080407@sociomantic.com> <5630BE79.40708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 14:39:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrQwf-0001f7-H0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 14:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965598AbbJ1NjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2015 09:39:13 -0400
Received: from mail-am1on0100.outbound.protection.outlook.com ([157.56.112.100]:43104
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965134AbbJ1NjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 09:39:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mathias.baumann@sociomantic.com; 
Received: from [192.168.2.66] (212.184.135.220) by
 AM3PR01MB1330.eurprd01.prod.exchangelabs.com (10.163.11.20) with Microsoft
 SMTP Server (TLS) id 15.1.306.13; Wed, 28 Oct 2015 13:39:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
In-Reply-To: <5630BE79.40708@gmail.com>
X-Originating-IP: [212.184.135.220]
X-ClientProxiedBy: AM3PR04CA0020.eurprd04.prod.outlook.com (10.242.16.20) To
 AM3PR01MB1330.eurprd01.prod.exchangelabs.com (25.163.11.20)
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1330;2:yV3XY0BDlV0zytcLJHXjVkl0xttZrx5ryE+ep0+1nDn4wvNQjL4264aY/xYCV6TarNLN72gm9zR0Glhf7FlT6PMw5qvQAyFdcSjRyvABa9Omf/q088+A8B2ApapKBx2/zopE6Ca65ZDA7XjrrzZrgLPaFSUsDCh8V4f8xkfohTE=;3:EYJkrAnXb+Qy8jEimjZSB0PcJK6AQnqjrdYXv3rU9FU0+jtaW2Mw+y9bfbq1rxxgKHbl5T9u9l7KXsv4yZPhliaWOY462NfmLyqwiPc8uJpTAv+lOVjuQFgCOPtuY2cUWkgeqzlZ5KLluNmu3XDjqA==;25:GGvua94wXwuR+iBk1JAyOzbrB8F28QdsQK9M6HKijF4gg3a5xgEpvr5H8C35rONZBx3qJE0GW2BKFOFsvrCzKyDpB4aHwsviMi7Lyc6PYKVbMz1mQfoB89ESao/P6Fn8I3NhSee2j7mo+ZskgiVXCPYzs3F5HDRM76Xi3A6qvFlKpBZPcXXURzwKWpeu/WIVUYqPw/3/ZLdRe5S/QB63laF763cOj8RYmDmmAc+eS5Hx6deLEkaiviCXnrIx2CTyWMTY/qobpoCUW5JrGtCZbw==;20:SeFKNzJT2nabkuen8h8bFZwGy+2yhzMGdQWly0GN05EZZ+MfVIOz77yrnmfGaiZtgbdy5hyyi3QbdrLwvm3RaF5ISgElAx+sa60oXT6s7Ht8G7MrK+qmRN7fxEUrFnRdNx+8M
 O8jdOfk8YEDcLIn48KXANuGJY1TlPgEQdCSp4EZjkoWSNaOQvMI3fnnztRfizs07iUVWNo2ifMHTgdaoBTT4+737OubVlZmi2+ 
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB1330;
X-Microsoft-Antispam-PRVS: <AM3PR01MB13306F95D482AE2870D1D783EF210@AM3PR01MB1330.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(520078)(3002001)(10201501046)(102215026);SRVR:AM3PR01MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1330;4:d0ghPH5bSs9LLSG0fV4JL4+Im354vpdQdYrTYRU0qdGfS2ve/YXQQG7LuSp4H10ki8OpmiobzXP5VI8dVO2OgLnKnYHVEhI6MPCpA+kJxL33UcvbVVg0/g5jOZobNMhIYi2qVkb1fZQ3IIzU/FP/y1Nsh64pkhsEaNg15J1++fZiqzxb55VpPLfw8nnrpQSt7OMq2BeQ1ZbCm2Y+z1YBpN+TYYkHzgEN0R5lNkkWYy/MsxbZCZ++LD6SXhjJc8EJT0J5vd1VQJvLgTZ+npNL5i0jOXsAVsTVGUhg1Ur/jSIEQNoFOyO9wgVJxBJJ/g/8OBLlIQuDdP7WvYwQI4R7CWVE/kMylkrruhMpvVEc59qF9rnC9Z1es1pu4KcAUStN0K3DFqnpDuOEpTMycmY58w==
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(6049001)(479174004)(189002)(24454002)(199003)(377454003)(66066001)(101416001)(36756003)(80316001)(92566002)(97736004)(5890100001)(65956001)(5001770100001)(33656002)(86362001)(4001350100001)(23676002)(64126003)(81156007)(117156001)(47776003)(15395725005)(42186005)(19580405001)(59896002)(19580395003)(122386002)(87976001)(50986999)(189998001)(76176999)(87266999)(54356999)(106356001)(5004730100002)(5008740100001)(65816999)(83506001)(65806001)(40100003)(5007970100001)(77096005)(2950100001)(105586002)(15975445007)(575784001)(5001960100002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR01MB1330;H:[192.168.2.66];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTNQUjAxTUIxMzMwOzIzOmtuTDhjei9JUFNnRWxhWlM3ZnU5K0tFbnpm?=
 =?utf-8?B?djYzVzBlMk9MeHQwUFppQW44clNwWXo4ODEyTXdCNGh0Nk45bUZ3WVhGT2po?=
 =?utf-8?B?cFRBZTd1eU1kYWFwZ042VWphR29rVVlFYk9hdXlZUkV1VTN5MGx3cENJTGhT?=
 =?utf-8?B?QW9iUWY5NmJJb0RnNnVleHZjb0ZSeENWdmxWc08rdWVPa09GSlFINFFEUHpM?=
 =?utf-8?B?cVlrMVMwcDVBTWR4Zm9VcUgyby8rK3JOSWQ1d012QS8yV3AyUHd6c2tkSTR0?=
 =?utf-8?B?R3pNaFNteEMzeVd5RWZ0blgwY1ZrL1g5Zjc3VGw4Vkl5eExvYmU1TEIyTVZW?=
 =?utf-8?B?SmFuYWdMSlFYV3d2VUNnUVhjLzlHbEhxTDJVd1hPTnk2SGkvNzVZOWd3MDNE?=
 =?utf-8?B?b3dhTmpUOFN6dGRIZ2ZKVTF5MHVYN0t2TEpqQWh5dXhHTEx4UTE1ZVVkNzB2?=
 =?utf-8?B?a0RtcGh3VzgvemRWR3pIS1lPUnd3Y1FHVVRWYUNqOHZpM2FuTUdSWmxVS1Qw?=
 =?utf-8?B?TU5id3hiS0F2Wk9RU3ZyL28vdFF3eDZoN2pvcVZTeUxnQklHNTNlWVhRZkla?=
 =?utf-8?B?RTZBTFg0V1lnY08vWlFpeG8xMGphWHhIUVlmU21EL09QTGhuN2w5RzZkdzZm?=
 =?utf-8?B?MXhvT1NUVzk0ZTRiWTROQnd0YnFlSUVKSlMrcXNHT2 
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1330;5:n92ufrJ9qkyjIvo4E4yve9E9QFgLHdnuqJ2NKst/nMQWHyQ/cHsskqugUeLK5BWHm5JYwZYC8A/lQXXWoJhvj8Q3/ayy6ReMwLPzIi3INI6nppTUIppVCz8hmfa/X4aJ1Sgt1QAEz4i64ZTAbWB0FA==;24:y57ZMz2wKfOIXlzi88sY4YqZdEoiAm+mLUhdPN3df2Kgj++RMu0+PqA8gHoKxmvQKrKrzjVpLCH69rfXEy1/KrYZvUVRuI0RsIpzPMUluAI=;20:i3oajAXw0yG9z2ncZTedtKssNZ99wD2bXIJ+VKlClMNmadj/Tw02YIVuB/qcfWH71m4UW8esvZMFurxyb71jPA==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2015 13:39:07.9642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR01MB1330
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280363>

I was using the latest git version 2.6.2 already.
I suspect it is due to a .gitconfig. This is what is probably required:

=E2=9E=9C  ~  cat .gitconfig
[diff]
     submodule =3D log


On 28/10/15 13:24, Victor Leschuk wrote:
>
>
> On 10/28/2015 02:58 PM, Mathias L. Baumann wrote:
>> Hello dear git devs,
>>
>> I just stumbled upon a segfault when doing just "git diff" in my rep=
o.
>>
>> I managed to create a minimal repo setup where the bug is reproducab=
le.
>>
>> The problem seems to be a mix of having an untracked submodule and
>> having set an alternates file for one submodule.
>>
>> Attached you'll find my setup that will reproduce the problem. Simpl=
y
>> run  'git diff' in bugtest1.
>>
>> In case the attachment is refused, I also uploaded it here:
>>
>> http://supraverse.net/bugdemo.tar.gz
>>
>> cheers,
>>
>>     --Marenz
> Hello Marenz,
>
> I have just tried to reproduce segfault with the provided archive:
>
> [del@del-debian bugtest1 (master)]$ git diff
> diff --git a/submodules/bugtest2 b/submodules/bugtest2
> --- a/submodules/bugtest2
> +++ b/submodules/bugtest2
> @@ -1 +1 @@
> -Subproject commit cd0b9ee2946d2df3626943347332a4d86f93b126
> +Subproject commit cd0b9ee2946d2df3626943347332a4d86f93b126-dirty
>
> No segfault occured. I am using
>
> git version 2.6.2.308.g3b8f10c
>
> Could you please specify which version of git you are using and also =
try
> to reproduce it with latest 2.6.2?
>
> --
> Victor
