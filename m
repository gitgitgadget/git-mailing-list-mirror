From: demerphq <demerphq@gmail.com>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Fri, 31 Jul 2009 15:48:21 +0200
Message-ID: <9b18b3110907310648y4178da4cs9264dc01de50426@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
	 <4A720393.6030607@lsrfire.ath.cx>
	 <9b18b3110907310304w261ee30bw8c06c6a65e936e6e@mail.gmail.com>
	 <m3hbwtrpip.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?ISO-8859-1?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	Git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 15:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWsZG-0005NE-Sg
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbZGaNye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 09:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbZGaNye
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 09:54:34 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:46651 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbZGaNyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 09:54:33 -0400
Received: by gxk9 with SMTP id 9so3720660gxk.13
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z0nPXem9pHyTN6n8lg9Iwfvwt35tPvTB1Wvpv0zvTXc=;
        b=COo9DJOwFbvURASo2UGXN8S3OY6hFDTyOMlQtSpD6sEmJSthN7/59kPeUuFQaSRfT1
         HPeVE3pYLX6ugJLyXGiLAVTCmcuc29PLWfr5Ac48BStkApmQ8UZaURC1xdvcg0Zkt4Aa
         UVRM3nbscOe2JFtSBiulrGPDG/WW8uw0Zlq9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SmuqYeCT1obZDeWn3QLjeFb1CZn5LKvVQha+9FrIKhWx4xD6r3UhDfOgetbsWE51HM
         y/ZR+DmY7sbWf0AKzRf5j5V3xB3bjhFvXWg5P6QuFZgmU9pm9sJ/GW28ZlExoO0zSLOP
         u00rcSEqVxgTEkdOk6DEAAFFTI4SIAJBfs0Fk=
Received: by 10.231.13.201 with SMTP id d9mr656189iba.35.1249048101302; Fri, 
	31 Jul 2009 06:48:21 -0700 (PDT)
In-Reply-To: <m3hbwtrpip.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124563>

2009/7/31 Jakub Narebski <jnareb@gmail.com>:
> demerphq <demerphq@gmail.com> writes:
>> 2009/7/30 Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> > demerphq schrieb:
>
>>>> So then git also would benefit from support in git-archive for add=
ing
>>>> arbitrary files to the archive during generation?
>>>
>>> Yes, and this has come up before.
>>>
>>> How about the following? =A0It's missing documentation and a test c=
ase,
>>> but you could try
>>>
>>> =A0 =A0 =A0 =A0$ git archive --add-file extra HEAD>HEAD+extra.tar
>>>
>>> or
>>>
>>> =A0 =A0 =A0 =A0$ git archive --prefix=3Da/ --add-file extra --prefi=
x=3Db/ HEAD>ba.tar
>>
>> I havent managed to try it out yet but this is pretty much exactly
>> what I was looking for. Only thought I had was that it might be nice
>> to be able to specify what name the file should be added as so that
>> you can add files to subpaths deeper than the root/root prefix of th=
e
>> tar. However for /my/ particular purposes that is unnecessary, it on=
ly
>> occurs to me as a nice to have. But if you were inclined to think
>> about extending it I was thinking an argument notation like --add-fi=
le
>> foo:bar/baz/bop might be useful.
>
> Why not use notation used by --graft-points option of mkisofs, i.e.
> "--add-file foo=3Dbar/baz/bop", where 'foo' is name in archive
> (respective to prefix if any, I think), and 'bar/baz/bop' is name in
> filesystem.
>
> The proposed notation "--add-file foo:bar/baz/bop" looks for me (see
> extended sha-1 syntax in git-rev-parse manpage) like adding file
> 'bar/baz/bop' from 'foo' tree-ish.

Whatever is most appropriate. I was just demonstrating what I had in mi=
nd.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
