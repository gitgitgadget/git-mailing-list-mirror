From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 11:54:26 -0500
Message-ID: <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
	<20111206215102.GA3654@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 17:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYKlU-0002Pe-2x
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 17:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab1LGQy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 11:54:28 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62093 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab1LGQy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 11:54:27 -0500
Received: by wgbdr13 with SMTP id dr13so1627189wgb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=IcuS6SX5y3EvSEHIx7YJBmc26u7nBpAE8quPBLay1vs=;
        b=Ssjyn8QY27sMVS8gIFf50Msen8DZElMH7iyBNoKfKINupf7GClmvT6xPi8YbugWiac
         IwMVcep+HX/Eqm5A917fhsJUJ8DX4/G3RIVVIfiEGztHytjRbTrak0T7Hd9zndVlwPVg
         KYmUnPtpw7PzNQKdubPvPiR7mqN7NZ6mCjRng=
Received: by 10.227.203.131 with SMTP id fi3mr8011594wbb.17.1323276866200;
 Wed, 07 Dec 2011 08:54:26 -0800 (PST)
Received: by 10.223.88.132 with HTTP; Wed, 7 Dec 2011 08:54:26 -0800 (PST)
In-Reply-To: <20111206215102.GA3654@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186471>

On Tue, Dec 6, 2011 at 4:51 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de>=
 wrote:
> On Tue, Dec 06, 2011 at 04:43:50PM -0500, Chris Patti wrote:
>> I have a Homebrew installed version if Git 1.7.8 running on OSX Lion=
=2E
>>
>> I'm seeing a very odd issue where these diffs I didn't create keep
>> recurring in a particular repository.
>
> Which diffs? You haven't given us any? What files does this happen
> with? Do they have any peculiarities?
>
> If these are files with non-ASCII filenames, then you're hitting a
> misfeature of the HFS+ filesystem (it lies when git asks it about
> files).
>
>>
>> I've tried:
>>
>> * Nuking the repo and re-cloning, cloning into a totally different
>> containing directory
>> * git reset --hard, git checkout -- of the offending file supposedly
>> containing the diffs
>>
>> Is there some sort of uber persistent local cache that's bound to th=
e
>> remote repository?
>
> The remote repository shouldn't have anything to do with this.
>
> =C2=A0 cmn

OK.  Let me give you a very specific series of commands, sorry about
the poor question / report (Not convinced it's a bug, probably pilot
error?)

If my understanding of the way Git works is correct, there should be
NO pending diffs in a freshly cloned repository, yes?

Note that I tried git diff and git diff -w below with identical results=
:
---
11:35][admin@Hiram-Abiff-2:~/src]$ rm -rf framework/
[11:37][admin@Hiram-Abiff-2:~/src]$
[11:44][admin@Hiram-Abiff-2:~/src]$ git clone
ssh://git.bluestatedigital.com/home/git/framework.git
Cloning into 'framework'...
remote: Counting objects: 378540, done.
remote: Compressing objects: 100% (100469/100469), done.
remote: Total 378540 (delta 261046), reused 374685 (delta 258447)
Receiving objects: 100% (378540/378540), 148.33 MiB | 2.08 MiB/s, done.
Resolving deltas: 100% (261046/261046), done.
[11:51][admin@Hiram-Abiff-2:~/src]$ cd framework/
[11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff
diff --git a/app/modules/Core/controllers/CloudSponge.php b/app/modules=
/Core/con
index 615a7b3..911d456 100644
--- a/app/modules/Core/controllers/CloudSponge.php
+++ b/app/modules/Core/controllers/CloudSponge.php
@@ -1,229 +1,71 @@
-<?php
-
-require_once "utils/blue_mailer/queue_mailer.class.php";
-
-class Core_CloudSponge_Controller extends Core_PageBase_Controller
-{
-    private $_config;
-    private $_tsFactory;
-    private $_emailValidator;
-    private $_formFactory;
-    private $_rowBuilderFactory;
-
-    public function __construct
-    (
-        Blue_Config $config,
-        Blue_SecureTimestamp_Factory $tsFactory,
-        Blue_Email_Validator $emailValidator,
-        Framework_Ui_Form_Factory $formFactory,
[11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff -w
diff --git a/app/modules/Core/controllers/CloudSponge.php b/app/modules=
/Core/con
index 615a7b3..911d456 100644
--- a/app/modules/Core/controllers/CloudSponge.php
+++ b/app/modules/Core/controllers/CloudSponge.php
@@ -1,229 +1,71 @@
-<?php
-
-require_once "utils/blue_mailer/queue_mailer.class.php";
-
-class Core_CloudSponge_Controller extends Core_PageBase_Controller
-{
-    private $_config;
-    private $_tsFactory;
-    private $_emailValidator;
-    private $_formFactory;
-    private $_rowBuilderFactory;
-
-    public function __construct
-    (
-        Blue_Config $config,
-        Blue_SecureTimestamp_Factory $tsFactory,
-        Blue_Email_Validator $emailValidator,
-        Framework_Ui_Form_Factory $formFactory,
[11:52][admin@Hiram-Abiff-2:~/src/framework(master)]$

--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
