From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 17:06:05 -0500
Message-ID: <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-5-1023149992; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:07:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGPD-0002ZT-AS
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYAPWGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYAPWGN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:06:13 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:41679 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751700AbYAPWGL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 17:06:11 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 22A37AF824;
	Wed, 16 Jan 2008 14:06:06 -0800 (PST)
In-Reply-To: <200801162251.54219.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70753>


--Apple-Mail-5-1023149992
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 16, 2008, at 4:51 PM, Jakub Narebski wrote:

>> On the other hand, what you create the file with may not
>> be what you read back later, since the name has been standardized.
>> It's hard to say one is better than the other, they're just different
>> ways of doing it.
>
> But using one encoding to create file, and another when reding  
> filenames
> is strange. It is IMHO better to simply refuse creating filenames  
> which
> are outside chosen encoding / normalization. But having different
> encodings used for reading and writing on the level of filesystem
> access (not on level of UI) is strange.

It's not using different encodings, it's all Unicode. However, it  
accepts different normalization variants of Unicode, since it can read  
them all and it would be folly to require everybody to conform to its  
own special internal variant. But it does have to normalize them,  
otherwise how would it detect the same filename using different  
normalizations? Also, it may seem strange to have different names  
between reading and writing, but that's only if you think of the name  
as a sequence of bytes - when treated as a sequence of characters, you  
get the same result. In other words, you're used to filenames as  
bytes, HFS+ treats filenames as strings.

>> However, I have noticed that everybody who's voiced
>> an opinion on this list in favor of the encoding-agnostic approach
>> seem to be unwilling to accept that any other approach might have
>> validity, to the extent of calling an OS/filesystem that does things
>> different stupid or insane. This strikes me as extremely elitist and
>> risks alienating what I expect to be a fast-growing group of users
>> (i.e. OS X users).
>
> First, it is Git philosophy and very core of design to be encoding
> agnostic (to be "content tracker"). Second, using the same sequence of
> bytes on filesystem, in the index, and in 'tree' objects ensures good
> performance... this is something to think about if you want to add
> patches which would deal with HFS+ API/UI quirks.

Sure, it makes sense from a performance perspective, but it causes  
problems with HFS+ and any other filesystem that behaves the same way.  
In the previous discussion about case-sensitivity, somebody suggested  
using a lookup table to map between git's internal representation and  
the name the filesystem returns, which seems like a decent idea and  
one that could be enabled with a config parameter to avoid penalizing  
repos on other filesystems. But I don't know enough about the  
internals of git to even think of trying to implement it myself.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-5-1023149992
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
DxcNMDgwMTE2MjIwNjA2WjAjBgkqhkiG9w0BCQQxFgQUranKibawAgIxHFQNa7IA8m/WAmEwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBACEuXSq3JAFX74514hPOGXy+Dr9YcamZQEPFEjeVpcvkpnjaBYC0D9lvl6pAenQ40O7/AkXI
i+Fc58lJdeufLmSs4N9/2oDAXvkG/Mg1vl+/g4PSHgw59Dy5VuC8rz1S8261scbyI1O2a0XYC6ch
Zv5543PvrJPJwuCbucfmM41bZWrexKSOr3Id1TVMFcceMQoAvPjr3fX33Qw9tVmKgwwwQNiTgIAL
1NVcvVEokLWUF8uUULTy7vIGd7hvzJvKo6sWGM96/4JXCb9V+IDFi2v33ydCT2E8TlA2Tns5gy4G
n9QaqqmsJJ3X9hRpE/ByxeyjQmWC63AggKa7V5xPoRIAAAAAAAA=

--Apple-Mail-5-1023149992--
