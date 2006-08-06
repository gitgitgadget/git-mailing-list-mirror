From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: fast-import and unique objects.
Date: Sun, 6 Aug 2006 08:32:06 -0400
Message-ID: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 14:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9hnk-0007ig-2P
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 14:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWHFMcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 08:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHFMcN
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 08:32:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:5098 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751116AbWHFMcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 08:32:12 -0400
Received: by nf-out-0910.google.com with SMTP id p46so143653nfa
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 05:32:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mRcWatXdh0EurAvBRMzPxbtn1qw99YfhJRKhiZ6GX+wp1wDxJ9EcKa6VAV2YBah4olZqMvhApYd7Fk1EXcPKGZ+Gg0UpODSVJ1b45460bR/9rHMfAaDzFRKTNcY9wL/Z7JabYf+kriZjis681e0XFjngJFesbekMAsXktXXVwTo=
Received: by 10.78.185.7 with SMTP id i7mr2106938huf;
        Sun, 06 Aug 2006 05:32:11 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sun, 6 Aug 2006 05:32:06 -0700 (PDT)
To: git <git@vger.kernel.org>, "Shawn Pearce" <spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24975>

This model has a lot of object duplication. I generated 949,305
revisions, but only 754,165 are unique. I'll modify my code to build a
hash of the objects it has seen and then not send the duplicates to
fast-import. Those 195,140 duplicated objects may be what is tripping
index-pack up.

-- 
Jon Smirl
jonsmirl@gmail.com
