From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Find out on which branch a commit was originally made) (was
 ANNOUNCE git-what-branch)
Date: Thu, 23 Sep 2010 13:26:17 +0000
Message-ID: <AANLkTinw2bWWYD7UcS8P=uDJm8p3TGuWA133+BsnZPGH@mail.gmail.com>
References: <201009222326.o8MNQJ2E022410@no.baka.org>
	<32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Seth Robertson <in-gitvger@baka.org>,
	Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org,
	Artur Skawina <art.08.09@gmail.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 15:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyloi-0004dG-2D
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 15:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab0IWN0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 09:26:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42469 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab0IWN0T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 09:26:19 -0400
Received: by gwj17 with SMTP id 17so547167gwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1lnSrlmzoa5T721010gma+W4xNlz9NqZSXf5BNroYbU=;
        b=wjpKT4B1S3thBNn7GUde1xrkABSAOBl05nEAoSvCwM8LZGIapyTSG+bEUMdbkOVI74
         EFCnO2clHCcG1ykcwY57EwUzKmiSsQz//L1nYYCJBUV0wxpHYjDox674t9D6dMlSXTq7
         v8cn5XI8KaAggiA7vvTuEHi0M1e2IML1M8jgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ebZmrVXPH4+M2v21C6Y801vSQtXt0fcNkWiTkfreVPIQTSYfPmu9qB15/GkuEAx47A
         gb7YqKbQsI/W1cxQwK3AgGMI5E8+JLaacWFq/uY2XukS4vRZH+y3Y2BExJJ01TPhDlbJ
         aICGD8h7CQDbpxLg13Fu/4q9GOs+JVi/DTwCo=
Received: by 10.150.67.4 with SMTP id p4mr2901953yba.28.1285248378111; Thu, 23
 Sep 2010 06:26:18 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 06:26:17 -0700 (PDT)
In-Reply-To: <32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156868>

On Thu, Sep 23, 2010 at 13:14, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "Seth Robertson" <in-gitvger@baka.org>
>> To: "Artur Skawina" <art.08.09@gmail.com>
>> Cc: "Stefan Haller" <lists@haller-berlin.de>, git@vger.kernel.org
>> Sent: Wednesday, September 22, 2010 7:26:19 PM
>> Subject: Re: Find out on which branch a commit was originally made) =
(was ANNOUNCE git-what-branch)
>>
>> ... I wanted something completely different. Something more
>> like: if a bug was introduced in commit X, what releases or branches
>> has it contaminated (or more positively, if a feature was introduced=
,
>> where was it made available). The simple case is figuring out on
>> which branch a commit was originally made.

> Wait... When you restate the problem that way, isn't
> git-{branch,tag} --contains the right answer? =C2=A0I'm curious how y=
ou
> (and others) would differentiate the approaches...

git-{branch,tag} *is* the right answer, the problem here was that the
original reporter wanted to *delete* the original branch, or otherwise
not make it available, but still find out what it was.

The workaround is to walk the tree from a merge commit, but I think a
better solution is to just push the refs to your topic branches
somewhere and keep them in an archive/ namespace. Then if you need to
go digging you can always add the archive as a remote and go
git-{branch,tag} --contains.
