From: Andy Parkins <andyparkins@gmail.com>
Subject: Forcing rewrite of files in working tree
Date: Fri, 3 Aug 2007 13:45:46 +0100
Message-ID: <200708031345.47127.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 14:45:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwXW-0003HS-46
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbXHCMpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbXHCMpz
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:45:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:22008 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXHCMpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:45:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so456491ugf
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 05:45:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kkBA/cxJ93EJQ0qUOXtBcTLLVxiw1+9nCbF4fuXxopiuJrLCQmtcE8PFrefBrssbdfkhb4ST7JomxSREL+zFajeKT5LrZET9hbBxVNQV+QFV4vowI/cb82pY/C+6xPSZ8e+2IYMGBCKkZZjDq8PlllWPXMqyoqB1Djc6Ay/nslw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TWUm3nMotEfCkTwFMspMkvv+yRUdtpFS8Q5LiOHe3+iyvLpKQKG9SbiBD5dnyW9kYjRvmnVGdlrb50RPKkXhruc9cXrGzOMyflzdIaLKO8bMnPhUwqUtJFGYg3vLSim9YalxBzVLYftbAtYH7AHnHv6dusTck/Sw/6onwDKJbFI=
Received: by 10.67.24.18 with SMTP id b18mr2905662ugj.1186145152699;
        Fri, 03 Aug 2007 05:45:52 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c24sm6266555ika.2007.08.03.05.45.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 05:45:52 -0700 (PDT)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54715>

Hello,

I want to write a little recipe in a Makefile that ensures the $Id$ field in a 
series of text files is correct.  In case it's relevant, I'm including a load 
of asciidoc files as subsections into one master file; each file has a $Id$ 
field in the header, which very nicely prints out at the start of each 
section.  However, the $Id$ field is only written on checkout (not on checkin 
for fairly obvious reasons).  That means that for any files I've changed, the 
$Id$ is wrong.  Before I generate output using ASCIIdoc I'd like to ensure 
the $Id$ is correct.

How do I do it?

The only method I've found is to delete the file in the work tree then do 
git-checkout again.  Even with -f, if the file is not changed git doesn't 
perform a checkout again, so git-checkout -f is not sufficient.  I assume I 
can do what I want with some clever plumbing, but I don't know any 
plumbing. :-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
