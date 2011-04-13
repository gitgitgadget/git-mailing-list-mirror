From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: git-svn dying unceremoniously
Date: Wed, 13 Apr 2011 14:46:03 +0200
Message-ID: <BANLkTinnRwas8VSn4p+NRvrwxnVSwBRc1Q@mail.gmail.com>
References: <m2fwpov47e.wl%dave@boostpro.com>
	<20110412021202.GA17114@elie>
	<201104120850.47331.andres@anarazel.de>
	<BANLkTikeCagEiN_xU4B+TE=-9esQjWh0pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andres Freund <andres@anarazel.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:46:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9zSU-00010y-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab1DMMqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 08:46:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47781 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1DMMqF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 08:46:05 -0400
Received: by yxs7 with SMTP id 7so221796yxs.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zJlg7/TFWxUtdsquIVOuokV4aSSquFPgB7RUYOJFkz0=;
        b=q0xSabUWp/5+fbsnKtVVQBXRlLYY1MRhKmjdO4gA1scG8WgHKPXSZ4pMaqriT15mj/
         otrL6AZWyCvALG3fGlWd0QGC9UvVYPxit4V0JMO4kDyykF2Jr/JrlaBVDiwzBydQx9Rm
         E0cs0p6RWoD5udERccJT5coGb3cEOuTsTb6D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RdcoPa8LfXnzu2D6D6eq54sllCIeTO3ySujofeJWWxTo+BpxNPFBaCpSKSJ+i50x6Y
         3KxG17X11mYHgeLsv5n52G4e2t88efFbSSM6tkVTCgud4PM1gREsYa6rFWubEOP9IPtU
         YZNDLWBb3OeS6Dc7XH5J/UZ79mCBKac7xwq5g=
Received: by 10.42.161.202 with SMTP id u10mr12404472icx.160.1302698763382;
 Wed, 13 Apr 2011 05:46:03 -0700 (PDT)
Received: by 10.42.222.3 with HTTP; Wed, 13 Apr 2011 05:46:03 -0700 (PDT)
In-Reply-To: <BANLkTikeCagEiN_xU4B+TE=-9esQjWh0pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171450>

On Tue, Apr 12, 2011 at 6:02 PM, Dave Abrahams <dave@boostpro.com> wrot=
e:
> I managed to get a lot farther with
>
> =A0 while ! git svn fetch ; do sleep 1 ; done
>
> But eventually I exceeded my disk quota:
>
> error: bad index file sha1 signature
> fatal: index file corrupt
> write-tree: command returned error: 128
>

I've run into this in my git-svn clones as well. It happened once last
year. I tried this trick I found googling around:

rm -f .git/index
git read-tree --reset HEAD
git status

=2E. but it didn't help. I ended up re-doing the git svn clone. Since
then it has worked fine.
