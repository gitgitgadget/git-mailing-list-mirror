From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 2/6] Test environment of git-remote-mediawiki
Date: Wed, 13 Jun 2012 10:10:31 +0200
Message-ID: <4FD84AF7.20105@ensimag.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr> <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr> <vpqtxyfk5l8.fsf@bauges.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 13 10:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seif9-0001x8-OV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 10:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab2FMIKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 04:10:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51478 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab2FMIKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 04:10:39 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5D81KC2001309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2012 10:01:20 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5D8ATGW008440;
	Wed, 13 Jun 2012 10:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <vpqtxyfk5l8.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Jun 2012 10:01:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5D81KC2001309
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340179282.48475@ZQo2rFSTYiTwTlr7FtAsRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199880>



On 13/06/2012 09:56, Matthieu Moy wrote:
> Simon Cathebras<simon.cathebras@ensimag.imag.fr>  writes:
>
>> +# Check the preconditions to run git-remote-mediawiki's tests
>> +test_check_precond () {
> This is a very generic name (with risk of name clash in future versio=
ns
> of test-lib.sh). This checks the git-mediawiki preconditions, so how
> about test_check_wiki_precond?

I agree with that.

>> +	if ! test_have_prereq PERL
>> +	then
>> +		skip_all=3D'skipping gateway git-mw tests, perl not available'
>> +		test_done
>> +	fi
>> +
>> +	if [ ! -f $GIT_BUILD_DIR/git-remote-mediawiki ];
> "" around $GIT_BUILD_DIR
>
> But why $GIT_BUILD_DIR ? git-remote-mediawiki usually doesn't go ther=
e,
> it is either as source in contrib/, or installed in the $PATH.

Indeed, I developped this code and I have missunderstood the behavior o=
f=20
contrib. It will be fix in the next patch by tonight.

>> +	then
>> +		skip_all=3D'skipping gateway git-mw tests, no remote mediawiki fo=
r git found' \
>> +		'please try: cp git/contrib/mw-to-git/git-remote-mediawiki git/'
> Don't you have a "make install" target for that now?

Yes we have. We shall correct it by tonight.

>
> +	$CURR_DIR/test-gitmw.pl getallpagename
>
> Here and elsewhere, "" around "$CURR_DIR"
>
Got it, thanks =3D).

Simon C

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
