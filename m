From: Marcus Kida <marcus.kida@gmail.com>
Subject: Bug: git branch -D can be used to delete branch which is currently checked out - Part 2
Date: Thu, 10 Mar 2016 19:39:56 +1100
Message-ID: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 09:40:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adw8Z-0003UU-0i
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 09:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbcCJIj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 03:39:59 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35302 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcCJIj6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 03:39:58 -0500
Received: by mail-pa0-f46.google.com with SMTP id td3so35370057pab.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 00:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=fjUzHqhJMkieTx6pqeCIjCS3aEmk2baVKgbcKIq5KhY=;
        b=ncNkDQx9E/sF+qAp0iXhl7m/7H5qF1/aZlJWDWb9kiSpLFs3J+hnE+XwDYVAPM2V94
         kohgyBxM7ybQomivoC1lTOJMqCUTFVSqwiaiGiypGohYArSnXF8VitwvNXgLWLWT3z5+
         51qvjN211hMpjYaMOOPEuTQRfVAKazL48EnrKxTnHIdhHMDFZpSsVwxECJKNkRku7Gtx
         l8uac3iNq9/4sSlGvBA/GgfMoJmVrlheJFd8DqHgxODufO2ICfcMqCyBosKaiQ83SKKt
         niQcmYsh0ib63XK/yoy+lJsIcAPB59LSGEpKtkd3N6B2Bot1OhZij1LaWZcWzMvWI2rb
         6vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=fjUzHqhJMkieTx6pqeCIjCS3aEmk2baVKgbcKIq5KhY=;
        b=avYO/shyD0SgMrkURpTqfCihTM82ctQfgJH1MyMtz2S8+IfXBf/tbClr89TxIRuE/h
         142rhT/VmCk7N9q0oDQRJFZn6zEcgTfMsJXuzKli0wVih5ex3B6r/h4qnuvZylYq77II
         51XeHEVczpVvxrfWXCJ/OtR6iVPuEKDl7/HvX8gQaBhgjuZrkwArFnM2CimVCrcoc4Rr
         ctnkK0ipgkUTVTBtQsXIGfFLJWdB+Dw8GK+9Z8E6w/pQms+b2Lobl7npOPkzodZOAWJk
         4s4adJHhBxEush3eTgQfafToyinab1dQd4seM84KA5bfulwoyAGle7/MXGULpWjBLIdg
         cPhQ==
X-Gm-Message-State: AD7BkJJLszcDLy0BK/QKuzbojbJlubfb6/p+fYTU+eeoEDmVFD2kjJ2FZ3jHprCWoElCVw==
X-Received: by 10.66.142.132 with SMTP id rw4mr3191184pab.26.1457599197699;
        Thu, 10 Mar 2016 00:39:57 -0800 (PST)
Received: from [192.168.0.7] ([49.191.133.138])
        by smtp.gmail.com with ESMTPSA id c18sm3611381pfj.41.2016.03.10.00.39.56
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 00:39:57 -0800 (PST)
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288602>

Proposed solution:

Use `strcasecmp`, `stricmp`, `strcmpi` here: https://github.com/git/git/blob/f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e/builtin/branch.c#L218

Not sure if/which one of this will work on POSIX as well as MS too though.

Thank you.

Cheers,
Marcus