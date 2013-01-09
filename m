From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: git-completion.tcsh and git-completion.zsh are broken?
Date: Wed, 09 Jan 2013 21:56:58 +0100
Message-ID: <50EDD99A.5090704@gmail.com>
References: <50EDC237.3000309@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC06B99D@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090005070502090908030203"
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:57:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2ig-0000uG-OA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933951Ab3AIU5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:57:32 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47708 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190Ab3AIU53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:57:29 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1269029wgb.20
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type;
        bh=JpNrFiuzY/NzzYQ3Uu3RH5lN4BfN81zdceGyJ70QL5E=;
        b=nfRpxTWkynf1e/0uSc7uOObz88bLAEzITASUWb5K7Ddy/SI8bFVRsJc1fPH0w0nKc1
         8sQovrObFWw10xuTzOuh73yYXTml3xOS5AeuOYm1movnRPreet4XlAPx6IwKC2a0wAxH
         nCSL3OeGzrSTivtNChKD6PxBZi21i3ZgskfkTrNfLgNVA3uCy1owLveKvZkj1fKVrfWr
         xPR6UQLBeO0vGE/bBcB5ES59ATHVrxPD87Sn/ajWY8R2Y9HZpBNl2rf4jWFbMMT3Zimw
         6anr8NW8hNCqK7StqwljeRvSw7zR+0DQeTdDjf7kAW4bFWs4Zf4ENBSI7vR8fW73antZ
         3JHA==
X-Received: by 10.194.19.170 with SMTP id g10mr110980470wje.56.1357765048102;
        Wed, 09 Jan 2013 12:57:28 -0800 (PST)
Received: from [192.168.0.3] ([151.70.196.34])
        by mx.google.com with ESMTPS id s16sm6014010wii.0.2013.01.09.12.57.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jan 2013 12:57:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC06B99D@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213103>

This is a multi-part message in MIME format.
--------------090005070502090908030203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 09/01/2013 21:21, Marc Khouzam ha scritto:
> [...]
> 
> $zsh
> synapsis% source contrib/completion/git-completion.zsh
> (anon):6: command not found: ___main
> _git:11: command not found: _default
> 
> I have disabled compinit autoload (since, I don't know how, it is able
> to find the git completion script)
> 

The attached patch seems to fix it.
I'm still getting segmentation faults, but only when I try to complete
git rm contrib/<TAB> (in the git repository).

Sorry if this is a plain patch.
The code is simply copied from the one found in git-completion.bash.


I also noted that zsh on my system have preinstalled git completion
support (enabled with autoload).
The code is not the one available in the git source tree.
I don't know if the code is from Debian or zsh.

> 
> $tcsh
> synapsis:~/projects/git/contrib/git> source ~/.git-completion.tcsh
> synapsis:~/projects/git/contrib/git> git show HEAD:<TAB>
> 
> does not show the file list for the tree object in the HEAD
> 
>> Hm.  That doesn't work for me either.  I'll look into it.
>> It is not caused by your changes.
> 
> another problem is that a space is added after a directory name.
> 
>> The lastest version of git-completion.tcsh in the pu branch should
>> fix that problem.  It was committed yesterday so you may not have it.
> 

Ok, thanks.



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDt2ZoACgkQscQJ24LbaUR/ggCfYNbRrM1HzHWYDwkejNP/hD9k
ShkAnjv3JapVXPlj59CakY4kwaE/4z5J
=qYP5
-----END PGP SIGNATURE-----

--------------090005070502090908030203
Content-Type: text/x-diff;
 name="git-completion.zsh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-completion.zsh.patch"

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4577502..4aeda2a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -75,4 +75,5 @@ _git ()
 	return _ret
 }
 
-_git
+autoload -U +X compinit && compinit
+compdef _git git gitk

--------------090005070502090908030203--
