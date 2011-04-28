From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 09:40:08 +0200
Message-ID: <BANLkTi=VLKoKxib+_NDOJYKL-R=AZWDi6g@mail.gmail.com>
References: <4DB80747.8080401@op5.se> <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org> <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net> <7vwrif5q93.fsf@alter.siamese.dyndns.org>
 <20110427220748.GA19578@elie> <7vsjt35l84.fsf@alter.siamese.dyndns.org>
 <20110427234224.GA26854@elie> <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com> <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 09:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFLxV-0005yc-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 09:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1D1HsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 03:48:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64578 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab1D1Hrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 03:47:53 -0400
Received: by pzk9 with SMTP id 9so1519471pzk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 00:47:53 -0700 (PDT)
Received: by 10.68.39.105 with SMTP id o9mr3463665pbk.45.1303976873010; Thu,
 28 Apr 2011 00:47:53 -0700 (PDT)
Received: by 10.68.55.163 with HTTP; Thu, 28 Apr 2011 00:40:08 -0700 (PDT)
In-Reply-To: <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172321>

On Thu, Apr 28, 2011 at 4:08 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:

>>> I guess an unmanaged solution could use separate directories for ea=
ch
>>> plugin, but this would imply scanning all these paths each time you
>>> invoke git. In my view, symbolic links from a dir already
>>> GIT_EXEC_PATH to plugin directories would be a more efficient way t=
o
>>> do this.
>>
>> I think you are overanalyzing the problem
>
> I don't think so. =A0Perhaps Pau can give us his view on the
> desirability of a single directory for all plugins artifacts from a
> distribution maintainers perspective.

You are thinking too much, this is simpler than what you are trying to =
do :-)

What packages in Linux distributions do is essentially placing files
where the FHS says, i. e:

- Binaries intended to be used by an average Joe go to /usr/bin
- Binaries for internal consumption go to /usr/lib/packagename
- Libraries go to /usr/lib
- Documentation goes to /usr/share/doc/packagename
- Manual pages to go /usr/share/man/manX/command.X.gz
- etc

Define something like that inside the prefix where git is installed
and you are done. As Junio said, git already checks for git-* presence
for help, etc.

If you want to see more about package organization, go to
http://www.debian.org/Packages/unstable/ , go to that package's page
and at the bottom there is a "List of files" link. For instance

http://packages.debian.org/experimental/git
http://packages.debian.org/experimental/amd64/git/filelist

BTW, I fail to see why an "activation" step is needed. Either it is
installed or it is not.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
