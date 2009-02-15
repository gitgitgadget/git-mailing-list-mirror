From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/8] config: Don't return negative exit codes.
Date: Sun, 15 Feb 2009 14:39:47 +0200
Message-ID: <94a0d4530902150439peac228ckec79f8c692b84e4e@mail.gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902151321310.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd2474a8921230462f45d3a
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYgJB-0002Xy-Mv
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbZBOMju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZBOMju
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:39:50 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41496 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbZBOMjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:39:49 -0500
Received: by fxm13 with SMTP id 13so4874616fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=B/iXHr9PyaZAA6ykZNNE94uBXpa3DJ8FC+X83JglBzw=;
        b=bFdGnagNUfnf3I3nQKlVdEizZV4r0l4OzB1ca9GGe5lfePHPqrc3XOOhO3iW53+iM5
         z8SwLY6APPVJi1AxjZcjNlVV/+JdzEUfxiU/WqYEAVHYO28Iuh3nUErFiF1RwlsYSgv/
         M8XGgljkyTGvoy5T31bbqfdKxKsRITa0wUUBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=reyPj7aP6WhujDRdv/Py+qOityGdAg1n6KpWThStm5S/SNXbk/ZxrJjfyrRvkHPE9Z
         4U00oC9Tbbsj4eVXWhyTrYIHQ+db7uCib+uOg31XeCF6kWqjTSY53p3vy/bL0S+IGA2q
         M22cuOVMIDrp20pK1/gKK18oStz8UH+s8froo=
Received: by 10.86.4.2 with SMTP id 2mr820111fgd.50.1234701587652; Sun, 15 Feb 
	2009 04:39:47 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151321310.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110002>

--000e0cd2474a8921230462f45d3a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Feb 15, 2009 at 2:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 15 Feb 2009, Felipe Contreras wrote:
>
>
>>       else if (actions & ACTION_RENAME_SECTION) {
>> -             int ret;
>>               check_argc(argc, 2, 2);
>>               ret = git_config_rename_section(argv[0], argv[1]);
>> -             if (ret < 0)
>> -                     return ret;
>>               if (ret == 0)
>>                       die("No such section!");
>>       }
>
> You need an "if (ret > 0) ret = 0;" to avoid regressions.
>
>>       else if (actions & ACTION_REMOVE_SECTION) {
>> -             int ret;
>>               check_argc(argc, 1, 1);
>>               ret = git_config_rename_section(argv[0], NULL);
>> -             if (ret < 0)
>> -                     return ret;
>>               if (ret == 0)
>>                       die("No such section!");
>>       }
>
> Likewise.

True. Fixed in the attached patch.

-- 
Felipe Contreras

--000e0cd2474a8921230462f45d3a
Content-Type: application/octet-stream; 
	name="0007-config-Don-t-return-negative-exit-codes.patch"
Content-Disposition: attachment; 
	filename="0007-config-Don-t-return-negative-exit-codes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr7pfi5a0

RnJvbSBiNjgyMTMxYjYxZDAxY2FjMjk0NmU3YzdhYjY2NjZmZWY4NjQ0MWE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogU3VuLCAxNSBGZWIgMjAwOSAxMDo1NDo1MyArMDIwMApTdWJqZWN0OiBb
UEFUQ0ggNy84XSBjb25maWc6IERvbid0IHJldHVybiBuZWdhdGl2ZSBleGl0IGNvZGVzLgoKQXMg
c3VnZ2VzdGVkIGJ5IEpvaGFubmVzIFNjaGluZGVsaW4uCgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUg
Q29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluLWNvbmZp
Zy5jIHwgICAzMSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5n
ZWQsIDE1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0
aW4tY29uZmlnLmMgYi9idWlsdGluLWNvbmZpZy5jCmluZGV4IDU4OTFhNGUuLjA2MDZhZGEgMTAw
NjQ0Ci0tLSBhL2J1aWx0aW4tY29uZmlnLmMKKysrIGIvYnVpbHRpbi1jb25maWcuYwpAQCAtMzA3
LDYgKzMwNyw3IEBAIGludCBjbWRfY29uZmlnKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwg
Y29uc3QgY2hhciAqdW51c2VkX3ByZWZpeCkKIHsKIAlpbnQgbm9uZ2l0OwogCWNoYXIqIHZhbHVl
OworCWludCByZXQgPSAwOwogCWNvbnN0IGNoYXIgKnByZWZpeCA9IHNldHVwX2dpdF9kaXJlY3Rv
cnlfZ2VudGx5KCZub25naXQpOwogCiAJY29uZmlnX2V4Y2x1c2l2ZV9maWxlbmFtZSA9IGdldGVu
dihDT05GSUdfRU5WSVJPTk1FTlQpOwpAQCAtMzgwLDU3ICszODEsNTUgQEAgaW50IGNtZF9jb25m
aWcoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICp1bnVzZWRfcHJlZml4
KQogCWVsc2UgaWYgKGFjdGlvbnMgJiBBQ1RJT05fQUREKSB7CiAJCWNoZWNrX2FyZ2MoYXJnYywg
MiwgMik7CiAJCXZhbHVlID0gbm9ybWFsaXplX3ZhbHVlKGFyZ3ZbMF0sIGFyZ3ZbMV0pOwotCQly
ZXR1cm4gZ2l0X2NvbmZpZ19zZXRfbXVsdGl2YXIoYXJndlswXSwgdmFsdWUsICJeJCIsIDApOwor
CQlyZXQgPSBnaXRfY29uZmlnX3NldF9tdWx0aXZhcihhcmd2WzBdLCB2YWx1ZSwgIl4kIiwgMCk7
CiAJfQogCWVsc2UgaWYgKGFjdGlvbnMgJiBBQ1RJT05fUkVQTEFDRV9BTEwpIHsKIAkJY2hlY2tf
YXJnYyhhcmdjLCAyLCAzKTsKIAkJdmFsdWUgPSBub3JtYWxpemVfdmFsdWUoYXJndlswXSwgYXJn
dlsxXSk7Ci0JCXJldHVybiBnaXRfY29uZmlnX3NldF9tdWx0aXZhcihhcmd2WzBdLCB2YWx1ZSwg
YXJndlsyXSwgMSk7CisJCXJldCA9IGdpdF9jb25maWdfc2V0X211bHRpdmFyKGFyZ3ZbMF0sIHZh
bHVlLCBhcmd2WzJdLCAxKTsKIAl9CiAJZWxzZSBpZiAoYWN0aW9ucyAmIEFDVElPTl9HRVQpIHsK
IAkJY2hlY2tfYXJnYyhhcmdjLCAxLCAyKTsKLQkJcmV0dXJuIGdldF92YWx1ZShhcmd2WzBdLCBh
cmd2WzFdKTsKKwkJcmV0ID0gZ2V0X3ZhbHVlKGFyZ3ZbMF0sIGFyZ3ZbMV0pOwogCX0KIAllbHNl
IGlmIChhY3Rpb25zICYgQUNUSU9OX0dFVF9BTEwpIHsKIAkJZG9fYWxsID0gMTsKIAkJY2hlY2tf
YXJnYyhhcmdjLCAxLCAyKTsKLQkJcmV0dXJuIGdldF92YWx1ZShhcmd2WzBdLCBhcmd2WzFdKTsK
KwkJcmV0ID0gZ2V0X3ZhbHVlKGFyZ3ZbMF0sIGFyZ3ZbMV0pOwogCX0KIAllbHNlIGlmIChhY3Rp
b25zICYgQUNUSU9OX0dFVF9SRUdFWFApIHsKIAkJc2hvd19rZXlzID0gMTsKIAkJdXNlX2tleV9y
ZWdleHAgPSAxOwogCQlkb19hbGwgPSAxOwogCQljaGVja19hcmdjKGFyZ2MsIDEsIDIpOwotCQly
ZXR1cm4gZ2V0X3ZhbHVlKGFyZ3ZbMF0sIGFyZ3ZbMV0pOworCQlyZXQgPSBnZXRfdmFsdWUoYXJn
dlswXSwgYXJndlsxXSk7CiAJfQogCWVsc2UgaWYgKGFjdGlvbnMgJiBBQ1RJT05fVU5TRVQpIHsK
IAkJY2hlY2tfYXJnYyhhcmdjLCAxLCAyKTsKIAkJaWYgKGFyZ2MgPT0gMikKLQkJCXJldHVybiBn
aXRfY29uZmlnX3NldF9tdWx0aXZhcihhcmd2WzBdLCBOVUxMLCBhcmd2WzFdLCAwKTsKKwkJCXJl
dCA9IGdpdF9jb25maWdfc2V0X211bHRpdmFyKGFyZ3ZbMF0sIE5VTEwsIGFyZ3ZbMV0sIDApOwog
CQllbHNlCi0JCQlyZXR1cm4gZ2l0X2NvbmZpZ19zZXQoYXJndlswXSwgTlVMTCk7CisJCQlyZXQg
PSBnaXRfY29uZmlnX3NldChhcmd2WzBdLCBOVUxMKTsKIAl9CiAJZWxzZSBpZiAoYWN0aW9ucyAm
IEFDVElPTl9VTlNFVF9BTEwpIHsKIAkJY2hlY2tfYXJnYyhhcmdjLCAxLCAyKTsKLQkJcmV0dXJu
IGdpdF9jb25maWdfc2V0X211bHRpdmFyKGFyZ3ZbMF0sIE5VTEwsIGFyZ3ZbMV0sIDEpOworCQly
ZXQgPSBnaXRfY29uZmlnX3NldF9tdWx0aXZhcihhcmd2WzBdLCBOVUxMLCBhcmd2WzFdLCAxKTsK
IAl9CiAJZWxzZSBpZiAoYWN0aW9ucyAmIEFDVElPTl9SRU5BTUVfU0VDVElPTikgewotCQlpbnQg
cmV0OwogCQljaGVja19hcmdjKGFyZ2MsIDIsIDIpOwogCQlyZXQgPSBnaXRfY29uZmlnX3JlbmFt
ZV9zZWN0aW9uKGFyZ3ZbMF0sIGFyZ3ZbMV0pOwotCQlpZiAocmV0IDwgMCkKLQkJCXJldHVybiBy
ZXQ7CiAJCWlmIChyZXQgPT0gMCkKIAkJCWRpZSgiTm8gc3VjaCBzZWN0aW9uISIpOworCQlpZiAo
cmV0ID4gMCkKKwkJCXJldCA9IDA7CiAJfQogCWVsc2UgaWYgKGFjdGlvbnMgJiBBQ1RJT05fUkVN
T1ZFX1NFQ1RJT04pIHsKLQkJaW50IHJldDsKIAkJY2hlY2tfYXJnYyhhcmdjLCAxLCAxKTsKIAkJ
cmV0ID0gZ2l0X2NvbmZpZ19yZW5hbWVfc2VjdGlvbihhcmd2WzBdLCBOVUxMKTsKLQkJaWYgKHJl
dCA8IDApCi0JCQlyZXR1cm4gcmV0OwogCQlpZiAocmV0ID09IDApCiAJCQlkaWUoIk5vIHN1Y2gg
c2VjdGlvbiEiKTsKKwkJaWYgKHJldCA+IDApCisJCQlyZXQgPSAwOwogCX0KIAllbHNlIGlmIChn
ZXRfY29sb3Jfc2xvdCkgewogCQlnZXRfY29sb3IoYXJndlswXSk7CkBAIC00NDAsOCArNDM5LDgg
QEAgaW50IGNtZF9jb25maWcoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFy
ICp1bnVzZWRfcHJlZml4KQogCQkJc3Rkb3V0X2lzX3R0eSA9IGdpdF9jb25maWdfYm9vbCgiY29t
bWFuZCBsaW5lIiwgYXJndlswXSk7CiAJCWVsc2UgaWYgKGFyZ2MgPT0gMCkKIAkJCXN0ZG91dF9p
c190dHkgPSBpc2F0dHkoMSk7Ci0JCXJldHVybiBnZXRfY29sb3Jib29sKGFyZ2MgIT0gMSk7CisJ
CXJldCA9IGdldF9jb2xvcmJvb2woYXJnYyAhPSAxKTsKIAl9CiAKLQlyZXR1cm4gMDsKKwlyZXR1
cm4gISFyZXQ7CiB9Ci0tIAoxLjYuMS4zCgo=
--000e0cd2474a8921230462f45d3a--
