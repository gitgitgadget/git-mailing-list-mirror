From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Mon, 04 Jun 2012 16:13:00 +0200
Message-ID: <4FCCC26C.1050304@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr> <1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr> <1338547317-26088-2-git-send-email-guillaume.sasdy@ensimag.imag.fr> <vpqmx4n9rq6.fsf@bauges.imag.fr> <4FC8D501.20207@ensimag.imag.fr> <vpqipfa9ehx.fsf@bauges.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	git@vger.kernel.org, Charles Roussel <charles.roussel@ensimag.fr>,
	Simon Perrat <Simon.Perrat@ensimag.imag.fr>,
	Charles Roussel <Charles.Roussel@ensimag.imag.fr>,
	Julien Khayat <Julien.Khayat@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 16:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbY1v-0005P6-LG
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 16:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2FDONG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 10:13:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40591 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2FDONF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 10:13:05 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54E4KBc019895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 16:04:20 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q54ED0p2013074;
	Mon, 4 Jun 2012 16:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <vpqipfa9ehx.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 16:04:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54E4KBc019895
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339423462.38839@tmSCCsp6LuAmb2JMALGDFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199138>



On 02/06/2012 12:47, Matthieu Moy wrote:
> "Simon.Cathebras"<Simon.Cathebras@ensimag.imag.fr>  writes:
>
>>>> +wiki_getpage () {
>>>> +	../test-gitmw.pl get_page -p "$1" "$2"
>>>> +}
>>> Any reason why test-gitmw.pl and wiki_getpage have this slightly
>>> different API? The perl version has a "-p" flag, and the shell comm=
and
>>> has only positionnal arguments.
>> The "-p" flag exists to specify if we have to use the admin login on
>> wiki to do the command.
> (then, maybe --admin would be a better name?)
>
I am ok with this... It would be more understandable.
>> For instance, here we fetch a page from the wiki with Admin privileg=
e.
>> Others arguments remains the same.
> What I don't understand is why you need the flexibility to choose
> between admin and non-admin on the Perl side, and you don't need in o=
n
> the shell side.
>
On one hand, we need to be authentificated as an admin to do some wiki'=
s
operations, like deleting a page for instance. It is needed by the Perl=
=2E
On the other hand, we don't need it on the shell side because we believ=
e
that we don't have to bother the user with some authentification
consideration.
I mean, if I intend to delete the page <foo> from wiki, it is easier to
call 'wiki_delete_page foo', than  'wiki_delete_page --user=3Dthingumy
--pass=3Dblahblah foo'.
Does it make sense ? If not, what do you think we should do ?

Simon

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
