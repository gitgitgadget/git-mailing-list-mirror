From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: git-completion.tcsh and git-completion.zsh are broken?
Date: Wed, 09 Jan 2013 20:17:11 +0100
Message-ID: <50EDC237.3000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt19z-0007Lu-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab3AITRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:17:40 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:32877 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435Ab3AITRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:17:39 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so1174837wgb.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 11:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=FQtW3h0q2I9yMFVSN2YBlnHcB5QfnCzs2JATJGRwhSM=;
        b=YYjSSA5+K5EEWnx78/z2L1pocgtZeylsbPGlEfqm5xudMW35gE3ob7L75tq43OxwuD
         5nxO5chhwq4FfmwssReRvtiduaGhgBe2vt8urdmFEjzUttUpz2Pps6wSOyyzGTdqZMZF
         AIQAI6/D9WxOVjf0i/cjWOMGDmKDNAasCLbiv99EqtBZcKMLedyo6o90JtRZGpW3P9Vl
         pgee1or9dKaQVi6j2ZOiZGUFrTveo/7eKrGREtqCEUuyKIr4sKSMzDBVM26OsIH7iYYh
         B6pI0G+dO3+Culg/CGAR4cwkZ7jaWxkOWU4q0HtMlejO8CUXC7of7DJU4OyBu87KmD2U
         NpHA==
X-Received: by 10.180.72.232 with SMTP id g8mr5203017wiv.0.1357759054104;
        Wed, 09 Jan 2013 11:17:34 -0800 (PST)
Received: from [192.168.0.3] ([151.70.196.34])
        by mx.google.com with ESMTPS id hu8sm5155540wib.6.2013.01.09.11.17.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jan 2013 11:17:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213081>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I have finally resolved all the problems with my path completion in
git-completion.bash and, in order to avoid regressions, I'm checking the
git-completion.zsh and git-completion.tcsh scripts, since they use the
bash completion support.

I have installed (Debian 6.0.6):
* zsh 4.3.10 (i686-pc-linux-gnu)
* tcsh 6.17.02 (Astron) 2010-05-12 (i586-intel-linux)
  options wide,nls,dl,al,kan,rh,nd,color,filec

Note that I'm using my modified git-completion.bash script.


zsh compatibility support in git-completion.bash seems to "work" (I just
get a segmentation fault ...), however I have problems with the .zsh and
.tcsh scripts.


$zsh
synapsis% source contrib/completion/git-completion.zsh
(anon):6: command not found: ___main
_git:11: command not found: _default

I have disabled compinit autoload (since, I don't know how, it is able
to find the git completion script)


$tcsh
synapsis:~/projects/git/contrib/git> source ~/.git-completion.tcsh
synapsis:~/projects/git/contrib/git> git show HEAD:<TAB>

does not show the file list for the tree object in the HEAD

another problem is that a space is added after a directory name.


Another problem with zsh:

$zsh
synapsis% git show HEAD:<TAB>569GPXZims

I don't know where that 569GPXZims came from.


Can someone else confirm these problems?


Thanks  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDtwjcACgkQscQJ24LbaURpuACfVQnoBC3tzvxB0JYxQ5aL3rmN
8GEAnA7OjVtPqz+aq/PGtNtTHWgFqhKK
=3UdZ
-----END PGP SIGNATURE-----
