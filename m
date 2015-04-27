From: Vladislav Kostenko <vkostenko@netlabsystems.com>
Subject: Fwd: Can't override username of default credential context to have
 different username in custom context.
Date: Mon, 27 Apr 2015 21:19:31 +0500
Message-ID: <CAK9djV0CqO4sXPMqKCnH3VZFQ4G=XFbNPRF-ZMXjNRLjqfcngw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 18:19:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymlkw-00062B-1t
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 18:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbbD0QTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 12:19:33 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38243 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbbD0QTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 12:19:32 -0400
Received: by wiun10 with SMTP id n10so96149488wiu.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netlabsystems.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LD3dSXTPkGk3ml+E8kW+AE0V/GXkO9/p/Kjme5C/8us=;
        b=GQRFdyclA8lxg9sZ7seQuJ3h6nP560iZpd5kPSWpNDUOb5J2Ee1IZ5nj+WIwKPgjmd
         ZLJeb/6uo0AHRwVG35yk9WXhynwClFBLyWxD5Oe76YgLmERSCtSUZP9okIETyDXBNCRO
         wTbbTrA6EQGvc50omM7pxp8D6nWwaXP+vRNeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=LD3dSXTPkGk3ml+E8kW+AE0V/GXkO9/p/Kjme5C/8us=;
        b=m/VChBi1AOL9EIcbA5mnAUPFfjxwB3fXvCbttalFZI1DJ0z5d40Yt/WikFti09FQrO
         kUMhoex3Ypdne/sZMhgZgISk/pxbS+2uBX/F3OcTyjIGDnKM+9YvTXKfAQemJa5GOGpP
         64hWfq9v6IbGdPIwOtmAtD5FDHaWSD8uVt2istaio6BMfTW9uIrj93AGwljpm7seB6SH
         ntBw8O+owOD06wudtK24uo922I+JttoaQxYMF9EHxJaLKtF50NgkTb6MqmgIs8xBTn/g
         Oracu5nGVKp/KosGTSnBpoKp8K3eHiUOToJnAZ44YgL8TnN+hDK4xlu1JHTK5RwJBUPs
         c9AQ==
X-Gm-Message-State: ALoCoQnNGRC6TsMX55VN8sRy/6oINEX34t8VGQLwmBSze3VK/5q6+79nY0Cn0hUNPVQHZ1f4XOP5
X-Received: by 10.194.2.16 with SMTP id 16mr23658038wjq.46.1430151571061; Mon,
 27 Apr 2015 09:19:31 -0700 (PDT)
Received: by 10.180.76.198 with HTTP; Mon, 27 Apr 2015 09:19:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267857>

Hi,

Here is my scenario:

1. First I set default username
git config --global credential.username myUsername

2. Then I want to have different username for my other repository
git config --global
credential.https://myOtherRepository.visualstudio.com.username
myOtherUsername

3. When I try to pull new changes, git asks for password of myUsername
Password for 'https://myUsername@myOtherRepository.visualstudio.com':

But I want to have:
Password for 'https://myOtherUsername@myOtherRepository.visualstudio.com':

Is there any way to accomplish overriding?

PS: I've found that if I change steps 1 and 2 I will get what I want.
But this is not a solution as it require to unset and set
credential.username after I add a new credential context. So the
ordering does matter and it looks for me like it shouldn't.

-- 
Best regards, Vlad.
