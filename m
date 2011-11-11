From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 16:04:03 -0500
Message-ID: <CAPZPVFakJjNexiTrDh9nQ34Ow9E-XmrVtrEmcnGtGP9kZwwL9g@mail.gmail.com>
References: <1321044904175-6986736.post@n2.nabble.com>
	<CAPZPVFb-VbTfkuyg4KtTsaWiNvd37GHeH7crPtqv1fKRbwuyfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 22:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROyGg-0003mV-Ok
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 22:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205Ab1KKVEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 16:04:06 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54853 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab1KKVED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 16:04:03 -0500
Received: by gyc15 with SMTP id 15so3299752gyc.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=POzqSbcsljMysz66dZePFJRnHPamoSafNwc/lCf/dGI=;
        b=loJj4u9tabkUueepCoYstlQbLMVIrZdZJG6wdAqcTJFNyiPbB1Xv4mt8WCclCLsNp2
         9WqTimn7gosRHIJCAroCew0g4AT5u6379BhnB6y2tKTuZ75kKCspVrE5vQjVp0FOMBoL
         RowWcfvknPfSVwswarC6fVkB3PzjmX1QdC+RA=
Received: by 10.50.169.97 with SMTP id ad1mr14615945igc.35.1321045443204; Fri,
 11 Nov 2011 13:04:03 -0800 (PST)
Received: by 10.231.103.6 with HTTP; Fri, 11 Nov 2011 13:04:03 -0800 (PST)
In-Reply-To: <CAPZPVFb-VbTfkuyg4KtTsaWiNvd37GHeH7crPtqv1fKRbwuyfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185286>

On Fri, Nov 11, 2011 at 4:01 PM, Eugene Sajine <euguess@gmail.com> wrot=
e:
>
>
> On Friday, November 11, 2011, Jvsrvcs <jvsrvcs@gmail.com> wrote:
>> Unexpected git behaviour
>>
>> ---
>> # First create a local git repo
>>
>> $mkdir gitexample
>> $git config --global user.name "my name"
>> $git config --global user.email "me@me.com"
>> $git init
>> $git add .
>> $git commit -m 'initial commit'
>>
>> # Create/Edit an empty file
>> $vi readme.txt
>>
>> # add a single line: "this was added in the master branch."
>> $git commit -a
>>
>> # create and checkout a new branch (from master)
>> $git branch test
>> $git checkout test
>>
>> # edit the readme.txt file and do not commit
>> # add the text: =C2=A0"this was added in the test branch.", save and=
 exit
>> $vi readme.txt
>>
>> #now switch back to master
>> $git checkout master
>> $cat readme.txt
>>
>> #You will see both lines in the master.
>>
>> Question #1:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Why was this line added in the *master br=
anch?
>>
>>
>> --- even further surprising
>> In the master branch, now do a commit
>> $git commit -a
>>
>> cat readme.txt ( you will see the line in the master now that was ad=
ded in
>> the test branch )
>>
>> Question #2:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Why did this happen?
>>
>> # Now switch back to the test branch
>> $git checkout test
>> $cat readme.txt
>>
>> You will only see the one line: "This was added in the master branch=
"
>>
>> Question #3:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Why did this happen?
>>
>> and NOT the line added in that branch: "this was added in the test b=
ranch"
>> <=3D this line is gone
>>
>> What is the reason for this?
>>
>> 1) Why do I see uncommitted changes in the branches made off master =
in the
>> master branch?
>> 2) Why, if I commit them in the master, do the disappear in the bran=
ch in
>> which they were made?
>>
>> This is confusing, I would think the * master branch would be left
>> untouched. =C2=A0This would solve issue #2.
>>
>>
>> --
>> View this message in context:
>> http://git.661346.n2.nabble.com/Git-Unexpected-behaviour-tp6986736p6=
986736.html
>> Sent from the git mailing list archive at Nabble.com.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>

Possible dup, thanks to "smart" HTML filter:

 All described is absolutely expected and normal behavior for git. You =
just
 need to learn about it a bit more and understand what branch in git is=
 and
 how it works with changes in working directory.
 it is best described in here http://progit.org/book/ch3-0.html
