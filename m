From: "=?ISO-8859-1?Q?Gerard_Lled=F3?=" <gerard.lledo@gmail.com>
Subject: Issues when changing submodule URLs
Date: Fri, 15 Aug 2008 15:37:24 +0300
Message-ID: <d3af73dc0808150537r1f708bct14113943d741e653@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 14:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTyZt-0005xa-D7
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 14:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbYHOMha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 08:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbYHOMh3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 08:37:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:22865 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbYHOMh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 08:37:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so641595nfc.21
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=ecG/XnN8tn/Avb8lrgB3MgxX53Tk30XlNMc+7OtBbo4=;
        b=osQ6S+YspwONBvR1/7dqvMqGmLigoV93OV4QDhLFhRws/Y8zN6w5fZlAtalDlRUPzK
         3ZyF71xqsXSSbSPMbhk+RDGpw/mKsWGiT4jQnBrkC7eCFPCAjWhOnmIYQuQvuRm1K0Wz
         OR3D74R52Qp22IpevI7aZ0xgiRgqysDgkX2Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=ZA+yBu0l4aD9aWlRxdSqbzqqkcvGGlMsHpTcmevSFKotMfu8GtJNBFyuIJj0nIAkMj
         H7hqgYC6an7ihotaqMLHkoM/6yHpCFPkgsq4Fm7SskGvrayztxh2JPHWKAVjzsm4Lt30
         S5KlTdMP+IS8erPwsK0orLQrEczaPfq9Gi+mk=
Received: by 10.210.79.14 with SMTP id c14mr3078484ebb.12.1218803844974;
        Fri, 15 Aug 2008 05:37:24 -0700 (PDT)
Received: by 10.210.67.1 with HTTP; Fri, 15 Aug 2008 05:37:24 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 3b24cc8a914cca20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92469>

We are using a super repository for our development where all our code
resides inside submodules. I'm maintaining this tree, so it's quite
common that I change a submodule to point to a different URL according
to our needs (ie, another developer is now in charge of one module).

So, basically I delete the old submodule "rm -rf module && git rm
module", tune .gitmodules and add it again from a different location
"git submodule add ssh://server/newpath module".

The problem comes when another developer pulls the super repository
from me and he already has the old module URL initialized/updated.
What is a safe/obvious update path for him? "git submodule update"
does not work and running init/update doesn't help neither.
Is there any way for me to ease these tasks for the rest of developers?

I know one option is to keep the URLs untouched and then merge trees
as needed, but this seems to be a bigger workload for everyone.

BR,
Gerard

PS: Please CC me, as I'm not registered to the list.
