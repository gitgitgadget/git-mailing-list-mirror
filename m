From: Vincenzo di Cicco <enzodicicco@gmail.com>
Subject: Re: [PATCH][GSoC] branch.c:install_branch_config Simplified long
 chain of if statements
Date: Tue, 11 Mar 2014 00:55:00 +0100
Message-ID: <CAKOJyXcVM0xujy8yCMnOies_67CyWf1GgQ807rszXYxqf1JA5Q@mail.gmail.com>
References: <1394489041-2377-1-git-send-email-enzodicicco@gmail.com>
	<CAPig+cRZyvrPL69eunsV89-AycF=TWeN8x5cUvBhcF0MLVvOog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Mar 11 00:55:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNA2I-000213-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 00:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbaCJXzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 19:55:03 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:44663 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbaCJXzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 19:55:01 -0400
Received: by mail-vc0-f173.google.com with SMTP id il7so2811232vcb.18
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        bh=qurr9UYytWMAJrz5YlWCLuewJQNWZZddNKofng8x30Q=;
        b=sFMiBk3koXJxGC5byCgW9MM8hOS+hQ8zzSpOumXtduAAbDCYe3kCk3KHDDctmIT1fm
         B/sJE4kibuhIkLchz9v5htWckTPZy+QB0ko2lb2O9P7W9sY2KkgQ1iKRMbQ4lTpzZ+Ni
         id6bKsgl4XkdwNpYqKYDeUvj/f1MqwoQ4wQ5BSe5wyUdEXNfIz8ol5sNuZdaT4YDNrdy
         4l0iRBAG1DVP6YzQrgNO4oGJlP05+0MccVDdaaZvOmHzqvifmHqPFZC/DyV8zu7FsyaG
         ypEvvObgxbFnpEQswoN6MuLnFnhlFv8qH6rp6i3ozCb4SG+fc94Dm2PJdQKqcNeY8iU2
         XXVw==
X-Received: by 10.220.250.203 with SMTP id mp11mr24646407vcb.2.1394495700811;
 Mon, 10 Mar 2014 16:55:00 -0700 (PDT)
Received: by 10.220.67.16 with HTTP; Mon, 10 Mar 2014 16:55:00 -0700 (PDT)
In-Reply-To: <CAPig+cRZyvrPL69eunsV89-AycF=TWeN8x5cUvBhcF0MLVvOog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243827>

Thank you very much for the answer!
I've learned a lot in this few rows.

> If we take the time to trace through the code, we can see that
> remote_is_branch is indeed either 0 or 1, thus this expression is safe
> today, however, if the implementation of starts_with() ever changes so
> that it returns a value other than 1 for true, then this code will
> break. To avoid such breakage, and to avoid placing burden of tracing
> code, you might instead write the expression as:
>
>     location = locations[!!origin][!!remote_is_branch];

Thanks for the good tip. I've erroneously assumed that starts_with()
never will change.

> This approach of composing strings is problematic for translation,
> which is why the GSoC microproject states:

Thanks to show me this issue. I've read the other thread and
understood the problem.

I will do better in future :)
