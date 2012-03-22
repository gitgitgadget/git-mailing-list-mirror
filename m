From: Hong Xu <xuhdev@gmail.com>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>" if the ssh key is encrypted
Date: Thu, 22 Mar 2012 20:48:56 +0800
Message-ID: <03324BD2-116A-42EF-AB18-38F4A30A1115@gmail.com>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl> <4F6B16BE.1050003@viscovery.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 13:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAhRY-0008FS-PH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 13:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab2CVMsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 08:48:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40825 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757919Ab2CVMsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 08:48:35 -0400
Received: by yhmm54 with SMTP id m54so1659887yhm.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=xXRsAOaXThwgtEkbB886QTrgSuqHas8ksYnL2DlgFh4=;
        b=wrDzCGmy7iv+Cg/YWGfSFEU/AzCRIUbkbeIXIrxR/+3M/c8xbMPB4KHkb4dAPj88jJ
         3ueprFSXpKfjpzvM72eupudyhBl2cxjbHmSDBOhSrsw3y5GFZOq90hEvKtFfxjTQ6UIJ
         dCL8NPq9ql8/OZe8HBxGQfWUKFGZv9bQsbO/EIwUS0v+PMWfmhluhG+Xpg8V0ThxJHUJ
         y4ZzGaNv96V208eHR5j6Iiwkqf6dokoU17tvTGKadRyte3P50jnJHoGkxFf3ypQ12v+J
         XUHH7NXgi/ge3vd2EeHVkCNl7vaLQMrPdH+rsYP/tgtrwyV1sMDjVqW6EgwmZsq1hdpP
         yRjw==
Received: by 10.50.46.162 with SMTP id w2mr1390825igm.21.1332420514894;
        Thu, 22 Mar 2012 05:48:34 -0700 (PDT)
Received: from [192.168.1.101] ([202.38.85.126])
        by mx.google.com with ESMTPS id mi10sm1894452igc.8.2012.03.22.05.48.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 05:48:33 -0700 (PDT)
In-Reply-To: <4F6B16BE.1050003@viscovery.net>
X-Mailer: iPhone Mail (9A406)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193651>



On Mar 22, 2012, at 20:10, Johannes Sixt <j.sixt@viscovery.net> wrote:

> Am 3/22/2012 11:28, schrieb Zbigniew J=C4=99drzejewski-Szmek:
>> On 03/22/2012 07:04 AM, Hong Xu wrote:
>>> Hello everyone,
>>>=20
>>> If my ssh key is encrypted, "git pull origin mas<tab>" will give a
>>> unexpected result, something like this:
>>>=20
>>> git pull origin masEnter passphrase for key '/home/user/.ssh/id_rsa=
':
>>>=20
>>> I know maybe it is not possible to complete the "master", but maybe=
 it
>>> is better to not complete anything than append something like that?
>> It is ssh itself which emits this message. The completion script cal=
ls
>> 'git ls-remote origin', which in turn invokes ssh. Typing the passwo=
rd in
>> actually works, but I understand that you are annoyed by the message=
=2E
>>=20
>> I don't think there's an easy way to silence this in git completion,
>> without affecting other times when the key would be requested. E.g. =
we
>> would want ssh to ask for the key while doing 'git pull', but not wh=
en run
>> automatically during completion.
>>=20
>> Maybe git-ls-remote should learn --quiet?
>=20
> No. IMHO, bash completion stretches too far by asking the remote for =
the
> refs that it has.
>=20

I agree with this rather than using silent mode. If a encrypted key is =
found, I think we better drop the completion. I don't know whether ther=
e is a way to implement this yet, at least we can try to find it.

Hong