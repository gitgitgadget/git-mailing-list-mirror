From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH 05/18] Turn double-negated expressions into simple expressions
Date: Fri, 07 Jun 2013 19:04:31 +0200
Message-ID: <51B2129F.3040304@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr> <1370547263-13558-6-git-send-email-celestin.matte@ensimag.fr> <CAPig+cSDxhT=WVMQz_88z0xEmPVENDSyp5mE7XWCf_99yQTkTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul05j-0004Pf-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab3FGREj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 13:04:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46674 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab3FGREi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:04:38 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r57H4TrQ028151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 19:04:29 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57H4Uu3016737;
	Fri, 7 Jun 2013 19:04:30 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57H4Uod020101;
	Fri, 7 Jun 2013 19:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAPig+cSDxhT=WVMQz_88z0xEmPVENDSyp5mE7XWCf_99yQTkTA@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jun 2013 19:04:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57H4TrQ028151
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371229472.56345@sxrFnvwayoOPrrwaJfwZWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226649>

Le 07/06/2013 06:12, Eric Sunshine a =E9crit :
> On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
> <celestin.matte@ensimag.fr> wrote:
>> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
>> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> ---
>>  contrib/mw-to-git/git-remote-mediawiki.perl |    8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/m=
w-to-git/git-remote-mediawiki.perl
>> index 68fd129..a6c7de2 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
>> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -136,16 +136,16 @@ while (<STDIN>) {
>>         if (defined($cmd[0])) {
>>                 # Line not blank
>>                 if ($cmd[0] eq "capabilities") {
>> -                       die("Too many arguments for capabilities\n")=
 unless (!defined($cmd[1]));
>> +                       die("Too many arguments for capabilities\n")=
 if (defined($cmd[1]));
>>                         mw_capabilities();
>>                 } elsif ($cmd[0] eq "list") {
>> -                       die("Too many arguments for list\n") unless =
(!defined($cmd[2]));
>> +                       die("Too many arguments for list\n") if (def=
ined($cmd[2]));
>>                         mw_list($cmd[1]);
>>                 } elsif ($cmd[0] eq "import") {
>> -                       die("Invalid arguments for import\n") unless=
 ($cmd[1] ne "" && !defined($cmd[2]));
>> +                       die("Invalid arguments for import\n") if ($c=
md[1] eq "" || defined($cmd[2]));
>>                         mw_import($cmd[1]);
>>                 } elsif ($cmd[0] eq "option") {
>> -                       die("Too many arguments for option\n") unles=
s ($cmd[1] ne "" && $cmd[2] ne "" && !defined($cmd[3]));
>> +                       die("Too many arguments for option\n") if ($=
cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
>=20
> Not new in this patch, but isn't this diagnostic misleading? It will
> (falsely) claim "too many arguments" if $cmd[1] or $cmd[2] is an empt=
y
> string. Perhaps it should be reworded like the 'import' diagnostic an=
d
> say "Invalid arguments for option".

We could even be more precise and separate the cases, i.e., die("Too
many arguments") when too many arguments are defined and die("Invalid
arguments") when there are empty strings.
Not sure if I should integrate it in this patch, though.


--=20
C=E9lestin Matte
