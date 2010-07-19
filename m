From: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>
Subject: [http] Git error messages reveal password encoded in the URL
Date: Mon, 19 Jul 2010 10:00:20 -0700
Message-ID: <4C4484A4.5010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git-dev <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 19 19:00:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oathh-0006N1-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 19:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0GSRA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 13:00:27 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34361 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab0GSRA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 13:00:26 -0400
Received: by wwf26 with SMTP id 26so402515wwf.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=3rSVw5x9ufoACIbUoeDRbTPQetlcLzKUDEByjvLvwmI=;
        b=agb0ultqr3rIOQHFu0UeC3K1EM2dgl26Bcqt1L1MyVzqZwnXm8uQXtPWsDzVL0VPAN
         C3oc4i3skBmhE7+hUu+WQ6HEZGl0yF4ANfwoabH6bh+upoExoTxjwawLA5Ot2U1ctVmL
         tw/vSi/zvRHk2OMCszuELYEgw5M/DXy08bVVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=VFbYhsp8t2GvH+8agEWFnTKWeaoovPzhcU99nE6fwOoHofNmCVPARAmQIZPJsHFn8t
         3dYBR8h330JqYLC+jHAk8V4OECuDxB0OKnkpzQbdP5LxNWv6QDtgWdYZW7chT7pDAzZv
         sdyNbvCpNVaj8uUCDP3vDucaBtZGWlj6ks4AM=
Received: by 10.216.232.144 with SMTP id n16mr4148871weq.1.1279558824062;
        Mon, 19 Jul 2010 10:00:24 -0700 (PDT)
Received: from storm.corporate.thoughtworks.com ([204.15.2.181])
        by mx.google.com with ESMTPS id v16sm2396518weq.32.2010.07.19.10.00.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 10:00:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151260>

Hi,

We use http to serve our git repos, in order for git to not ask me a 
username/password everytime, I've put the following in my .git/config:

[remote "origin"]
   url = https://user:pass@host/repo.git

What is discerning is that every time git encounters a problem 
connecting to the repo, I get the following error containing both my 
username and password.

error: Couldn't resolve host 'host' while accessing 
https://user:pass@host/repo.git/info/refs

I would like to suggest that the password be removed/masked from this 
error message.

-- 
Ketan
http://ketan.padegaonkar.name | http://eclipse.org/swtbot
