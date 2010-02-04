From: Jay Soffian <jaysoffian@gmail.com>
Subject: rebase vs rebase -i
Date: Wed, 3 Feb 2010 23:19:24 -0500
Message-ID: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:19:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NctBi-0003Aa-NW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 05:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab0BDET0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 23:19:26 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:42293 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815Ab0BDETZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 23:19:25 -0500
Received: by iwn39 with SMTP id 39so2538026iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 20:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ABrY32fB3hBrS4djgAc5KYaj0YtEQWBZUNojRUhL+qg=;
        b=dH5DfkUUTV8qO7QtKWDegbqFm9+TxheH8ZPHeJzW3LhG9tQhL8plFcnDUwO46P3HuA
         +Ws3j50RvK9PJ2mWSGrAU/PE/Ugrx50qhMtyvaDdEryzyfbMzqaNYFzIhykMzbjkrmlx
         zfvPfWoZOBzgZ39emTzBoATOeM2LnRJgL81tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ZmtzaV4SY+lFVftPSHoBVRFurZBqUXMgXRkjI1UPn+ECkalq7pQEXqH8evbVAlBphr
         PF7mvTWRCfdpq4IjgRx/wDzkNz3ww/uUM1kaj3r6TY4m36TbvnuJKbK5WmJ1dGZwdR+b
         0/uKWfrZrB3HCQLMdevauwThKXTqiS43AtFYU=
Received: by 10.231.151.212 with SMTP id d20mr994042ibw.53.1265257164933; Wed, 
	03 Feb 2010 20:19:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138948>

Why does git rebase use format-patch + am, while rebase -i uses cherry-pick?

Just curious. In particular though, it seems especially odd in this case:

$ git rebase --onto <newbase> <upstream>

vs

$ env GIT_EDITOR=true git rebase -i --onto <newbase> <upstream>

Both in theory produce an identical end-result, while using two
different implementations.

(Here I'm setting GIT_EDITOR=true just to demonstrate that I didn't
change the list of commits in the latter case.)

j.
