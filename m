From: Filip Navara <filip.navara@gmail.com>
Subject: git-mailsplit and TortoiseGit bugs
Date: Mon, 22 Jun 2009 19:53:51 +0200
Message-ID: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tortoisegit-dev@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 19:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIniX-0005YT-D2
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 19:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZFVRxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbZFVRxu
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 13:53:50 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:45636 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZFVRxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 13:53:50 -0400
Received: by ewy6 with SMTP id 6so4900735ewy.37
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=gMBPWPH0XSoelvEhnpsLpQmat6vQAV41tX1XH1g/S7I=;
        b=fQx+gHPLHZI7WKVHYSU15CojK974BwlUtYlvaoqRXQ+A2AcK3PffK/+909VRm5wH1O
         K0/c5Zp/nwKTMpzjGGQKQPg1mVM4ug+qdtxCjPloix8LAsdwCb+0FqVUw+JdgL5QRfsn
         +I7gySIRhe5iy93c823BFYCazWLTR9IRcQTLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sBStRrs8lHITsm1jcr8LP4TWaJi9mQkS3tmYf6hX0dRIk63tlTPYndBBhsInbkASSW
         sWhLd7KDNMQe21O6PRhIA5gxjs5RvgS+RMKIIJtjmlamDLSbgVHSS7aLaZ9A3nZjuHdt
         ApbSHBd6CQ20imCab7+UMUxxgBKgJReWvKmW4=
Received: by 10.216.0.206 with SMTP id 56mr2271948web.102.1245693231273; Mon, 
	22 Jun 2009 10:53:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122050>

Hello,

I'd like to report a bug. There's an incompatibility between the way
TortoiseGit sends patches by e-mail and their handling by
git-mailsplit. The mail sent by TortoiseGit specifies the Content-Type
header as "Content-Type: text/plain;
boundary=WC_MAIL_PaRt_BoUnDaRy_05151998". git-mailsplit then
misinterprets it and treats it as empty patch. While TortoiseGit
should not be sending the boundary parameter, it is perfectly valid
e-mail according to RFC 5322 and MIME RFCs. The "boundary" parameter
should be ignored for anything but "multipart" Content-Types.

Best regards,
Filip Navara

P.S. I'm not subscribed to the mailing lists, so please CC me if you reply.
