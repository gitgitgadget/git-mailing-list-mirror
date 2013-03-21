From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] git send-email and SSL_verify_mode
Date: Thu, 21 Mar 2013 15:18:27 +0530
Message-ID: <CALkWK0mgA8kb6LLANV78geTOnW0ON7H=hBV2VPkg62-9pFG68Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 21 10:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIc7Y-0005OF-2s
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 10:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab3CUJss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 05:48:48 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:48857 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab3CUJsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 05:48:47 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so3005399iee.39
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=3XlJnERJEduL4QriMIFJSBga4QBqi4tE/Gle2rGWT4I=;
        b=I15KvZTCUAuemoSPYx8lKHpU6fTQ7v2QfLPbTstlTaoslJWArj4Aq6uSVRT3EBwmht
         0SUphFkGg0csZf+eejEAnVsQWPMS1sYkuAMs6dtmuoNFWh2xVAgSR2emxz0Fg9yhgExO
         Ejdp9VbLlV9u0j0jiEjRMsgCLBdqrL75feL81G2RorKjL0X3riFsHIh/ldZGqLMOcgGz
         SDYDR8lMdPaF5+gAHU77Ff2Lt42TkEDVSVgSwL3ub9qOI/Vg8WTWLjMDidz32yt5msqd
         HsEV9OCV5WqHWGhzE1s7+iZdK+mkzbJYxLqg0XWJ5C1yq4M6DecjjXPYlIUNSuECKRM5
         X/mw==
X-Received: by 10.50.108.235 with SMTP id hn11mr1566153igb.107.1363859327448;
 Thu, 21 Mar 2013 02:48:47 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 21 Mar 2013 02:48:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218705>

Hi,

With recent (I'm how recent exactly) versions of IO::Socket::SSL, git
send-email:1169 spits out the following warning, which originates in
Net::SMTP::SSL:

*******************************************************************
 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
 is depreciated! Please set SSL_verify_mode to SSL_VERIFY_PEER
 together with SSL_ca_file|SSL_ca_path for verification.
 If you really don't want to verify the certificate and keep the
 connection open to Man-In-The-Middle attacks please set
 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
*******************************************************************

Nevertheless, it does manage to send the email successfully.  I'm not
sure how to fix this bug, since my Perl-foo is weak.  Please advise.

Thanks.

Ram
