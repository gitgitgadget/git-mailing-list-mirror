From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 18:31:42 -0800
Message-ID: <CA+P7+xpdZRMPgUtP3Hu1DMN74S5rVPT6La7Pa0=LsLJHaO7bxw@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <1456426632-23257-2-git-send-email-jacob.e.keller@intel.com>
 <20160226015510.GA5347@flurp.local> <CA+P7+xqyTUh60BOmY03JHE6HyVqY7iidVkUf3ji95_s3uE32cg@mail.gmail.com>
 <CAPig+cRM_1JLfBiOqo+-EdKbXp--4VUbddKN_zpSCSLK8PT09w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 03:32:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ8CW-0006nB-PR
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbcBZCcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:32:04 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36530 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBZCcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:32:03 -0500
Received: by mail-ig0-f175.google.com with SMTP id xg9so26365065igb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ozUr7thrG82qjFDtnL4959DqxNZBT8GlIQR9vTgNknk=;
        b=KL18RFqu2WMYbFwBcy91oKCCuKtDOlX+S3z59iq6OUZxp9cxUfrSJUZJl9LR8F3r7c
         7O73PRoryqslK8/m0/EViXuTc643ntcxUtGsisDS7VfKqcfnKjfmaTxqmaT/OoiX/18L
         /KXiRYxgIapIGMZ5rUGREcX7Cd5rhGMDBjaOoiirxbHYxvXneX6BwkqbPnSx2feu5JGN
         d7pKfx6tiM9pgGx4quZQka4utI15CsX8V6Aup0/YSAEpDzBrV1GN9TtmyQG3Y5kEFUE/
         ji9rrzK2fZKIVrhPVxrzHWpQkVLKTAa8GDee6fEj/WGmkMgZVIWQPKm0hs3STquFY67t
         jIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ozUr7thrG82qjFDtnL4959DqxNZBT8GlIQR9vTgNknk=;
        b=m8btHgvY2N7EiDfl8YmrnZqsfmxDbSqBJNx3ULBh4eoXQ8C8w9Vw8eYxYPbxuBtyDY
         mpofAc3Qu2M/ddvzfaKr2d3ttD6UZzx6WOhkoqML4H/UfxeVGUCwwQ4jKSJW2SkGxoka
         q+rXrXVqiSHYxVeRruJvo69Izl212WkTSX/88NiBNIiVnFi1RKy5HVGP1MzVoMQDPn6I
         c1IZuyRoejiwpvQYRBrdVB1VTUkgDdoDDq9xbbsBVh0Crn+Iv0WfOPXOtFjlr2j66Dmm
         kFhBnJjyxBCffxiVbwLWS3Ce+jcaGVUyBKSlhtBcz5fzGxtmP2PNS/1bhkcHwVa72Z+J
         qqLQ==
X-Gm-Message-State: AD7BkJKCtghq6hAyjPd/Vnx66RweU+PwO4ZS13z9J9xSoRUJB8tk2cqtnMgWZ9dy975wYnzZMuicJcijDTDwJg==
X-Received: by 10.50.142.103 with SMTP id rv7mr559087igb.35.1456453922237;
 Thu, 25 Feb 2016 18:32:02 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 18:31:42 -0800 (PST)
In-Reply-To: <CAPig+cRM_1JLfBiOqo+-EdKbXp--4VUbddKN_zpSCSLK8PT09w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287533>

On Thu, Feb 25, 2016 at 6:26 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> One thing I elided accidentally was that when changing the second
> argument of test_expect_success to double-quotes, you would altogether
> drop the double-quotes around "helper" in:
>
>     git -c credential.helper="helper" submodule--helper [...] &&
>
> to become:
>
>     git -c credential.helper=helper submodule--helper [...] &&


Yes I figured that :)

Thanks,
Jake
