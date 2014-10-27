From: Richard PALO <richard@netbsd.org>
Subject: git ls-files -o seems to ignore .gitignore
Date: Mon, 27 Oct 2014 07:16:49 +0100
Message-ID: <544DE351.9060800@netbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 07:17:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XidcK-0005P8-8p
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 07:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbaJ0GRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 02:17:20 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:32070 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbaJ0GRT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 02:17:19 -0400
Received: from [192.168.0.6] (unknown [78.228.114.66])
	by smtp4-g21.free.fr (Postfix) with ESMTP id F0CF74C8054
	for <git@vger.kernel.org>; Mon, 27 Oct 2014 07:15:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; SunOS i86pc; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm having an issue in that 'git ls-files -o' seems to ignore
[parts of] .gitignore whereas other commands, such as 'git status'
seem fine.

Here is an example:
> richard@omnis:/home/richard/src/pkgsrc$ export LANG=C 
> richard@omnis:/home/richard/src/pkgsrc$ git --version git version
> 2.1.2 richard@omnis:/home/richard/src/pkgsrc$ cat .gitignore 
> pkgchk*.conf* .#* README*.html 
> richard@omnis:/home/richard/src/pkgsrc$ git status On branch dev
> 
> It took 6.82 seconds to enumerate untracked files. 'status -uno' 
> may speed it up, but you have to be careful not to forget to add 
> new files yourself (see 'git help status'). nothing to commit,
> working directory clean richard@omnis:/home/richard/src/pkgsrc$ git
> ls-files -o |grep -c README 12393

Known issue?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJUTeNRAAoJECAB22fHtp27hckH+wdDHV3oZqatSIqNdhUCUxsJ
jR8tZpQxoKfV944aPBgH4/CXkCtFFSvnGKfH+plij+Y5ggZwfDQ3lXIg1qOsH3qj
9mvudRuFxwujXfFSTHdReqQxFT8p3roZjB0GdwoiFeBIsQ8CLfGjxfQZDQU18i3/
IfR682UbzuiR6kodhD5oX/I2S5l5dRRuabQq5t2zJL9BHmGleLaBgOjnne7T26PC
JpNMt+60J93J9VzBN9kQABAO5BMUE4mN6g2141N9JXlMsg6DSGHPN5vQD7t7IxE1
mtNX9iMrjFa1Hsm2neXqvjb95ZGbZwTnxFcI7To6P3V/+v9QMpKrrBWu/AFNdF0=
=84q1
-----END PGP SIGNATURE-----
