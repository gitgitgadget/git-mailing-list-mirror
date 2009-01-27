From: Fabien Thomas <thomas.fabien@gmail.com>
Subject: Re: [topgit] shared topic branch
Date: Tue, 27 Jan 2009 08:23:19 +0100
Message-ID: <111E5FDD-FC51-4DD2-9959-676003CD7A61@gmail.com>
References: <EFB70468-7900-4B22-925D-3FC5F05F951B@gmail.com> <20090126120049.GA9676@lapse.rw.madduck.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-1--816753960; micalg=sha1; protocol="application/pkcs7-signature"
Cc: martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 08:25:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRiKT-0002dK-9i
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 08:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZA0HX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 02:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbZA0HXZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 02:23:25 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:4630 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbZA0HXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 02:23:24 -0500
Received: by fk-out-0910.google.com with SMTP id f33so3003618fkf.5
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 23:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:mime-version:subject:date:references
         :x-mailer;
        bh=YQ9DVSVDzWQ6wnBhL6EATyq7U7FrMyDYvNgkOPNk78o=;
        b=hsvA/pr550OinzVeL2KlwBn7lEPvnSkqexDnr5XPU387wUnrxFZ8DKc4SElP6wkzoc
         vEMowvh8peEpQfcYie0rUKRaJiXbQOAsuhmVZmi2z5EefdVg0goOoZJCCeLStgvR4voZ
         TiqN+OONhOURxzTzv77C8evTMAe5YYWBujPmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:mime-version:subject
         :date:references:x-mailer;
        b=fnbi6mJPVYzAaPPpyy6PM2qS3CFOs+HCB+gf1vJt0u4z7QSHGdjQIu+juilBvnRLUn
         RmN4uryHeDXpI7wflwX8opm1XKNSu3BiW4PL/CrfzdXJTUBCn4rjbX9d0CGEqBnOtuag
         Sdpj080iLzqBPngXKeJf2o6BXq0TJq4rDSiIA=
Received: by 10.103.168.5 with SMTP id v5mr168614muo.77.1233041001438;
        Mon, 26 Jan 2009 23:23:21 -0800 (PST)
Received: from ?192.168.0.1? (abo-9-36-69.lil.modulonet.fr [85.69.36.9])
        by mx.google.com with ESMTPS id s11sm25249141mue.42.2009.01.26.23.23.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 23:23:21 -0800 (PST)
In-Reply-To: <20090126120049.GA9676@lapse.rw.madduck.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107321>


--Apple-Mail-1--816753960
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

>> I'm testing topgit 0.5 in a shared env. (multiple user working on  
>> same
>> patch).
>
> Sorry for the late reply!
Thanks to reply :)
>
>
>> My problem is that when i want to push my local work i'm doing
>> "git  push" that will force update the remote branch. The problem
>> is that each time master is not up to date i will push my  entire
>> master or topic branch to the remote.
>
> I do not understand what you mean. Could yo please try to give us
> more detail? git push is intended to push all local changes to the
> remote, so I don't understand what your problem is.

I'm new to topgit and to git so maybe there is something i've  
misunderstood:

on the git side:
the + will overwrite all remote location branche named with that  
pattern ?

on topgit:
i'm just doing patches on two computer (home+work) and i'm pushing on  
a central repo to "backup/share my changes"
if i'm not up to date and i start a push with the "+" will overwrite  
the central repo with my local branch. (overwrite of my central repo  
master branch and my topics)

to "solve"  my problem i've replaced  the remote section with this:
[remote "origin"]
     url = ssh://git@xxx.com
     fetch = refs/heads/*:refs/remotes/origin/*
     fetch = refs/top-bases/*:refs/remotes/origin/top-bases/*
     push = refs/top-bases/*:refs/top-bases/*
     push = refs/heads/topic/*:refs/heads/topic/*

is it more clear?



--Apple-Mail-1--816753960
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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

--Apple-Mail-1--816753960--
