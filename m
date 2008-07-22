From: Ben Aurel <ben.aurel@gmail.com>
Subject: Error: "You have some suspicious patch lines"
Date: Tue, 22 Jul 2008 09:16:44 +0200
Message-ID: <4885895C.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 09:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLC87-0004u3-3X
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYGVHQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYGVHQv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:16:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:26678 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYGVHQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:16:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so604284nfc.21
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 00:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:sender;
        bh=0YOX5WN+CBdgANWP9XSm2eqQBbUfG5gyC1R+7QmtKBc=;
        b=H4Nv4HKzdJzj5HUdS5EDOIlql8VhBhEAbvzWhBY9W+wFaii1DPjBVTPkn2w4MP8nTj
         PyedRS870A81/ysPN2hhbnML4TBdR8c7djhdAfkhQUGNrAtW7Rq09UCXNXw35oH/cpTF
         m1rJ6LidpEOJ+edl3xs56LdFbhMD9KpfphW2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:sender;
        b=XtW9Y4wKyXePIGjS/1yiJRbrMD+x4cJUif1+HDJrG5skPZ7+dFF4exgF5qgTf4jRBI
         VnhSm/jlRbw+kU1uNacKlhGha+DwUwwzZm36siwYZBJgspfKT9WY/TE6oB/JRtOgQk3Q
         mMm79osiY0qRIvIZtuVRKC1CaFx4Lx79oScss=
Received: by 10.103.228.12 with SMTP id f12mr3304616mur.28.1216711007324;
        Tue, 22 Jul 2008 00:16:47 -0700 (PDT)
Received: from administrators-imac.local ( [80.219.229.139])
        by mx.google.com with ESMTPS id y37sm18039098mug.9.2008.07.22.00.16.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 00:16:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89454>

hi

I working on mac os x 10.5.4 (intel) with git version 1.5.5.3 and I 
always get this message for most of my perl scripts and also for 
"Makefile.pre" files:

----------- Message ---------------
* You have some suspicious patch lines:
*
* In src/scripts/trunk/3rdparty/file_sanity.pl
* trailing whitespace (line 52)
...
------------------------------------------


Editing '.git/hooks/pre-commit' and comment out the following lines 
(around line 58):

--
58            if (/\s$/) {
59                bad_line("trailing whitespace", $_);
60             }
--

I still have this message

----------- Message ---------------
$ git commit .
*
* You have some suspicious patch lines:
*
* In src/scripts/trunk/3rdparty/file_sanity.pl
* indent SP followed by a TAB (line 112)
-----------------------------------------

Editing '.git/hooks/pre-commit' and comment out the following lines
--
 61             if (/^\s* \t/) {
 62                 bad_line("indent SP followed by a TAB", $_);
 63             }
--

And finally "git commit" works again.

The question now is: Is it really necessary to edit the git script 
everytime? Is there a urgent reason why git refuses to commit because of 
"suspicious" lines? Is it really necessary?

Thanks
ben
