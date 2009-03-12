From: Tom Holaday <tlholaday@gmail.com>
Subject: git doc build failure on OS X 10.5.6 (Leopard) during docbook2x-texi 
	phase
Date: Thu, 12 Mar 2009 08:22:29 -0400
Message-ID: <5e68abd90903120522q635e41f9j118e74158ab04524@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 13:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhjxA-0007dB-LH
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbZCLMWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbZCLMWc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:22:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:41715 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZCLMWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 08:22:31 -0400
Received: by wf-out-1314.google.com with SMTP id 28so615479wfa.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=PlNZsaLA013X6eR1tcDOSayg5AEn4NiLrSaR3EnfL18=;
        b=GZ/VSkuznlhxjC7RouoET+DiCTA7onyNaZI+Iku44H1V9aMC7C4i5JhdN6Q6jnfivL
         YodRASyly9jKFW54Jazk8Q1UI6/fIzst5JnjpJ21UbrG5NJx0njnpw3KL+FOQjcW5TGN
         Qf3Wx4RWZCjePX+h+7KcnH8yqx2ta0wDWhgUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=iticapIO3t7sVfja9v50q667FmTk1/VO7MMDgZrW+oUFS306ypBNlgHtm90b+oiCuu
         YuKKuqgHrFhdfxCNx7Wp9U4ui/mir78p4ALbIQqNhm1ItsJL14fI6IjbmufABszCtEnw
         J0Qt8DPdYKOzVlVmxNdXN9HrrglR6bHRZ72kg=
Received: by 10.142.14.18 with SMTP id 18mr4269328wfn.215.1236860549798; Thu, 
	12 Mar 2009 05:22:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113057>

(Thanks Jay Soffian for the environment variables)

The commands ...

  $ export ASCIIDOC8=YesPlease
  $ export DOCBOOK_XSL_172=YesPlease
  $ make prefix=/usr/local all doc info

... terminate with these errors:

  /bin/sh: docbook2x-texi: command not found [ x 147 ]

... this warning:

  gitman.texi:4: warning: unrecognized encoding name `UTF-8'.

and a zero-length user-manual.texi in Documentation.

Upon investigation, I determined that ...

  $ which docbook2x-texi

... reports empty, but ...

  $ which docbook2texi

... reports /opt/local/bin/docbook2texi.

  $ docbook2texi --version
  /opt/local/bin/docbook2texi (part of docbook2X 0.8.8)
  $Revision: 1.12 $ $Date: 2006/04/14 17:29:04 $
  <URL:http://docbook2x.sourceforge.net/>

Is docbook2texi vs docbook2x-texi a mere dialect difference that can
be completely rectified with a symbolic link, or an indication that my
docbook2X is misbuilt?
