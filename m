From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port usable
Date: Fri, 02 Feb 2007 09:55:04 +0100
Organization: eudaptics software gmbh
Message-ID: <45C2FC68.47A7F966@eudaptics.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <45C18A3B.2070004@zytor.com> <45C1C24A.471F40AD@eudaptics.com> <45C2560E.6090504@zytor.com> <45C2F648.9030105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:53:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCuAu-0002HY-TR
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbXBBIxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbXBBIxi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:53:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:17765 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801AbXBBIxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:53:37 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 52C32B581; Fri,  2 Feb 2007 09:53:33 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38478>

"H. Peter Anvin" wrote:
> Erf... I dug through this, and it seems that WriteFile only works on a
> socket if it has an OVERLAPPED argument now, because the socket is
> opened for overlapping I/O.

Guess, what? When I use WSASocket() instead of socket() to explicitly
create a non-overlapped socket, plus _open_osfhandle(), it works!

This does not seem to be that new a behavior, since I observed all the
failures on Windows 2000.

Thanks a lot for your tip!

-- Hannes
