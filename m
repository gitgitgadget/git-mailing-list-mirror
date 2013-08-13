From: Tvangeste <i.4m.l33t@yandex.ru>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Tue, 13 Aug 2013 17:44:35 +0000 (UTC)
Message-ID: <loom.20130813T193141-905@post.gmane.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com> <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org> <1353857940941-7571889.post@n2.nabble.com> <loom.20130415T220316-790@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 13 19:50:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9IjT-0007Zf-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 19:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab3HMRuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 13:50:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:41013 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757930Ab3HMRuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 13:50:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V9IjL-0007UO-04
	for git@vger.kernel.org; Tue, 13 Aug 2013 19:50:03 +0200
Received: from agsb-5d8707d7.pool.mediaWays.net ([93.135.7.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 19:50:02 +0200
Received: from i.4m.l33t by agsb-5d8707d7.pool.mediaWays.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 19:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.135.7.215 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.49 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232240>

Brice Lambson <bricelam <at> live.com> writes:
> +1, this is a significant issue downstream in Git for Windows:
> 
> https://github.com/msysgit/git/issues/57
> 
> Effectively this renders .gitattributes useless for the scenario of 
> enforcing normalized line ending characters.

+100

Folks, the problem is still there, with the very latest Git built with MinGW 
on Windows. Having eol=native in gitattributes means *LF* EOLs on 
Windows/MinGW.

So, essentially, eol=native is completely broken. And this is the most useful 
option to put into gitattributes and share among those working on the project.

Currently, I have to put eol=crlf there, and that means that those working on 
Linux will end up with CRLF files in their working copies.

The link quoted above does contain an additional fix that resolves the 
problem.

Thanks,
  --Tvangeste
