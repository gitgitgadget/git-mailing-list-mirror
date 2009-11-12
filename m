From: Niko Schwarz <niko.schwarz@googlemail.com>
Subject: Re: git svn show-ignore bug?
Date: Thu, 12 Nov 2009 20:55:41 +0100
Message-ID: <b198ecc80911121155u71b14a3cg91204a1196d789ce@mail.gmail.com>
References: <01C132B1-3CEE-4EF2-A4BC-5C1D71088FBF@gmail.com> 
	<20091112184155.GA4390@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 20:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8fm4-0003QX-3q
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 20:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZKLTz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 14:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbZKLTz5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 14:55:57 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:9462 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbZKLTz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 14:55:56 -0500
Received: by ey-out-2122.google.com with SMTP id 9so687129eyd.19
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 11:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GOqncrd120ZR0ilT9L8DWXL3aORdxfmhz7+MEwBqv8A=;
        b=Ar+4vUpIAQOPWBrgvv+04zfXY2CjMquZdPXDONxjquM7U9UUXp+9xcNJa4g2EGmJy2
         qbgCGHUlpI5aKeBudGVMLediJq1Y2GWozduG9OnnRVDOHySjfa9pFpmNPSTnUwQWhY+l
         DhxZhpxz3qJfyY4Zvkoq03zdlJeHh5McrX7Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DeSUfISH6XCsaeolB+BsymJ4rQiT393BZB8DNkGYuA+bXlzr7fFCPYQbrkX/muMzwR
         CVTWkaCn0r9ACGe/dbqPnGTImczIi1PMusUKvH5Kl48iWgQNh0LdwQwpdF047TOz/w0d
         4+pOxJYX0W5+qNvbFYza9jnOymwtypbJeVhq8=
Received: by 10.213.2.81 with SMTP id 17mr2724485ebi.45.1258055761077; Thu, 12 
	Nov 2009 11:56:01 -0800 (PST)
In-Reply-To: <20091112184155.GA4390@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132794>

Hi,

so I spoke to the SVN admin and he says that possibly the repo has
been corrupted a while ago. The command you asked me to run fails, it
can't authenticate. That command was svn pg -R svn:ignore
https://www.iam.unibe.ch/scg/svn_repos.

Some old version in the repo may be corrupt and I didn't get the detail=
s.

So, well, I guess it's nothing you can do :)

Niko

On Thu, Nov 12, 2009 at 7:41 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Niko Schwarz <niko.schwarz@googlemail.com> wrote:
>> Hi there, in the IRC channel today, someone asked me to report this
>> behavior to you because they suspect a bug in show-ignore.
>>
>> Ok, so here's the output of git svn info:
>>
>> Path: .
>> URL: https://www.iam.unibe.ch/scg/svn_repos
>> Repository Root: https://www.iam.unibe.ch/scg/svn_repos
>> Repository UUID: 54883e8d-cf1d-0410-83d6-f114b9419f37
>> Revision: 29639
>> Node Kind: directory
>> Schedule: normal
>> Last Changed Author: oscar
>> Last Changed Rev: 29639
>> Last Changed Date: 2009-11-12 11:22:35 +0100 (Do, 12 Nov 2009)
>>
>>
>> I can do git svn rebase, git svn fetch, and those things work. Dcomm=
it,
>> works, too. But git svn show-ignore >> .gitignore does not work.
>
> Hi Niko, this is really strange, especially when dcommit works.
>
>> This is the dialog with the system:
>> Nikos-Mbp-3:svn_repos niko$ git svn show-ignore >> .gitignore
>> Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion
>> Repository
>> Password for 'schwarz':
>> Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion
>> Repository
>> Username: schwarz
>> Password for 'schwarz':
>> Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion
>> Repository
>> Username: schwarz
>> Password for 'schwarz':
>> Autorisierung schlug fehl: PROPFIND von =BB/scg/svn_repos/IAM=AB:
>> Autorisierung schlug fehl: Could not authenticate to server: rejecte=
d
>> Basic challenge (https://www.iam.unibe.ch) at /opt/local/libexec/git=
-
>> core/git-svn line 2276
>>
>>
>> That's all the info I have, I'm afraid. I'm sure that the password i=
s
>> correct, as it works from XCode.
>
> Which version of git is this? =A0Are you in contact with the SVN serv=
er
> administrator? =A0Maybe they can look at server logs for you.
>
> Also, can you try the following command with plain svn?
>
> =A0svn pg -R svn:ignore https://www.iam.unibe.ch/scg/svn_repos
>
> Thanks. =A0Also, if anybody else there can help look into this it wou=
ld be
> greatly appreciated, my authentication knowledge is still a bit on th=
e
> weak side.
>
> --
> Eric Wong
>
