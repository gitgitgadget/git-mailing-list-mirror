From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Subject: git reset --hard in .git causes a checkout in that directory
Date: Thu, 03 Dec 2009 12:30:46 +0100
Message-ID: <4B17A166.60306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 12:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG9z1-00031g-CW
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 12:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbZLCLgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 06:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbZLCLgP
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 06:36:15 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37230 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbZLCLgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 06:36:14 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2009 06:36:13 EST
Received: by ewy6 with SMTP id 6so1380155ewy.29
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=OuYFU69LUHxrQVo3zoh5vk7dVad541VuqB3HGCdkOaY=;
        b=BvOq9Oq+UGjHnLsEtCpt3tJtJd0444rz7tIIrQ5/O8J8y33V0BoDB31YjI5Md4moGH
         pXYz3K9cmJ2heYyehL4Jrhwz19KgHfUIh/rezu0Ip5Ucm2wyMDYCE6JodbXMrsONYFY7
         Y0uU8vWrhFeGseUKJuHDbi1i6NjmFT5mJjIkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=dLZ2S9CrAP1NCHNWfqU56P/D1gtcSxwskdkAfFCvfxpQAVMPt8mwkP3r7KB3pouzFE
         +64LEOEfeXKj+Ek8k1I/FCdK7cddCOjbVdpV3Yl//3xZBPOxKvRKphnVhX3kiVs53srg
         NfG0eUc2a0T5iODe0H/29S2nabUkVzhgeV7ic=
Received: by 10.213.24.2 with SMTP id t2mr6012310ebb.6.1259839847630;
        Thu, 03 Dec 2009 03:30:47 -0800 (PST)
Received: from ?192.168.1.34? (82-169-33-1.ip.telfort.nl [82.169.33.1])
        by mx.google.com with ESMTPS id 14sm1267856ewy.3.2009.12.03.03.30.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 03:30:47 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134448>

Hi all,

When I was working on my code and made a mess that I wanted to undo, I 
accidentally did it in the .git directory, and had a whole clone of my 
last committed tree there.

It can be triggered easily:

mkdir test; cd test; git init; touch foo; git add foo; git commit -m 
'add foo'; cd .git; git reset --hard; [ -f foo ] && echo hello beauty

Other parts of git could be affected, I haven't checked where exactly 
the bug hides, so I was afraid to send in a patch

Cheers,
Maarten
