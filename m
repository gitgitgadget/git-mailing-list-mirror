From: "Carlos Rica" <jasampler@gmail.com>
Subject: What git config --replace-all ONE_ARG should do?
Date: Wed, 26 Mar 2008 14:50:57 +0100
Message-ID: <1b46aba20803260650o5e425250sb532a3b3197a1ecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 14:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeW2j-0005xm-42
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 14:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbYCZNu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbYCZNu7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 09:50:59 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:1514 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYCZNu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 09:50:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2047946rvb.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=86lLQCDUPmpiolt0vPFj2uM/DbMZkYLwzR9zN24YT2U=;
        b=ucYeoTQ8a5XrkO5tiML54mKXgO6BAKDUqocRXXaaloGNhYXUdbFpDHNtk6ryIiwnBRYZpsKQArjJxb4wB+prC5ZXkcGrH5RZgn38bWMJgl3iYK+vwcyALVlyAA7h8jDoUiOew7ftHT3AGCcGoxb32bgNAEMlXdiR1Sh0qq8HJLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nL9y/ngWHtbfETotmurQP5K4eeq6+vnVGh75aAIJGGEYq3HN3bnEgR2JvEJIx8nqZhFHyE9Og/khoOXTLpl4apRhCpaA0s4pUas2jkIftgw3ac7UEGEs72R7bpmPEqKWempi7pMSN3pysyKrxokwZmxgrFt5LJfXiuotHWUIleI=
Received: by 10.141.142.15 with SMTP id u15mr63575rvn.66.1206539457820;
        Wed, 26 Mar 2008 06:50:57 -0700 (PDT)
Received: by 10.141.115.5 with HTTP; Wed, 26 Mar 2008 06:50:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78284>

The command 'git config --replace-all ONE_ARG' currently
tries to do the same as the command 'git config NAME VALUE',
using --replace-all as the NAME and ONE_ARG as VALUE,
printing "key does not contain a section: --replace-all".

What this command should do? I'm almost finnishing
buitin-config.c to use parse-options and I need to know
if that command should do something or just showing
the help and exit in such case.

I think that --replace-all should always receive at least
two arguments. The documentation currently says:
git-config ... --replace-all name [value [value_regex]]
and current tests are only cheking two arguments.

Since I cannot imagine a consistent action to do
when only the name is given and nobody complains
I will do this to print the help message and exit.

Cheers

--
Carlos
