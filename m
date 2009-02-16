From: skillzero@gmail.com
Subject: git commit <path> scanning entire working tree?
Date: Mon, 16 Feb 2009 14:58:08 -0800
Message-ID: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 23:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCR7-0000Mu-Ri
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbZBPW6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbZBPW6K
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:58:10 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:53481 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbZBPW6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:58:09 -0500
Received: by gxk22 with SMTP id 22so3549190gxk.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 14:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=yWQCTm9uKyMlQ8aW2HAL9FxncOdzV7Hf8E1hDsKfVgk=;
        b=pr+fBwZS+FmRXImgF8CGYNBiiLhpZhSK2oBdjROYFGzWXIcIG2yL34gPr9Th4YnTqm
         vnFVF/a6nk8nTxSbyBAk7dxlE+RcmqR+qX3e0OtkVSpZxZ8Y0lIoirlQGJE32CYIMqxf
         cOsJC35q7518Mz74lqktDvkU0Zal/M9R4b4js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=wx0oE0/s1CY733SqtrwUW7ULQ4YFmZU5Vmy+6LwpjyFg9Kf4sjR3YIi6njqDcpDGep
         /IlM3BEwWwlEeI852SmJSxaOtYmKAwNmdvNZBu7Eu25JqYkQPdYibr3Urxvzn3CwcHFI
         wWo4f2KNKORX9AUrEQIVO6ixygQTj6BQYXFgY=
Received: by 10.151.82.13 with SMTP id j13mr2096176ybl.39.1234825088548; Mon, 
	16 Feb 2009 14:58:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110260>

When I do a 'git commit <path to a single file>', git seems to scan
the entire working tree. Since my tree is relatively large (and when
on Windows, stat'ing is even slower), it takes quite a while (5 or so
seconds) before I can even edit the commit message.

Is there a reason it needs to scan like this when the commit command
specifies a specific path? It seems like it would only need to scan
the path I've specified.
