From: Luke Diamand <luke@diamand.org>
Subject: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 23:07:18 +0100
Message-ID: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hy7-0001wv-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbbFRWHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:07:25 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33799 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbFRWHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:07:19 -0400
Received: by qkeo142 with SMTP id o142so34505103qke.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zklvtbZqZ5tGTbxgskKf5ffduyhHMU2ii6fkDjKEv5A=;
        b=c2yIf7DzD3z1qDJ75Hkr1I/CxcqTFhfei41aGY6i2MY9oTQ45seMdJB9fErG6OH6yS
         ymcqy8nZF3odGuN6mSNcigeALh5Rymni2PXJL7Xm7gSKJT+r1RwpVxlStDAOaEC11SjM
         wSbYRID0Z9pDTsm6bXfykKKdGq9O9SYmeePRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=zklvtbZqZ5tGTbxgskKf5ffduyhHMU2ii6fkDjKEv5A=;
        b=f8f26MlJ5Mvgk3WaCjPZY3QvANGcpBpWgbKjcQEQl662Dp6/tyZB7j0ePITP3fHO3r
         YZtcLeodXx2crMJwl2tc+jiR7R9AT7j0cy4tnlTK7QCctf9vDw63VLLThuXKAYvnvYse
         TYuDsHs96RcCMpC5B36RDIp63cUFU4e3gXuqG3IbIeokw1ziCU68Otwr534kTKQA4SO6
         RnLW+81leSjEhEI6dpChUa5dh2EAC6qNPSesCL0oD+vQUx6f2MllYRzqUPR1Gi59mJlO
         9MZ5YcNhUBVQjnOMfnPg6zrs0w+vna9jeh9ZggYpoVNLXRmxjL5ySg+F9XVVBnQiTXN7
         rSeg==
X-Gm-Message-State: ALoCoQnULlKlY55RQp1TPHPnJ2JVJasD4Tse2ilOq970npHzuVBj0ClrAF0mbVLgi52tcRm3+GpX
X-Received: by 10.55.16.218 with SMTP id 87mr29595460qkq.67.1434665238885;
 Thu, 18 Jun 2015 15:07:18 -0700 (PDT)
Received: by 10.96.142.7 with HTTP; Thu, 18 Jun 2015 15:07:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272084>

This is probably user error, but I'm not sure what I'm doing wrong.
I'm posting here in case anyone else gets the same thing

I'm using 2.4.4.598.gd7bed1d, i.e. 'next' as of today.

I've somehow ended up with history skipping back in time, but git not
prepared to let let me fix it, or something.

$ git diff upstream/master -- subtree
 - lots of deltas, which look like I've reverted this back several
revisions (which I haven't AFAIK)
$ git checkout upstream/master -- subtree
$ git diff upstream/master -- subtree
-- still lots of deltas
$ git checkout upstream/master -- subtree
$ git commit -m 'Revert unwanted changes'
$ git diff upstream/master -- subtree
-- still lots of deltas

What am I doing wrong? Have I ended up in the middle of some weird
state (cherry-pick and rebase isn't in progress AFAIK).
