From: Eugene Sajine <euguess@gmail.com>
Subject: feature "git tag -r" to show tags and commits they are pointing to
Date: Thu, 22 Oct 2009 17:24:20 -0400
Message-ID: <76c5b8580910221424n220449b9vda26f032174b6fa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 23:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N159L-0007Hg-2y
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbZJVVYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756810AbZJVVYS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:24:18 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:56844 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768AbZJVVYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 17:24:17 -0400
Received: by ywh40 with SMTP id 40so5861310ywh.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=aYFMTdDwwD5MXcfoW5ycr10ckf8+X5QPfIn6D6JfqsI=;
        b=LYGKfDY0tafyV1+dt+ifFraHEhr+y19b9hMgQ7e5LTmlaxQdetNI8sXdHrgIkuC835
         Ttp3da42yBQTJOTQ4Tu+7mdKWvh+rsN0vFCSdvTJt+P8RVMaDoX49X/yylxyOrBTRLL6
         ixVi770rgDzpt5v7A69+90fx/0r7OLLjjMWik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Yl2MNru0fJIj5C3FAsAjz9Xy0QJcukAg6//asD4BlDJV/JC1PtCBZ0HUYBc2WgXEX2
         R9CTu1Q7WeMjPuFZEZiGHnMNh1AQeLHyHlwYU/fxhS+269XRnN6GQc1dQJlH1J+bYZiH
         7Lytm8JVp53xnz0MuMczYlvXsxWEJHJylo8Ik=
Received: by 10.90.13.39 with SMTP id 39mr7374785agm.53.1256246660962; Thu, 22 
	Oct 2009 14:24:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131065>

Hi,

Currently there is no way you can get the commits your tags are
pointing to by using git tag.
The only way i found is to use rev-parse (which is by the way not
supported by the bash_completion)

It seems reasonable to have upper level command like:

$ git tag -r

to output

v0.1  8794hke84f9e8h9ef9eh949793...
v0.2  jhkd934398e9f499f47w9789o97...

$ git tag -n -r

v0.1 "super message"     8794hke84f9e8h9ef9eh949793...
v0.2  "another message" jhkd934398e9f499f47w9789o9f...

$ git tag -r v0.2
v0.2  jhkd934398e9f499f47w9789o9f...


What do you think?

Thanks,
Eugene
