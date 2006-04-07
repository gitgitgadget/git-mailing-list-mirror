From: "Morten Welinder" <mwelinder@gmail.com>
Subject: realloc
Date: Fri, 7 Apr 2006 16:11:21 -0400
Message-ID: <118833cc0604071311v1da93f83n112cc2ea44552ca9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 07 22:11:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRxIj-0007hR-Hc
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 22:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWDGULW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 16:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWDGULW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 16:11:22 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:35137 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964876AbWDGULV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 16:11:21 -0400
Received: by pproxy.gmail.com with SMTP id i49so605261pye
        for <git@vger.kernel.org>; Fri, 07 Apr 2006 13:11:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S/9jimVS35cxYPM3qXWcXJDb8EpMFEgM4JCZQY6I1fqyL7gEyzy2zR3labQ8sYF4r2pClNkF4b/GXm4kyZwJk0tcRyhZOUaGnDtigN4F4h7zQ5tAWcGespyhTIQV9uKyDFFCFETz08zmo+79qo8hcVpwZO0kxgm05sNdpFcepTo=
Received: by 10.35.50.9 with SMTP id c9mr1008722pyk;
        Fri, 07 Apr 2006 13:11:21 -0700 (PDT)
Received: by 10.35.39.13 with HTTP; Fri, 7 Apr 2006 13:11:21 -0700 (PDT)
To: "GIT Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18504>

I could be wrong, but shouldn't

      var = realloc (var, whatever);

be changed to call xrealloc?  That, or assign to a different variable and check
for NULL.

This should affect the last four hits below.

M.




/scratch/welinder/git> grep -w realloc *.c
daemon.c:               newlist = realloc(socklist, sizeof(int) *
(socknum + 1));
diff-delta.c:                           out = realloc(out, outsize);
git.c:          cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
ls-files.c:             which->excludes = realloc(which->excludes,
sha1_file.c:                            buf = realloc(buf, size);
