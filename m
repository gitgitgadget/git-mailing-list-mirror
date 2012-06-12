From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCHv3 3/6] Test file for git-remote-mediawiki clone
Date: Tue, 12 Jun 2012 15:58:48 +0200
Message-ID: <4FD74B18.7080205@ensimag.imag.fr>
References: <4FD654C8.6040208@ensimag.imag.fr> <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339446526-22397-3-git-send-email-simon.cathebras@ensimag.imag.fr> <20120611230720.Horde.Xx4mVHwdC4BP1l4IcI6RWrA@webmail.minatec.grenoble-inp.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	charles.roussel@ensimag.imag.fr, gitster@pobox.com, peff@peff.net,
	Simon Perrat <simon.perrat@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 15:59:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeRci-0000m4-NM
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 15:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab2FLN7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 09:59:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43407 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab2FLN7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 09:59:02 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5CDngZQ007137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 15:49:42 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5CDwmAJ028979;
	Tue, 12 Jun 2012 15:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120611230720.Horde.Xx4mVHwdC4BP1l4IcI6RWrA@webmail.minatec.grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 12 Jun 2012 15:49:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CDngZQ007137
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340113787.35797@hiowj5dbqz+3tzMzXTFMXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199784>



On 11/06/2012 23:07, konglu@minatec.inpg.fr wrote:
>
> Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =E9crit :
>
>
>> +test_expect_success 'Git clone creates the git log expected with on=
e=20
>> file' '
>> +    wiki_reset &&
>> +    cd '"$TRASH_DIR"' &&
>> +    rm -rf mw_dir &&
>> +    wiki_editpage foo "this is not important" false -c cat -s "this=
=20
>> must be the same" &&
>> +    git clone mediawiki::http://localhost/wiki mw_dir &&
>> +    cd mw_dir &&
>> +    git log --format=3D%s HEAD^..HEAD > log.tmp &&
>> +    echo "this must be the same" > msg.tmp &&
>> +    diff -b log.tmp msg.tmp &&
>> +    cd .. &&
>> +    rm -rf mw_dir
>> +'
>> +
>
> It's best not to chdir around outside a subshell (same comment for al=
l=20
> the
> other tests)

Thanks, we managed to change these problems of chdir.

>
> BTW, please be aware of the whitespaces (the first 5 parts of your=20
> patch are
> full of it - couldn't apply the last one because of the special=20
> characters, maybe
> something that i haven't configure, i don't know).
>
>
Got it. We modified this issue with whitespaces.
In addition, we know what prevented you to install the last patch:=20
encoding problem. It will be fixed in the next update.

Simon


--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
