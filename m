From: Florian Weimer <fw@deneb.enyo.de>
Subject: Segfaults with USE_CURL_MULTI
Date: Sat, 20 May 2006 20:47:54 +0200
Message-ID: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 20 20:48:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhWUk-0002jM-7R
	for gcvg-git@gmane.org; Sat, 20 May 2006 20:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWETSr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 14:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWETSr5
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 14:47:57 -0400
Received: from mail.enyo.de ([212.9.189.167]:29401 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932369AbWETSr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 14:47:56 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1FhWUV-0000jH-KM
	for git@vger.kernel.org; Sat, 20 May 2006 20:47:55 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.62)
	(envelope-from <fw@deneb.enyo.de>)
	id 1FhWUU-0001Qg-M6
	for git@vger.kernel.org; Sat, 20 May 2006 20:47:54 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20391>

Is anybody else seeing segfaults on dumb HTTP pull with
USE_CURL_MULTI?  For example, this crashes for me:

$ git clone http://git.enyo.de/fw/debian/debfoster.git upstream

GDB shows that this happens inside the call to curl_multi_perform.
