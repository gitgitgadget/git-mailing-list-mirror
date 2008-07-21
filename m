From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Make gitexecdir relative to $(bindir) on Windows
Date: Tue, 22 Jul 2008 01:45:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807220140170.3407@eeepc-johanness>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 22 01:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL54s-0002bN-Rv
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 01:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbYGUXo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 19:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYGUXo5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 19:44:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:58282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750698AbYGUXo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 19:44:57 -0400
Received: (qmail invoked by alias); 21 Jul 2008 23:44:55 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp067) with SMTP; 22 Jul 2008 01:44:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZxepUAstZjbkfHNhDv/wdVxlGrVq/hDRYNc3gqC
	BQpS03a2GKd0re
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89418>

Hi,

On Mon, 21 Jul 2008, Johannes Sixt wrote:

> The problem was that argv[0] does not have a path in certain cases.

Note that the same holds true for Linux when calling a program that is in 
the PATH:

-- snip --
#include <stdio.h>

int main(int argc, char **argv)
{
        printf("%s\n", argv[0]);
        return 0;
}
-- snap --

compiled and put into the PATH will output just what the user said, not 
the full path.

I imagine that the proper solution would be to rip out lookup_prog() and 
use it for non-Windows Git, too.  Unless you want to limit the usefulness 
of your patch series to Windows, that is.

In which case you could use lookup_prog() after unstatifying it.

Ciao,
Dscho
