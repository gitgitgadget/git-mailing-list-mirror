From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Generate version file by hooks
Date: Tue, 17 Mar 2009 16:43:31 +0100
Message-ID: <adf1fd3d0903170843r3649eb53tf8b22240bbc20e33@mail.gmail.com>
References: <200903171626.01102.bjoern01@nurfuerspam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Hendriks?= <bjoern01@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:53:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbbA-0002Wv-42
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbZCQPuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZCQPuv
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:50:51 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:61334 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbZCQPuu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 11:50:50 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 11:50:49 EDT
Received: by bwz17 with SMTP id 17so132464bwz.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 08:50:47 -0700 (PDT)
Received: by 10.103.169.18 with SMTP id w18mr68882muo.73.1237304611765; Tue, 
	17 Mar 2009 08:43:31 -0700 (PDT)
In-Reply-To: <200903171626.01102.bjoern01@nurfuerspam.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113485>

2009/3/17 Bj=F6rn Hendriks <bjoern01@nurfuerspam.de>:
>
> Hello,
>
> I'd like to put the SHA1 of the current commit into a source file so =
that my
> program can further process it -- put it into a log file for example.

You can look at what is done in git itself with the version number.
There is a GIT-VERSION-GEN that generates a GIT-VERSION-FILE with the
version number (it only updates the file if the version number has
changed). Then in the makefile you specify how to create it and which
programs depend on the GIT-VERSION-FILE:

GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
        @$(SHELL_PATH) ./GIT-VERSION-GEN
-include GIT-VERSION-FILE

program: GIT-VERSION-FILE

HTH,
Santi
