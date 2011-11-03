From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>
Subject: error from 'git push' on v1.7.8-rc0
Date: Thu, 3 Nov 2011 12:43:54 +0100
Message-ID: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: gitlist <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 12:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLviD-0004yF-2q
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 12:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606Ab1KCLn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 07:43:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43569 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab1KCLnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 07:43:55 -0400
Received: by ggnb2 with SMTP id b2so1221535ggn.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=usxsvy41spex+7+XMl/Rx7jLksKJAgDUPC2JSuvwZzw=;
        b=wMbI9JuCL/qGRVREADOLNRhvaYteo9MOuGtZgP7+meONYXKnXiVDoOqM63IpUgW4UG
         5C2astPOJmMOWVzQgn/q8C8zD+lZ8eUcaKSJbDPIq+MSu3oReeRkhB7sjR2p3+9xB6l/
         cUvkMrZ2ukiPAeV2Tw1bqZnMFizNE0tU/PQVs=
Received: by 10.100.23.14 with SMTP id 14mr1966290anw.135.1320320635146; Thu,
 03 Nov 2011 04:43:55 -0700 (PDT)
Received: by 10.100.33.12 with HTTP; Thu, 3 Nov 2011 04:43:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184715>

I get errors from git push when trying to delete a (remote) branch:

$ ./bin-wrappers/git versiongit version 1.7.8.rc0
$ ./bin-wrappers/git push -q . :refs/heads/nogofatal: bad object
0000000000000000000000000000000000000000fatal: bad object
0000000000000000000000000000000000000000remote: warning: Allowing
deletion of corrupt ref.
I bisected this to: 52fed6e receive-pack: check connectivity before
concluding "git push"

$ git describe 52fed6e~1
v1.7.5.3-492-gf96400c

$ ./bin-wrappers/git version
git version 1.7.5.3.492.gf9640

$ ./bin-wrappers/git push -q . :refs/heads/nogo
remote: warning: Allowing deletion of corrupt ref.

It makes no difference if the branch to be deleted exists, or not.

Regards,
  Stefan
-- 
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode('hex')"
