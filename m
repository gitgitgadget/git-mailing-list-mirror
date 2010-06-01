From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 1 Jun 2010 18:00:54 +0200
Message-ID: <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	<4BF7B751.7050704@pileofstuff.org>
	<4BFB7F7F.5090407@drmicha.warpmail.net>
	<4C041656.7000008@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 18:01:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTu0-0001Q3-Mh
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 18:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab0FAQBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 12:01:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59775 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab0FAQA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 12:00:59 -0400
Received: by gwaa12 with SMTP id a12so3696042gwa.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vGDWteRo4H9eYyr6lfqTrc1FrZ3pmSHHz5KlHkNUYts=;
        b=co4rsqX8gtlR/DaPzoPDdlXILTRzMVigift8VO+afd8HRbWfsta5B4aUlaya+JRpGO
         dRmqXbL6RC405MehXbeaij2ofZ0tfEb4eBrdgtDvpdh7gv7pwhCUpxixSNLrv16LrNa1
         I8vcMERuCNsPEdaSbjXYRJ4b/YvvwRCx/rPsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RBMKCzHghB8iViFFhavMK7mhHw4cwqbgtoRX3wS3MqbuFa5yZ3nc7bugogE+GG7KkI
         q0waQWzrsJe/+S1WlEMYO29RsBtITxwCbuOCHTOsuT/orVr2u/YMHv7p8JfvKvX5vqYd
         z8RGd2poKdnG8gEv74/Dt+z206WiPKIUtbYDk=
Received: by 10.100.246.37 with SMTP id t37mr7138537anh.17.1275408057687; Tue, 
	01 Jun 2010 09:00:57 -0700 (PDT)
Received: by 10.100.34.5 with HTTP; Tue, 1 Jun 2010 09:00:54 -0700 (PDT)
In-Reply-To: <4C041656.7000008@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148134>

On Mon, May 31, 2010 at 10:04 PM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
> On 25/05/10 08:42, Michael J Gruber wrote:
>>
>> Feel free to contribute to the Git Wiki maybe at
>>
>> https://git.wiki.kernel.org/index.php/GitDocumentation
>>
>> in the "User contributed Documentation" section.
>>
>> Michael
>>
>
> Thanks for the hint - this turned into rather more than just uploadin=
g a
> PDF, and I've now finished a complete write-up here:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0https://git.wiki.kernel.org/index.php/SvnM=
igration


That's a great job!

I want to point out some difficulties I encountered switching from
Subversion to Git-SVN.
I'd like to discuss them here before, eventually, contributing them to
that page.


=3D Empty directories =3D
Git do not track directories, it tracks content. That means you'll not
get/commit empty directory in your
working tree.
Sometimes empty directory may be needed by some fancy script or
external software you use with your
project (example, ANT).

Developers should be aware of this: if they really need to create an
empty directory they can both
create it through subversion both create a "dummy" file in the
directory and commit it, if that's an option.


=3D Subversion ignore =3D
You can't control subversion ignores from git-svn. And git-svn do not
automatically synchronize with the
subversion ignores. The team should be aware of these to avoid issues.


=3D Local patch =3D
Most subversion user keeps some modified files in their local checkout
never committing it remotely.
This may be handy for some situation where you want to enable some
debug-specific feature or whatever you need.
With Git, if the file is remotely tracked (with Subversion you'll say
"already committed") you can't keep a file like that:
it will prevent you from "pushing" files to the remote repository or
checking out other local/remote branches.
You'll had to "stash" your patch and re-apply it later.

=3D local/remote branches =3D
Git-svn branches "track" the remote branches by adding a string in
each commit you "git svn dcommit" on
subversion repository. You can have many local branches tracking the
same remote subversion branch.
To start to track a new remote branch you have to "git checkout -b
localBranchName remoteBranchName",
which is not very user friendly :)

You also can't create new Subversion branches or tags with git-svn,
you'll had to use subversion directly for that.



=46eel free to correct me or better describe those issue with a
better/more friendly english.
=46eel also free to add to this list.


Regards,
Daniele Segato
