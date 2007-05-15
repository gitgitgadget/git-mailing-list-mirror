From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: BUG in fixup_pack_header_footer(...) / pack-write.c checksum error never raised
Date: Tue, 15 May 2007 13:47:18 +0200
Message-ID: <34a7ae040705150447k2e770b5ag3629632f61b813a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 13:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnvV0-0004cB-4h
	for gcvg-git@gmane.org; Tue, 15 May 2007 13:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726AbXEOLrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 07:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757911AbXEOLrU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 07:47:20 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:22660 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757726AbXEOLrU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 07:47:20 -0400
Received: by nz-out-0506.google.com with SMTP id r28so103058nza
        for <git@vger.kernel.org>; Tue, 15 May 2007 04:47:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oTHDUEsWNsNGdfloAtjNFhQWdeYQMooGJBzgH0cmhY5+Qh+IKa5NKGcEOESyjnrXiK+TrOorzJBp7AMxaKSaVTX+yFu9C7wELgB7VlkbDyFzZKfRhJDBa4Ye0QPWbbarCEHWKvxe3E15ssmwj3hVG53lXvm7SRk9QzXpA6v5F7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JjvJVQAdIk3Bfhbrw+06WjvY/tZspnjiFrsm5DzjrycYvaFPLfe95rydh51fB510UHE8tboMLbnxOCNyzjLWkszA93jHLoojy+2dCddvE+ZgTQUlRNvGq7cy+Rr7AAkZItBQf2fU53t1AgMjZnjbe1FxTtvWMhPaqrRpfefO1TA=
Received: by 10.115.61.1 with SMTP id o1mr1522168wak.1179229638969;
        Tue, 15 May 2007 04:47:18 -0700 (PDT)
Received: by 10.115.58.17 with HTTP; Tue, 15 May 2007 04:47:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47339>

In fixup_pack_header_footer(...) file pack-write.c
We have to change the size_t value returned by
xread() in ssize_t, otherwise the next check on negative
values has no sense.

size_t is an unsigned type!

I can't write now a patch because I'm on a customer site
and I can't install GIT...

I'm just looking at the souce code using gitweb during a coffebreak.

Someone can fix it?..

Pao
