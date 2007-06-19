From: Mark Levedahl <mlevedahl@gmail.com>
Subject: git-gui cannot find share/git-gui under cygwin
Date: Tue, 19 Jun 2007 08:28:07 -0400
Message-ID: <4677CBD7.9050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 14:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0coy-0002E5-Um
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 14:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbXFSM2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 08:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbXFSM2P
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 08:28:15 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:58667 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbXFSM2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 08:28:15 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1723107nzf
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 05:28:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=eBDbCqaKkCM83l91b8q/LzWaFAqtjmW3GMRIJVbDlhhrZ7LTCN6lfXtgTeR9rDeO1Fpp1d2wTqiSPJP5xDdmW1JG0liv204NkXUzHr5VCePqCOPY+/yX/e09NWxu2g1n7iAGJZmlsSqsw7IVMd6CnzXtjdClfgVhOgSeI3rahS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=spCQ+o8J2X/aaI8T+zPms1E9t73dI8wx0ggx6zHuSDRsohsWYFhTIuJxmYw6Pi2rACjxf+xa1qOFTZQBNYcWYOEeGgdnpAfycQVk3/oRh2kk4qvYvkzJ6aMBA0s2x7/pkB6ToFzZjrCIy/sNRqnSwjKJWe27qCTuijCNkuGTrMs=
Received: by 10.114.73.1 with SMTP id v1mr7393407waa.1182256093899;
        Tue, 19 Jun 2007 05:28:13 -0700 (PDT)
Received: from ?10.112.151.238? ( [72.254.32.142])
        by mx.google.com with ESMTP id m30sm11290870wag.2007.06.19.05.28.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jun 2007 05:28:12 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50475>

Commit ea75ee3598ab6f8d0828f introduced logic to guess where 
share/git-gui/lib is at runtime, and this is broken on Cygwin. The basic 
problem is that:

/usr/bin = c:\cygwin\bin
/usr/share = c:\cygwin\usr\share

The detection logic correctly finds the wish binary in c:\cygwin\bin, 
and then assumes that the share directory is c:\cygwin\share rather than 
c:\cygwin\usr\share. Given this, git-gui does not load as it cannot find 
its share/git-gui/lib directory

Mark Levedahl
