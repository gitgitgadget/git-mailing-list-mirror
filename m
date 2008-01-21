From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 16:07:27 -0500
Message-ID: <DEC058ED-EBF0-4A1E-BF7B-448B16DBBD6E@sb.org>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121205615.GY14871@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-30--695852197; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3s8-0003Yt-SJ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbYAUVHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYAUVHa
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:07:30 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:44685 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752592AbYAUVHa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:07:30 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id A2DF1EEE9C;
	Mon, 21 Jan 2008 13:07:28 -0800 (PST)
In-Reply-To: <20080121205615.GY14871@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71340>


--Apple-Mail-30--695852197
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 3:56 PM, Dmitry Potapov wrote:

> On Mon, Jan 21, 2008 at 02:05:51PM -0500, Kevin Ballard wrote:
>>>
>>> But that is *entirely* a separate issue from "normalization".
>>>
>>> Kevin, you seem to think that normalization is somehow forced on you
>>> by
>>> the "text-as-codepoints" decision, and that is SIMPLY NOT TRUE.
>>> Normalization is a totally separate decision, and it's a STUPID one,
>>> because it breaks so many of the _nice_ properties of using UTF-8.
>>
>> I'm not saying it's forced on you, I'm saying when you treat  
>> filenames
>> as text,
>
> to treat as text could mean different for different people. Some
> may prefer to fi and fi_ligature to be treated as same in some
> context.

Those people can use NFKC/NFKD (compatibility equivalence). As I've  
said before, I'm talking about canonical equivalence, because that  
doesn't lose information like compatibility equivalence does (ex. the  
fi ligature gets turned into fi in compatibility equivalence, but not  
canonical equivalence).

>> it DOESN'T MATTER if the string gets normalized. As long as
>> the string remains equivalent,
>
> As matter of fact it does, otherwise characters would be the
> same and we would not have this conversation at all. String
> can be equivalent and not equivalent at the time, because there
> are different equivalent relations. Finally, what HFS+ does
> is even not normalization. In the technote, Apple explains
> that they decompose some characters but not others for better
> compatibility. So, you see, there is a PROBLEM here.

Again, I've specified many times that I'm talking about canonical  
equivalence.

And yes, HFS+ does normalization, it just doesn't use NFD. It uses a  
custom variant. I fail to see how this is a problem.

>> Alright, fine. I'm not saying HFS+ is right in storing the normalized
>> version, but I do believe the authors of HFS+ must have had a reason
>> to do that,
>
> I don't say they do that without *any* reason, but I suppose all
> Apple developers in the Copland project had some reasons for they
> did, but the outcome was not very good...

Stupid engineers don't get to work on developing new filesystems. And  
Copland didn't fail because of stupid engineers anyway. If I had to  
blame someone, I'd blame management.

>> The only information you lose when doing canonical normalization is
>> what the original byte sequence was.
>
> Not true. You lose the original sequence of *characters*.

Which is only a problem if you care about the byte sequence, which is  
kinda the whole point of my argument.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-30--695852197
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTIxMjEwNzI3WjAjBgkqhkiG9w0BCQQxFgQUlzA2Y2ujlpES46b9kN3rwRfTFQ0wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBACoIUu+22XuwgxLcHNaHhmvyxcdwLj/8LMLk2/oLdgkk6yfnVVvnbAeBKqFGRZpYzH/8ZtMq
2wCT0ywI4oV9R3xGBErLD+1GfIaGWi/RTSUpZi2IFE70uEMhGeB6GL7v19LK9tM8+WkRN0EqBv1l
n3YxHtNBcPRuCMLOt2xhSQ/ibTtnaLgfHDYqWJ1T+aOHhw6dhckC9UV4gFkGywKF7U8wYKJhkqZK
Cqb9A6aduXzn+pRIB4BiE0vQpFQW+mM3WIkr/jT9Jk5uy7RbF3ZmNEE5+qNbX9qRlM4GTuJtISjk
17n/B5O4qlGly8ebKin7piR+GbEjjsFdzr7tSa25zMUAAAAAAAA=

--Apple-Mail-30--695852197--
