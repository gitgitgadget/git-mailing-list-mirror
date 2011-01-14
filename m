From: William King <quentusrex@gmail.com>
Subject: Git SRV support for clients
Date: Thu, 13 Jan 2011 20:57:52 -0800
Message-ID: <4D2FD7D0.6010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 05:54:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdbg7-0006hf-OC
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 05:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab1ANEyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 23:54:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46848 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1ANEyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 23:54:16 -0500
Received: by iyj18 with SMTP id 18so2191220iyj.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 20:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=QghSyQd974rQsK1o2N0kgRt3/AsoFUVH2Fp+J7a0vjE=;
        b=uCp8BHweDkxGzlLM5XCkS6Z7MGn46g8jDHWHMxD9GTeLARxFYp5KcCYTdYW+iEnUe/
         PbUMgd1Ixe72SDlt0KTbz3itGsDEUwkqV36hnkjd+qXoHuf4KQ9s/bAJmedh60UXmTX+
         yCdcilPT+aUZ95QA/J9m0/uM6QynpC1u0/H34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=KW+hBz43vnPa3amhd2mfpDO/Kz0JpyX1eavsG2G2oGIigyoIr0ltHF6dt9o0+uczCg
         W2jneFPBiiK8v4KZbeYBnpvEDjp1hJqh0IB04zUY3ytRe2zIUiLMsUIWc+gOm1s9XTwa
         zYQsgMDx5nhHxUs7Eu8b3NRTh1zJ9Q0qORCIg=
Received: by 10.231.13.138 with SMTP id c10mr267632iba.97.1294980855720;
        Thu, 13 Jan 2011 20:54:15 -0800 (PST)
Received: from [192.168.100.110] (70-89-155-57-amigo-vino-wa.hfc.comcastbusiness.net [70.89.155.57])
        by mx.google.com with ESMTPS id d21sm601522ibg.21.2011.01.13.20.54.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Jan 2011 20:54:14 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165072>

Is there any interest, other than mine, for SRV client support for git?

I looked into the code and it appears that SRV support could be enabled 
by a patch in the file connect.c, in the function 
git_tcp_connect_sock().  If the getaddrinfo() call were to be replaced 
with an api call that supports SRV records.

I looked into udns which is cross platform, and async(which would allow 
a SRV lookup as well as an A record lookup at the same time to avoid the 
'long first query SRV issue').

Any thoughts?

-William King
