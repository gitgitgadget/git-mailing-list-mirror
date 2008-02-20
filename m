From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip address for the signed certificate
Date: Wed, 20 Feb 2008 15:35:54 -0800
Message-ID: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 00:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyUK-00022j-GA
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYBTXf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYBTXf5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:35:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:36525 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYBTXf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:35:56 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2343959wxd.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 15:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=s5VKaJIWWLm0jmdesnzKjhpGahrv4ExpVHIo/AQEMnA=;
        b=sgdsGi6jsnUNVQfm4csSgxlB144YhbHSCkK1KTUbBRwyDHIG1ohhy6mX/hBkGDJjVTiOFpoVSN4ulQTNRS3qwyAkRz048ERHygiB46Nu8DCJV1b+vYKh/Uz+5cbb5oUTFNb7kFU2tTIjEagQMfHKpityVxjHjR1ERSDNLwihv+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z7IhofCv3LnyHb5VG3A5TqS0FL7gZen/Y8HGt7Oht5vx+FvkP0jmoXrOe7jxuE6JzgVAK0fPoP4wu+OJ9F4rt4fTdnZkGkOCfY5tGT0lYxUrDuiCYFFd73kKaOgJFzKnf5fyeZWKTUWFHUJJeUx5YlM/ucDEHnjpjArjeekP0Z0=
Received: by 10.115.47.1 with SMTP id z1mr5182158waj.117.1203550554887;
        Wed, 20 Feb 2008 15:35:54 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Wed, 20 Feb 2008 15:35:54 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74569>

I am not sure if its a bug in curl or git, but despite setting
GIT_SSL_NO_VERIFY=1, if i use a different ip address or hostname then
the certificate was signed for, git fails to push changes.
