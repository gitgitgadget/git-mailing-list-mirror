From: David Reitter <david.reitter@gmail.com>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 09:27:24 -0400
Message-ID: <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-26--337876412; micalg=sha1; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 14:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlkDG-0000uX-UN
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 14:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbZCWN1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 09:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbZCWN1j
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 09:27:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:13768 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZCWN1i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 09:27:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1772158rvb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:mime-version:subject:date:references
         :x-mailer;
        bh=FBhDgglqREuUcMW5qkBGSpPTKLmPueCyjtVo/N09E0g=;
        b=I4BOU3IewpNg2P+4lltap/5Jd71+TDyzuXStsGwrvKSsZnhSWcz18Ug/a4Mf+v5YKQ
         SlsJuhqOgX/Uu6EnDsKsJqQuyi/qK1orCbhTvu62XcbaLZG8uVb58JAu/CBWkYpHMjH5
         Nyui02zCesIbjprpW/yvLpIjSb44GRF3+lPMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:mime-version:subject
         :date:references:x-mailer;
        b=BMLEG4DTWGTYU9UjuzJqjMHBmxlL+UHWeQzXWLQFJMLknaxfuhDsRlNIWZth7NROCR
         G+wkL/XESg50TBzg1oHG7Bu3f0jvFE0O9AmAJ7zP8LK55ftvBymlqZZj48qgDJEj1btJ
         E66RnhytklpCnfJkl/01MyP30/DVsItRqvrCk=
Received: by 10.141.142.1 with SMTP id u1mr2296137rvn.129.1237814856187;
        Mon, 23 Mar 2009 06:27:36 -0700 (PDT)
Received: from ?192.168.1.42? (pool-72-65-195-138.pitbpa.east.verizon.net [72.65.195.138])
        by mx.google.com with ESMTPS id f42sm10464539rvb.11.2009.03.23.06.27.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 06:27:34 -0700 (PDT)
In-Reply-To: <7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114301>


--Apple-Mail-26--337876412
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Mar 23, 2009, at 4:06 AM, Junio C Hamano wrote:
>
>> Suppose I have a bzr branch that has been converted (somehow) to a  
>> git
>> branch, is it then possible to merge new revisions from the bzr  
>> branch
>> into the git one?
>
> It entirely depends on how that "somehow" goes.
>
> If that "somehow" procedure performs a reliably reproducible  
> conversion
> (i.e. not only it will produce the identical git history when you  
> feed the
> same bzr history to the procedure twice, but it will produce the  
> identical
> git history followed by new history if you feed the bzr history  
> after new
> commits are added to the bzr history), you should be able to re- 
> convert

I'm just experimenting with "bzr fast-export", which converts to git,  
and it seems to take about 4 minutes for 1000 revisions on our  
(modern) server.  That would be around 7 hours for my emacs  
repository; I can't do that daily.

I wonder if there's a way for (bzr) fast-export / (git) fast-import to  
work incrementally, i.e. for selected or most recent revisions.

Or, one could do something like  bzr diff -r $REV.. $BBRANCH |  (cd  
$GBRANCH; patch -p0; git commit), plus preserving authors and log  
messages.   Is this roughly what the fast-export format does anyways?


--Apple-Mail-26--337876412
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFxDCCAn0w
ggHmoAMCAQICED6shx13jEDrq0eL8FRq5ykwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTIwOTAyMDgwMVoXDTA5MTIwOTAyMDgw
MVowYjEQMA4GA1UEBBMHUmVpdHRlcjEOMAwGA1UEKhMFRGF2aWQxFjAUBgNVBAMTDURhdmlkIFJl
aXR0ZXIxJjAkBgkqhkiG9w0BCQEWF2RhdmlkLnJlaXR0ZXJAZ21haWwuY29tMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDOdo6kAwlkBxUb8dj4saMbYg4SVng8CUePFn3cjjWrakBTbUVa4Z0n
wlUxr7AitEeKhBy5nGhu96+jKUPrCwYNRCZ0l2ovvuGq4z1m1nZ5/c8WvFlVhieuxXMUfmb/O7D3
IojoX6iS8n5MNNU2IWNNT/AD3vOl6DKgOtOw4J9y+QIDAQABozQwMjAiBgNVHREEGzAZgRdkYXZp
ZC5yZWl0dGVyQGdtYWlsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAIjI8yEW
wkiEfA9PMgpjnD6KyCXT0iZjHhW2PkR53yZZLUoTboHnKgsFwYp/gzzIL8J5cvZaRUyMUzXDufPP
dRmxxCs2jXXLDD/8bvdvOuMzqgYoFA73fAfsC8S6qUL1PayZ90J8CZHNhDwqWqOA56T+DdKUegJT
sqoHKh6OnypTMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkEx
FTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3
dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEk
MCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJz
b25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVow
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU
5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8C
AQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFs
RnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2
YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5
jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAo8wggKLAgEB
MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA+rIcdd4xA66tH
i/BUaucpMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTA5MDMyMzEzMjcyNVowIwYJKoZIhvcNAQkEMRYEFHRx1OkDEIQCQPLH3sbc04QysHQW
MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQPqyHHXeMQOurR4vwVGrnKTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQPqyHHXeMQOurR4vwVGrnKTANBgkqhkiG9w0B
AQEFAASBgEcN5Y+DvwncluR0gFCnYL4571I47Jylw2OirXMOhHAP1Ut2OOEXr4JzScjG8GPXOmct
NgqiySU7T4lsvXwPykUN1Ii5JXO+h7vQuP+WbaL0lilrfZz/7QnG55NoOaHzhdm4hLvGHSEepBJD
gWt2dYnuyw0Orek6sV+GzXuMASHeAAAAAAAA

--Apple-Mail-26--337876412--
