From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: blameview and file line number
Date: Tue, 30 Jan 2007 14:42:31 +0530
Message-ID: <cc723f590701300112x6493a0eaw153aad1a18cd289a@mail.gmail.com>
References: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
	 <7vireo52xs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_160798_16083778.1170148351234"
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 10:12:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBp2c-0006Vu-9l
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 10:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393AbXA3JMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 04:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965429AbXA3JMe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 04:12:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:54530 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393AbXA3JMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 04:12:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so148419nfa
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 01:12:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=cmo4ndW7K3qPELDdIvfqNHZjTexvvU8VPvd7s9PhDZQuukOXQM2Uq3K9XtteLssobxmq9WPMnWrTB9sTio42yeBPuQ1IllyjDh6rFkHhYrqn7LXTrVxz11vYOaDgtHbxaD6SJ2EjQejFATKuO5zp4120bZdmJ9TbWPdyN8bTj54=
Received: by 10.49.41.3 with SMTP id t3mr434374nfj.1170148351394;
        Tue, 30 Jan 2007 01:12:31 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Tue, 30 Jan 2007 01:12:31 -0800 (PST)
In-Reply-To: <7vireo52xs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38142>

------=_Part_160798_16083778.1170148351234
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/30/07, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>
> > Is it a typo or intentional ? I found the blameview output confusing.
>
> Compare it with gitweb or textual output (blame -n -f).
>
> It is supposed to show the line number in the original file.
> Using lno is obviously wrong, as we are not reinventing "cat -n"
> here ;-).

In that case the heading is wrong. It should be something other than
Filenum. How about the patch below. On top of the series i sent you
before.

-aneesh

------=_Part_160798_16083778.1170148351234
Content-Type: text/x-patch; name="blameview.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="blameview.diff"
X-Attachment-Id: f_exk441j7

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvYmxhbWV2aWV3L2JsYW1ldmlldy5wZXJsIGIvY29udHJpYi9i
bGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKaW5kZXggOGFkOWJjZi4uOTE0OWUzNSAxMDA3NTUKLS0t
IGEvY29udHJpYi9ibGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKKysrIGIvY29udHJpYi9ibGFtZXZp
ZXcvYmxhbWV2aWV3LnBlcmwKQEAgLTI5LDYgKzI5LDcgQEAgbXkgJHNjcm9sbGVkX3dpbmRvdyA9
IEd0azI6OlNjcm9sbGVkV2luZG93LT5uZXc7CiAkd2luZG93LT5hZGQoJHNjcm9sbGVkX3dpbmRv
dyk7CiBteSAkZmlsZXZpZXcgPSBHdGsyOjpTaW1wbGVMaXN0LT5uZXcoCiAgICAgJ0NvbW1pdCcg
PT4gJ3RleHQnLAorICAgICdPcmlnTGluZScgPT4gJ3RleHQnLAogICAgICdDb21taXRJbmZvJyA9
PiAndGV4dCcsCiAgICAgJ0ZpbGVMaW5lJyA9PiAndGV4dCcsCiAgICAgJ0RhdGEnID0+ICd0ZXh0
JwpAQCAtNTAsNyArNTEsNyBAQCBvcGVuKCRmaCwgJy18JywgImdpdCBjYXQtZmlsZSBibG9iICRo
YXNoOiRmbiIpCiAKIHdoaWxlKDwkZmg+KSB7CiAgIGNob21wOwotICAkZmlsZXZpZXctPntkYXRh
fS0+WyQuXSA9IFsnSEVBRCcsICc/JywgIiRmbjokLiIsICRfXTsKKyAgJGZpbGV2aWV3LT57ZGF0
YX0tPlskLl0gPSBbJ0hFQUQnLCc/JywgJz8nLCAiJC4iLCAkX107CiB9CiAKIG15ICRibGFtZTsK
QEAgLTc5LDggKzgwLDggQEAgc3ViIGZsdXNoX2JsYW1lX2xpbmUgewogCiAJZm9yKG15ICRpID0g
MDsgJGkgPCAkY250OyAkaSsrKSB7CiAJCUB7JGZpbGV2aWV3LT57ZGF0YX0tPlskbG5vKyRpLTFd
fVswLDEsMl0gPQotCQkgICAgKHN1YnN0cigkY29tbWl0LCAwLCA4KSwgJGluZm8sCi0JCSAgICAg
JGZpbGVuYW1lIC4gJzonIC4gKCRsbm8rJGkpKTsKKwkJICAgIChzdWJzdHIoJGNvbW1pdCwgMCwg
OCksIAorCQkgICAgICRmaWxlbmFtZSAuICc6JyAuICgkc19sbm8rJGkpLCAkaW5mbywgKCRsbm8r
JGkpKTsKIAl9CiB9CiAK
------=_Part_160798_16083778.1170148351234--
