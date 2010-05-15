From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Sat, 15 May 2010 18:34:54 +0530
Message-ID: <AANLkTilxlnUdfGEvpsaIKm3waSTGH_jUG9pW8ozc1PUJ@mail.gmail.com>
References: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com>
	 <201005141707.26416.jnareb@gmail.com>
	 <AANLkTikDA1z9WiRa0Jt3vN0h1Zyq74uupqy14iVW3I7C@mail.gmail.com>
	 <201005151449.31609.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 15:14:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODHCQ-00026c-Fd
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 15:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0EONE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 09:04:56 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:38268 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab0EONEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 09:04:55 -0400
Received: by ywh36 with SMTP id 36so1695353ywh.4
        for <git@vger.kernel.org>; Sat, 15 May 2010 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KOlNrE1y8GDqPMzRUk2sNZHeqnGGK1pQ8xtq9imilhU=;
        b=NftnyZZ6RdvP6OdMN0DV7Mk+6TZp2fmpyHWk7eGuhNigi/QKKTPDhuRC9HSZdVpw7y
         Ft/zMlFl5PtZPNYfzwZ17lSaPVuBNYRIDr1nnmw0fBOS52xLv3AZwoEosEDvmc4n8wT6
         cppfwbuiwBBxOQ0CFVdy9rfegIWMQy8RBEr/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LaisW6uvqE3Icoc3WutJ/hqEfonm4a3/oN3N6ih4NEkQ+PbP9LoPIFsuUfu864DHOr
         oxEjUflDueu79B6k6NP1iLGK5ifWsTH6YT32LCfx26L2G7SmRnOY40nGZEry6UdXQT0g
         4Iog5b2hcAaH7D8gG4gttCcVpVtv57Gnx7TC0=
Received: by 10.90.19.23 with SMTP id 23mr1247105ags.8.1273928694889; Sat, 15 
	May 2010 06:04:54 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Sat, 15 May 2010 06:04:54 -0700 (PDT)
In-Reply-To: <201005151449.31609.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147150>

>
> As I said, I agree with the reasoning and the fact that patch is spli=
t
> into two. What I disagree with is the splitting itself.
>
> Making 'install-gitweb' prerequisite to 'install' target, or in other
> words adding installing gitweb *somewhere*, should in my opinion by i=
n
> this second patch.
>
>> I choose Makefile rather than choosing gitweb/Makefile becuase
>> git-instaweb is a package of git not a package of gitweb. So, I choo=
se
>> Makefile rather than choosing gitweb/Makefile.
>
> This is important fact; the description that 'gitwebdir' has default
> value set (also) in Makefile because of the future change to the way
> git-instaweb is build / installed should be in commit message of a ne=
w
> first patch.
>
>
> BTW. if 'gitwebdir' would be set to some default value both in Makefi=
le
> and in gitweb/Makefile, then in gitweb/Makefile the "?=3D" operator m=
ust
> be used (set if undefined).
>
> Note that default value in Makefile can be "$(sharedir)/gitweb", and =
in
> gitweb/Makefile can be '/var/www/cgi-bin'.
>
> [...]
>> > Two things.
>> >
>> > First, I think providing default value for 'gitwebdir' could be I =
good
>> > idea. =A0I think that all other build variables containing install=
ation
>> > directories have default values. =A0But I do wonder whether the
>> > "$(sharedir)/gitweb" is a good default value for 'gitwebdir' (see =
also
>> > comment about git-instaweb below).
>>
>> I chose it because the lib files of gitk and git-gui are being
>> installed in sharedir.
>
> O.K., I can agree with this. You might want to put this substantiatio=
n
> in the commit message, though.
>
>> > Second, the issue with git-instaweb in its current form, and split=
ting
>> > gitweb is very important. =A0I am not sure though if this is corre=
ct
>> > solution for this problem. =A0It is NOT A FULL SOLUTION, that is s=
ure.
>>
>> Yes, It is not a full solution. There is another patch that is
>> currently in discussion with my mentors.
>>
>> Petr and Christian told me to make sure that I send patches as small
>> as possibl so that they will be merged into the mainstream. That is =
my
>> GSoC aim too.
>>
>> So, I sent this small patch which just installs gitweb with git's
>> "make install" without breaking the git-instaweb.sh script.
>> The patch for modifying git-instaweb will be sent soon to his mailin=
g list.
>
> That is a good practice, and a good idea.
>
> My complaints are about putting too much in this first patch (I think
> that making 'install' target install gitweb should be put in the comm=
it
> that changes git-instaweb, as those two changes have to be
> synchronized), and about that commit message seems to claim that this
> commit does more than it really does.
>
> --
> Jakub Narebski
> Poland
>

So, what I need to do in this patch is add default values. Not
installing in 'install' target. ??
Or any thing else.

If you could specify what needs to be done, I will be happy resend the =
patch.

- Pavan
