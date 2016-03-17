From: Gregor Jasny <gjasny@googlemail.com>
Subject: Re: Git subtree stumbles over annotated tags
Date: Thu, 17 Mar 2016 13:41:00 +0100
Message-ID: <56EAA5DC.1040801@googlemail.com>
References: <56E19809.5040305@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 13:41:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXEt-0000Ha-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030684AbcCQMlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 08:41:10 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33129 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030288AbcCQMlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:41:08 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so24289493wml.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=s07q5s4M4xA07T+1TBQqwfArYASpYzTL7kS2w00G/Mw=;
        b=VZQkbXhYxrs9Aa/GGSvIb8AQ7FmRjoXhK8JnufHsJ3F2ZPp/GLBtaTq3nudysRrLnw
         nmi0KaLZY8pNrzwgk6kvOpxlFj+WduYoWyg/nGLboShNc55SVGY2nuwFSyIwmC38qTf2
         wBF20Gj5N/tQHulwqIrXt2AgfsAxVTJ5J2zLeXWtwMQd4oUObQrdBGoZSXwApLkUAKuC
         QIEiK1DLsN0hiTxaUZik78HBEaGHts2qJk3VSqzJTwVlzE7LA8+cNWH7veQ5ooSobWmS
         T2pYeaDF8Kz9tqu8Eq2wHcIxD/h4unspL74u23UyG551ungC22AKlug7XRFIEAXCM9lx
         N5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s07q5s4M4xA07T+1TBQqwfArYASpYzTL7kS2w00G/Mw=;
        b=GihNnHCnevfbotvlXDTLybX06Lf9wN3XFiMwSWrukUZkqWczaYE+6b4N4wHl1mN01a
         EscgP/IEJMiV0B+ZkMT0hEjV6Qjzv5exYmkyOSBb9tKv1BZDrfWd7+wdrASVf3tBiNoy
         H5t5Yhdqp/gqeo16io29rbeR4kJ9uL4Oep01ej9Gyw/sdoVTnXvIDwVpdkzSf2UiAkvB
         yZHlutGNucw45vXJxJ/Wb3Q/oP1BJHSQ+DBn1RxbLFRG0d/f4abNQ8KTVXK5xzmDNGPA
         hKguEoZrZl60bULPhp2Cw9uqIlERk/ExikjDYhusNXRS10SQL3Zo/co4z5KAhxnv+I7s
         7cmQ==
X-Gm-Message-State: AD7BkJI8R+QFnMeM3xv/MWoojbeQ8aR5Mfmr34tV/2+a2nVC1QASMbm4xgSGym10wAxnzg==
X-Received: by 10.28.147.72 with SMTP id v69mr34012904wmd.79.1458218462066;
        Thu, 17 Mar 2016 05:41:02 -0700 (PDT)
Received: from drswgregorj02.drs.expertcity.com (ent-nat3.drs.expertcity.com. [78.108.113.8])
        by smtp.googlemail.com with ESMTPSA id 3sm8004554wmp.14.2016.03.17.05.41.00
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2016 05:41:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <56E19809.5040305@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289100>

Hello,

On 10/03/16 16:51, Gregor Jasny wrote:
> today I discovered that it's a bad idea to "git subtree pull" from an
> annotated tag. This issue got discussed in those two threads:
>
> http://comments.gmane.org/gmane.comp.version-control.git/247503
> http://comments.gmane.org/gmane.comp.version-control.git/248395
>
> I was under the impression that it is fixed in recent versions of git
> but my homebrew 2.7.0 still behaves badly. If I run the attached script
> to reproduce the issue I get the following error message:

For the record: this bug was already fixed in November:
https://github.com/git/git/commit/5d65fe312e22594b7fec7349945fb0072987716b#diff-59f70cbe935ec223e3df413b94cab740

Would it make sense to cherry-pick it into 2.7.x?

Thanks,
Gregor
