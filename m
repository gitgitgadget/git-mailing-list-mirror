From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Translations [of Documentation] in Git release?
Date: Mon, 26 Jan 2009 04:31:01 -0800 (PST)
Message-ID: <m3hc3mxn9d.fsf@localhost.localdomain>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 13:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQds-000697-Kp
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 13:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbZAZMbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 07:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbZAZMbK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 07:31:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:64876 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZAZMbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 07:31:09 -0500
Received: by ug-out-1314.google.com with SMTP id 39so126395ugf.37
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=IqvJ40TfLRMkkI+8XZ1PXwEeh+1GrWB+HHOYXCUWns4=;
        b=sKBMiXb+gIK7OBiEye7cHvjm3c9UFgAURVy0X1eI4+CGhr6I4Lsl0aJxeV+F9AN28S
         kw9hLiLqkUy9pXA6JhegnY1hH1jEgoxE4gAtHjsK27VxWOsuLzpDhPVeCRf/H35m/T5V
         xie2uBZqKFGlGrZKpavEVItdrJMyS8CAtR4bg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jyrBCsqOHwVsHpwuk3tmAhwhwy+829IJddb/CZXPPBwVUXY0ACoILWe1w36O3Mx4g3
         aSCr8HvwT5BDWuiS1QBEiC56h4yi+eQiPenmi926bkQXC7ebKspFRzYB3mAxqdG43G+x
         Yd73dIuf11ydd9Bhk70bFxOSuNNFBqVqBYlLY=
Received: by 10.86.92.7 with SMTP id p7mr1900578fgb.54.1232973062033;
        Mon, 26 Jan 2009 04:31:02 -0800 (PST)
Received: from localhost.localdomain (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id 4sm2012095fgg.24.2009.01.26.04.31.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 04:31:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0QCUvZm025851;
	Mon, 26 Jan 2009 13:30:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0QCUtGN025848;
	Mon, 26 Jan 2009 13:30:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107205>

Dill <sarpulhu@gmail.com> writes:

> Is there a plan to include translations of the Documentation within
> Git or should they exist outside of the project?

First, you should have mention that you are talking about translating
_Documentation_, because there are at least three areas which can be
translated:
 * GUI (gtik and git-gui), which is being done
 * Documentation, which leads to translated manpages and HTML docs
 * git command messages (but only porcelain, as scripts parse
   git command output)
 
Second, the problem with translating Documentation is twofold. There
is fundamental problem with translated documentation becoming out of
sync (stale) unless you have people ready to follow changes to main
documentation.  This is less of a problem with GUI messages, as they
change less frequently, there are shorter, and there is less volume of
them.

And there is technical problem of how to organize translations.  With
GUI translations we just use gettext conventions.  I don't know any
such convention for docs: there is suffix convention used by Apache to
serve var language files (filename.txt.de, filename.txt.ja.euc-jp),
and there is gettext-like convention of separate directories used by
manpages (en/filename.txt, ja/filename.txt).  And there is question
where to put untranslated original...  And to enhance Makefile to put
translations in correct place.  And possibly alter RPM .spec file to
put translations in separate packages.

So I am not sure if translated documentation should be not maintained
out of tree...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
