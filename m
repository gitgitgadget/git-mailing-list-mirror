From: Liu Yubao <yubao.liu@gmail.com>
Subject: How to send patch series without storing them to disk?
Date: Mon, 03 Nov 2008 17:33:50 +0800
Message-ID: <490EC57E.4080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 10:35:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwvqD-0003Jn-Hu
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbYKCJeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbYKCJeI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:34:08 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:16524 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbYKCJeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:34:06 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1348529tic.23
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 01:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=/lGq6bMYjuRSz8/+NKAcvaoZwO6wHOVig1mwfme2YEw=;
        b=QCW1u6FTWy1bEkNfWiPOBQ1HqWfIzzcCOYg3Lme5K2T6TzfiVRIqGC4b7XUxRFdN0G
         oDMrtoY78UUv1bP5m0PoTSnNrtU2CmsfDlL7XLERuzMI6hDlJXLs7+uiEOCK+se26C92
         ro2oF4wslhg5rNtgVxFOesaJrGrig1WY99Ux4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=sac9uSoDpdVbNuuTIzlQPd9/Kv9vs+5Xa6L49WS/P64Ih5exgzIgMfOUP1Q3lIphJn
         /blKBd/SfK7jNNubuI3jaREFkb3wHfLEMaToMzViQrwSEAMhsqXSd8RgCvWWQ7iU0Qhi
         t8NiTM7/MphGoYpL7dfdqPq/5n5xvbVNognvQ=
Received: by 10.110.8.5 with SMTP id 5mr11141419tih.3.1225704844830;
        Mon, 03 Nov 2008 01:34:04 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id d4sm774tib.1.2008.11.03.01.34.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 01:34:02 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99920>

Hi,

I want to send patches like this:

  git format-patch --stdout --no-color -C --thread -n $oldrev..$newrev | ...send...

It seems git-send-email can't read email from stdin.


I tried to send one patch using git-send-email, it reported "Syntax: AUTH mechanism".
  git send-email --from <myemail> --to <my-another-email> \
                 --smtp-pass <mypass> --smtp-user <myaccount> \
                 --smtp-server <the-smtp-server> \
                 --smtp-encryption auth          \
                 0001-just-a-test.patch

The parameters about smtp are right, I tested with msmtp. What's wrong?

I have MIME::Base64 and Authen::SASL installed and the smtp server doesn't use
ssl and tls.
