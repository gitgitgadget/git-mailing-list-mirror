From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [Bug] git add -i fails in multiple ways prior to first commit.
Date: Mon, 11 Feb 2008 19:59:46 -0500
Message-ID: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 02:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOjWK-0003Tu-Mf
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 02:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYBLBAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 20:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYBLBAN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 20:00:13 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:30892 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbYBLA7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 19:59:50 -0500
Received: by rn-out-0910.google.com with SMTP id i24so6349896rng.19
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 16:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=g6dzdou0YD9hU973172iZ7PHL6rEWCWiK336af8Y+6k=;
        b=pU8itCnCItVUtjbHULXRYk9Kg2rOOkogfuLxF0rOAQTqagKBeS/Mbf463pmyf/CWHZ1Qr/YlszOP8aF8Qw3TeETM17Qu9RrtBZVKzgnWCjNoHcTFrDKqoF6K3DW84RIZa9lMGqy7eXbmADdAjZWdlQqNXzJg3kTQp4S+t6xHjOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=mNcHFxIn/b1/Liu5BrHVUROyRH13X+3rQYhV1u0Ixl4/GoF5UpBugeNCTLB5XILmROReIRI03RsEpWj7A9jqByJOhDCn2YfhcON2zG6SJ08sYQoIrKiP+hw/SKtH9rJ14Ud/iM96nWiS7vgYyiguClN16rBIgdXTTJ64NdKg+Rs=
Received: by 10.150.150.3 with SMTP id x3mr245810ybd.23.1202777989834;
        Mon, 11 Feb 2008 16:59:49 -0800 (PST)
Received: from ?192.168.1.103? ( [72.93.197.103])
        by mx.google.com with ESMTPS id 26sm41960849wrl.29.2008.02.11.16.59.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 16:59:48 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73614>

$ git init
$ touch foo.txt
$ git add foo.txt
$ git add -i
fatal: bad revision 'HEAD'
            staged     unstaged path


*** Commands ***
   1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
   5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
What now>


* status fails to report the current status
* update fails to work at all
* revert fails to work (not that there should be anything to revert  
but it shouldn't return a "fatal: bad revision 'HEAD'" message.
* add untracked works
* patch works
* diff fails
* help returns instructions that are incorrect owing to the fact that  
half of the things don't work in this state.
* quit, thankfully, works. :)


Why this is important:
git add's interactive mode is intended to make things easier, thus it  
stands to reason that people new to git are going to want to use it.  
Presenting them with so many broken commands so early on is,  
obviously, a really bad idea.

-masukomi
