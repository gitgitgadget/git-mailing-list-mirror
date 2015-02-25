From: Eugene Fedorov <jek.fdrv@gmail.com>
Subject: Re: About checkout with untracked files on remote.
Date: Wed, 25 Feb 2015 21:45:08 +0200
Message-ID: <DEA06477-4036-4941-A0C6-CF3D5DB15C96@gmail.com>
References: <F195C0CF-55E5-40AE-B5E1-7CA6D46DF3A6@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 20:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQhtd-0002i8-E8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 20:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbbBYTpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2015 14:45:14 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35451 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbBYTpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2015 14:45:12 -0500
Received: by lbjb6 with SMTP id b6so6257651lbj.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=4RI8GfxBVTCGad9U8TF7WHKFgBLmJ7l6qu6NSeGmrNk=;
        b=RYasKVBiRbHDtC7LzonHeKltkh1WYNM+KHVPLiaPdSAxxKssy7UtgCrVKHmAhQKMUp
         Uwr//PdLiGyI5tVuejelo3oJAf4ZweHxFIhTfoosgZ3MRpUKP8tw/7jYGpB5iitqf/N0
         eyXoCczPqqUAT2FWHznvTHx69TgcrZnwhykTfIndS5shbIrxMK/fkj8xJtgeHojnUgJk
         XQQ7cGtotkdih41DwJ1qZQpBvFpIGP2WRlXxuC9e11zkOML5R5W6Pxlk4CbgFoLGt34c
         qJxzEp4G8e3RdQMAnGF+GVSslgdGQ3Mb6p4nATHNvsHxMC3WJxjEAKRxMRDv0rKr8tXp
         YHsA==
X-Received: by 10.152.228.167 with SMTP id sj7mr4309867lac.2.1424893511309;
        Wed, 25 Feb 2015 11:45:11 -0800 (PST)
Received: from [192.168.1.102] ([46.185.122.240])
        by mx.google.com with ESMTPSA id b6sm8659025laa.14.2015.02.25.11.45.09
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 11:45:10 -0800 (PST)
In-Reply-To: <F195C0CF-55E5-40AE-B5E1-7CA6D46DF3A6@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264408>

I have specific case which you can use to improve git.

My example:
I have 2 branches - master, implement_button.
Branch implement_button add some button with few style.css and fonts fi=
les.
Both branches have same git ignore file where all fonts and css folders=
 with files ignored.

The point:
Now my active branch is implement_button.=20
1 Try to checkout to remote master branch and get error:
error: The following untracked working tree files would be overwritten =
by checkout:
css/style.css
css/fonts/RobotoSlab-Bold-webfont.eot
Please move or remove them before you can switch branches.
Aborted.

So we have case where master haven=92t new ignored files.
We can=92t use "git clean -df" bc it not clean untracked files. Bc impl=
ement_button branch it is not untracked.
I can=92t use "git clean -dfx=BB bc i need some another ignored files.
I can=92t use force checkout bc i need this files be deleted.
Also i can=92t get this error without run checkout, so or i will be che=
ckout or error. Dry-run not work for this command.  http://stackoverflo=
w.com/questions/28714372/how-to-catch-git-error-on-checkout-without-che=
ckout/28714462#28714462

So i need help understand how i can do this? Parse rendered error to ge=
t the list of files to drop and drop them?=20
Hope i can do this in another way =3D)

P.S. Thank you very much for try help me =3D)