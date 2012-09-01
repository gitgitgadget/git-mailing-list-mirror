From: Aleksandr Dubinsky <adubinsky@almson.net>
Subject: Suggested behavior when pulling .gitattributes
Date: Sun, 2 Sep 2012 02:21:51 +0300
Message-ID: <CAEbpm93Pr8sU9mBx8V5VMmi5aXos-KBQpmEN7NPrdR07rYV5EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 01:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7x1o-0008Nj-Gh
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 01:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab2IAXWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 19:22:13 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54243 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab2IAXWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 19:22:12 -0400
Received: by vcbfk26 with SMTP id fk26so4452116vcb.19
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 16:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=RWIFd8M3nKqVg+tKcTEoDjZgJ3jFr2n64oPVpqOAZ9g=;
        b=pVSXhfbD1y9G+M3pFOOu6wT0BOy8kwiMwj1fAb2vLnD5HZaudek65PdOIBkgh2eNJD
         zTk5CdPurukFryxQaNtOArvuypzXDIQg7esmSN5T05TcqGylOX/XavKLR81sNRye9SvW
         pSTKmHm5HeZWtjpRrgcKbPJkYi+5hoT/lXecwLXn04jywOoIdT8UtRzuEdyswKK6BiBz
         0cbhng3tr6E+r+zIwDKNTEmmRMs89GF2rfjMWoVarG2XsyWixsLB2YTCPgOcaoZbGeKr
         v4F7n07xZV+U5AY63A0XJGQ9C19Yp9OmCIKbGeR5zB21TiEpQ7WI/orcuCRn0XLomkvs
         GTig==
Received: by 10.58.0.82 with SMTP id 18mr9196194vec.0.1346541731979; Sat, 01
 Sep 2012 16:22:11 -0700 (PDT)
Received: by 10.58.66.230 with HTTP; Sat, 1 Sep 2012 16:21:51 -0700 (PDT)
X-Originating-IP: [46.211.18.226]
X-Gm-Message-State: ALoCoQm5ZnsMPw+9CkJYDt0+Z3IJRYgNmHTPxPhD0wCjwEDhc/rwrRauNSfhzH0fZ5rrzBsFNe3P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204652>

Hi,

I ran into a problem with line endings that .gitattributes is supposed
to fix. However, I ran into a headache with this not giving the
desired result. This headache could have easily been avoided if:

When pulling .gitattributes, git should parse the file and anything
new in it should be acted upon. Specifically, if a file already exists
with modified endings and .gitattributes now says it should be treated
as binary, then please automatically re-checkout the file with the
correct, un-modified line endings.

Possibly this suggestion also applies to pushing/committing but that
wasn't the problem I ran into just now.
