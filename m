From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: git-send-email: bug with sendemail.multiedit
Date: Mon, 9 Jan 2012 14:09:30 -0500
Message-ID: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>, pierre.habouzit@m4x.org
X-From: git-owner@vger.kernel.org Mon Jan 09 20:04:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkKWX-0001p5-Ip
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 20:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803Ab2AITEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 14:04:44 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33421 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2AITEn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 14:04:43 -0500
Received: by qcqz2 with SMTP id z2so2325860qcq.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 11:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:content-transfer-encoding:from:content-type:message-id:date
         :cc:to:mime-version:x-mailer;
        bh=5xXTCDvnfDGArw7yhdfhwaAzKSZNXIFGXpnmPTu4xCI=;
        b=H3onP2L7eO0VMlMMFrsyfvfPPPW9gN5T5uTysBeJfSPCFpUgY4UuQQk8PPhImpwF8M
         MUC8UbDZB8+Ky0xbx78r0MIbvTq6jJiPxKNuhr20Y6K6KC2ph6w6VkXsHQ324qsamOVM
         3WiL6zxozd4DKJvrB1LBm/GpxoKjMd21nNKxM=
Received: by 10.229.75.194 with SMTP id z2mr6445412qcj.86.1326135883036;
        Mon, 09 Jan 2012 11:04:43 -0800 (PST)
Received: from jfdmac.sonatest.net (modemcable066.15-37-24.static.videotron.ca. [24.37.15.66])
        by mx.google.com with ESMTPS id a19sm25430524qau.21.2012.01.09.11.04.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 11:04:42 -0800 (PST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188182>

Bonjour Pierre! ... and all git developers!

I think there is a bug with git-send-email.perl's evaluation of the sendemail.multiedit config variable.

I was only able to make the "do_edit()" function detect it as false by setting the variable to "0" instead
of "false", like so:

git config --global sendemail.multiedit 0

otherwise do_edit evaluates it as true and invokes the editor with all files as argument.

All other git config boolean variables are set to either "true" or "false", not "0" or "1".

Not being too familiar with the perl language, I don't know how to fix this without spending an hour, which
is probably the amount of time I already spent narrowing the problem down already. So I leave this into
more capable hands.

cheers.