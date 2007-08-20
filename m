From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Suprising error message from "git clone"
Date: Mon, 20 Aug 2007 16:45:31 +0200
Message-ID: <vpqwsvqmfhw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 16:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN8W0-0004io-6Z
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 16:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619AbXHTOpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 10:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbXHTOpz
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 10:45:55 -0400
Received: from imag.imag.fr ([129.88.30.1]:52435 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757619AbXHTOpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 10:45:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7KEjV7Y025698
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Aug 2007 16:45:31 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IN8VX-0006sl-H2; Mon, 20 Aug 2007 16:45:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IN8VX-0004YE-Ek; Mon, 20 Aug 2007 16:45:31 +0200
Mail-Followup-To: git <git@vger.kernel.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Aug 2007 16:45:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56220>

Hi,

I got a suprising error message:

$ cd /tmp/
$ git clone ~/some/repository
Initialized empty Git repository in /tmp/repository/.git/
Warning: -l asked but cannot hardlink to /home/moy/some/repository/.git
114 blocks
$ 

I understand that git found the path to be local, and tried to
hardlink, but it shouldn't say "-l asked", since I didn't ask for it.

Either the message should be changed to stg like "Warning: cannot
hardlink to %s" or it should just be skipped if -l was not actually
provided.

-- 
Matthieu
