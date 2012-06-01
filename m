From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Fri, 01 Jun 2012 10:53:36 +0200
Message-ID: <4FC88310.2020103@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr> <1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1338397492-13360-2-git-send-email-simon.cathebras@ensimag.imag.fr> <vpqzk8oq0oe.fsf@bauges.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:53:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNc8-0006Yf-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 10:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113Ab2FAIxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 04:53:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50475 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab2FAIxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 04:53:38 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q518j8do011819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 10:45:08 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q518rVHX008716;
	Fri, 1 Jun 2012 10:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <vpqzk8oq0oe.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 10:45:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q518j8do011819
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339145112.22222@SGelblCp7f68JIbkBnIf0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198961>

On 31/05/2012 09:17, Matthieu Moy wrote:
>
>> +	result=3D$(diff -r -B -w --exclude=3D".git" "$1" "$2")
> Doesn't seem to be in POSIX:
>
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/diff.html
>
> Will this run on all platforms?
>
Indeed. According to the POSIX manual, the option -B and -w are merged=20
in the single option -b.
In addition, -r option still exists (to compare recursively two=20
directories).
The previous instruction will be write as follow :
     diff -r -b "$first_folder" "$second_folder"

With this fix, it will works on all platforms. ;)
>> +my $wiki_url=3D"http://localhost/wiki/api.php";
>> +my $wiki_admin=3D'WikiAdmin';
>> +my $wiki_admin_pass=3D'AdminPass';
> It would be nice to allow overriding these from the command-line. But=
 as
> you are now writting tests, you may as well apply the YAGNI
> principle ;-).
Does it seems important for you to overriding these from CL ?
By default, those settings work fine. You have to edit this only if you=
=20
need a special configuration. But it is purely optionnal.

   Included in v2 patches:

     * Fixing errors pointed above.
     * Sqlite file excluded from the patches. Mainly with reviewing the=
=20
wiki_install script.

On the other hand, considering the git-mediawiki is curently on contrib=
=20
branch, shall we move our test environement from git/t to git/contrib/t=
 ?

SimonC

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
