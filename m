From: Jonathan Leto <jaleto@gmail.com>
Subject: Help with a possibly corrupt repo
Date: Mon, 10 May 2010 12:37:36 -0700
Message-ID: <AANLkTiks5g7BvLXBrUcb0m5dCiIrBifjDUKBDScXd1dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 21:38:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBYng-0001hX-Rv
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 21:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab0EJThx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 15:37:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55995 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab0EJThw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 15:37:52 -0400
Received: by gwj19 with SMTP id 19so2192492gwj.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Y8LcSizHHBEcLVFLXOaBbnJg4bUifzno/fVMStgAZLk=;
        b=XvjQacqBSGnyWYVjSxRL7XQt8JDDiDXkJXftua83UT+J7lg5Jb9orLQoXOKpuaupzt
         Kr+WNw5X6j2xVQvHaQ3qYp4bTp6WO8hw6a1m9cno8jeU8qP4HVhjsoskVHvGwaa0WX4p
         7Pzd1X7fICK1JJMfW4G6XYnnIvWCx+K84NsW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=WW4V7D/wQ5rSnICxVtxzPi/ALeqJF71V0BlHSIyjLm6O7TGllWkygrBAiP6otpmJdQ
         RYFhzjOqCY+o0fMT9dBo7WI7HBk3ZJ64KiOqTLv1JQgwGaIP+Kdn//0cWHfpde6rUzT7
         YhFPAYgA9mvX+/c/5cjxJwS6cic6B7aIR67Ko=
Received: by 10.150.244.10 with SMTP id r10mr6697990ybh.414.1273520271536; 
	Mon, 10 May 2010 12:37:51 -0700 (PDT)
Received: by 10.151.48.4 with HTTP; Mon, 10 May 2010 12:37:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146847>

Howdy,

Due to a network (or possibly disk) error, I started getting this error:

$ git --version
git version 1.7.1.166.gf2086
error: garbage at end of loose object '66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba'
fatal: object 66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba is corrupte$ git reflog
291cf66 HEAD@{0}: commit: Class::MethodMaker
44c9cdb HEAD@{1}: commit: TAP::Harness::Archive
89053c5 HEAD@{2}: HEAD^: updating HEAD
b6eb92a HEAD@{3}: commit: TAP::Harness::Archive
89053c5 HEAD@{4}: commit: Bio::Perl 1.006001
c745fed HEAD@{5}: commit: MooseX::Declare
d4097d4 HEAD@{6}: commit (initial): Initial .modulebuildrc
error: garbage at end of loose object '66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba'
fatal: object 66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba is corrupted

$ uname -a
Linux datura 2.6.31-21-generic #59-Ubuntu SMP Wed Mar 24 07:28:27 UTC
2010 x86_64 GNU/Linux

This git was built from the 'next' branch a few days ago. Is there
anyway to fix my repo? I can provide a copy of my .git directory if
needed, but it is 54MB. As for background, this repo contained a set
of CPAN modules, via local::lib, so it had many files but only a few
commits.

I tried "git gc", but it borks on the corrupt sha1:

$ git gc
error: garbage at end of loose object '66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba'
fatal: object 66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba is corrupted
error: failed to run repack

Thanks for any help anybody can give.

Duke


-- 
Jonathan "Duke" Leto
jonathan@leto.net
http://leto.net
