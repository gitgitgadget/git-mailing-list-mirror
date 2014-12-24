From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: GIT_PUSH_CERT* env vars and update/post-update hooks...
Date: Wed, 24 Dec 2014 07:27:30 +0530
Message-ID: <549A1D8A.3020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 02:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3bCm-0006Mf-UB
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 02:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbaLXB5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 20:57:35 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62807 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaLXB5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 20:57:35 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so9013542pac.36
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 17:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=LvxKvQwXLmaWn4kDXhnOAXMOSBOjEqKhIE4MBUz16FI=;
        b=OAexZUEEEfUYc3PQtDWSkI18bULtzEWbX/L3zveIp2NQVeu+lNMeXtq6OZcTIPKJ80
         uTpSo11e1RYhN1vl2s+vapok2ypWd63EDFRX9VkfIkjISYpOfXfPGR7A2RE9Fsd8fWsH
         lncKxjkaj5mvQ3nYELHGsFWjKN5y9ysPdtB+pG9uTQdQ9ZhFj0GPDJ7en1f3m0nEaEn6
         8thct54rP5FkPXsm/f8chQ6N4YYjQWvosgs8nfldcPTOa+uNyC7j7cYsIMHC/RZRiYDv
         e8NxfHFWz/BomQi9igxBjbbx8Vmo/k6Z6WobCMrPm1SoidzQU4uoFB8gUL3yyc7QfadN
         10hw==
X-Received: by 10.66.159.67 with SMTP id xa3mr50011496pab.13.1419386254466;
        Tue, 23 Dec 2014 17:57:34 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.183.214])
        by mx.google.com with ESMTPSA id v2sm21154819pbz.39.2014.12.23.17.57.32
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2014 17:57:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261786>

Hi git core devs,

Any chance I could persuade you to set the GIT_PUSH_CERT* environment
variables for the update (and post-update) hooks also?

Background: gitolite "takes over" the update hook [1] for authorisation
and enforcement, and I want to avoid taking over the pre-receive hook
also in order to do this check.

The post-update is not so important; gitolite doesn't use it anyway, so
if I have to take over one of them, I may as well take over
post-receive.  I just added that for consistency.

thanks
sitaram

[1]: because it's nice to *selectively* reject refs when more than one
ref is pushed at the same time; pre-receive is "all or none".
