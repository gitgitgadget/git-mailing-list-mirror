From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Cloning from sites with 404 overridden
Date: Sun, 19 Mar 2006 11:52:05 +0100
Message-ID: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 19 11:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKvW8-0000aN-OP
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 11:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWCSKwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 05:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWCSKwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 05:52:09 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:43243 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932068AbWCSKwI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 05:52:08 -0500
Received: by zproxy.gmail.com with SMTP id 13so943162nzp
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 02:52:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d7kcx//KZb82sCDG+9W5PTkYhfwd/e3gsnqikn93biXxxzbHXaea0q3q91EDbIMEbhl9vHSZRtysc5yod7k5Rn/PA09yYYGkeWZH5UitdH/uNrXyoU49itERq1EDoB+o4PadvtCYzKmYdcOJm3GKCpWMN/Xi8kHrLvrcqQQkCPU=
Received: by 10.65.188.19 with SMTP id q19mr1050856qbp;
        Sun, 19 Mar 2006 02:52:05 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 02:52:05 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17713>

Hi all,

    I have set a git repository on a hosted public site:
http://digilander.libero.it/mcostalba/scm/qgit.git

I cannot run any process (read git-daemon) on that site, so git-clone uses
a 'dumb server' type protocol and this is what I got.

$ git clone http://digilander.libero.it/mcostalba/scm/qgit.git
error: File 8dea03519e75f47da91108330dde3043defddd60
(http://digilander.libero.it/mcostalba/scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60)
corrupt
Getting pack list for http://digilander.libero.it/mcostalba/scm/qgit.git/
Getting index for pack fe1f3586b38e70e963de47f31379ef170adc5ca9
Getting pack fe1f3586b38e70e963de47f31379ef170adc5ca9
 which contains 8dea03519e75f47da91108330dde3043defddd60
walk 8dea03519e75f47da91108330dde3043defddd60
walk ec47dab590fb838ba2be7af5bf9aa46d9f2e502d

-------------- cut ------------------------

walk 907d47e836f4f174386d02d21e38aeafc1e79626
walk 5d3454248bbb3aaba080057dc9666a3c3aaeca1f
$

The above mentioned error belongs to git requests a non existing object
(8dea03519e75f47da91108330dde3043defddd60) _and_  the site answers with
a pre-canned 'page not found' html page instead of reporting 404 error.

After some research I found it is quite common for public hosting
sites to use a pre-canned
'Sorry, no page here' html stuff instead of 404.

So my request is if it is possible for git to _learn_ this and to
avoid been fooled by
these kind of public sites.

Thanks
Marco
