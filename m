From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git-pull.sh: better warning message for "git pull" on 
	detached head.
Date: Tue, 7 Apr 2009 10:24:35 +0100
Message-ID: <e2b179460904070224o3057c6efk6930bd1249adb0fe@mail.gmail.com>
References: <1239052487-6936-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 07 11:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr7Zo-0007ny-Lu
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 11:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbZDGJYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 05:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZDGJYi
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 05:24:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:7943 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbZDGJYh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 05:24:37 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2642587rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R3p0MhAxUZDov0f4IO+TJA/d47JgI7NF1L6bwF57sn0=;
        b=hsq86UXCUYMEhQcGjZ9T4U+Z9GPaE4u2gbPtQ6SdZqxbWS+p3NGbiPnM7YUanZHkhN
         iCAAEZwoz30xxKarTWe39/dc1P9tX2aqt9UAjXKi1FO1Y5DjKLTmxiDy/Sg24fIHlju/
         KYpbxr+sjUTbenogx7i92t2uPzQtjRqOnxqaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ovi5Sc6egQKHIzHmlVMZgpobTS/K5DpdE9x3w1nMJJ10/k7OJZvxbwOIXeaBsv9QNX
         iDANoXcuQ8+iiySsiKIRSBpx0hTn5B3tETPTG+sajVVyKBUGFXYO+08awfSmmMkGV6AA
         /+Yvz1iRcWwXre7WWvccKDHZADKZqnCDyZSe8=
Received: by 10.141.180.16 with SMTP id h16mr1828922rvp.295.1239096275091; 
	Tue, 07 Apr 2009 02:24:35 -0700 (PDT)
In-Reply-To: <1239052487-6936-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115939>

2009/4/6 Matthieu Moy <Matthieu.Moy@imag.fr>:
> Otherwise, git complains about not finding a branch to pull from in
> 'branch..merge', which is hardly understandable.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "You asked me=
 to pull without telling me which branch you want"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "to merge wit=
h, and you are on a detached HEAD, so I cannot"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "know from 'b=
ranch.<branchname>.merge' in your configuration"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "file. =C2=A0=
Please name which branch you want to merge on the command"

'Know from' in this sense is a little confusing. Maybe something like:

s/so I cannot know from 'branch.<branchname>.merge' in your
configuration file/ \
so I cannot use any 'branch.<branchname>.merge' from your configuration=
 file

?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "your configu=
ration file does not tell me either. =C2=A0Please"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "name which b=
ranch you want to merge on the command line and"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "try again (e=
=2Eg. 'git pull <repository> <refspec>')."

I know you haven't changed this part, but as it's included in the
patch, what we're asking the user to do is to 'specify' the branch to
merge, not to 'name' it.

Mike
