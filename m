From: Stefan Beller <sbeller@google.com>
Subject: Re: --progress option for git submodule update?
Date: Fri, 11 Sep 2015 16:05:16 -0700
Message-ID: <CAGZ79kbH+917v6pmCC3w4rovEVarHp+w1tYthMwkMU2hrq=VdQ@mail.gmail.com>
References: <88E7FC00-9A87-4E20-89D8-4BF5997F7B07@gmail.com>
	<CAGZ79kYRYqVE35_i5+DvqOj7G6LvhBQgsQok5gabLY6x20F80w@mail.gmail.com>
	<68DDAE70-85F2-4873-BDBD-373985A49815@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Vitali Lovich <vlovich@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 01:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXNn-0004Zu-1W
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbbIKXFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:05:20 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35554 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbbIKXFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 19:05:17 -0400
Received: by ykdu9 with SMTP id u9so107057278ykd.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M0ULzAdrCTkz4wF2RIivVpoql+qFZFpGhO6RG8vJmC4=;
        b=Kq8q9nv//8UAuYoI4cSONxB+AgzYqWKsnB3h3eIRGay7CpppHOy4BqYkN0uoPb/A2/
         TQbZOmi4keEko+CmGiU3ojD8mchOKXQmgOV1yhtYH6LBrXUk4hp2MhRSOoDcLZ/zir37
         Yekhlhu9BekzlwqEOFOgEuJLmjo3LbP6arORGdWpTuq7oIT5n7Qy4lBXfHDdxB2MzdL1
         Q/6AG8dg+Z3SAdpac69vejrQ4ZJ7addmNu2sAKmyZmHyBkKqg/bpqekncFWUgiB9USYR
         J5GxDGqntZe3dUXqxpKk208c9XP3swwfjWCtXS4C9yF+pWi9UXkw9ojhxlRWyeXqYDhn
         CtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M0ULzAdrCTkz4wF2RIivVpoql+qFZFpGhO6RG8vJmC4=;
        b=G1sne43MpZ11O6zVyXDgMbxr207TkATU6y9FjP6mgA8Jm8DfvHHT1jdoKeBNjnkNyF
         0nXeQc7iTeIQ9g0tawyq3QBEm563f1FGdctYOE4MAAHKl1dvj+gcXNNtDcEOSbzs6EOK
         F8Rh7ezAQvRLNXz9e+ZTNkmlyb2VbiaImidBuwZpi/BFdhLk94o8zM9XCq8DW3YBWTZ5
         56YYOpqGtQz39fDVVIt/qObewCgVlYQaYnRUyEX5hNLerdDGjI6FFf0ud4iNPvJFL6rJ
         KWaNZ2BwKoJ8Hx12fOljPHU9icCk+lnSkJs03l48M3tIFsuKYAe216+14nD1vO1VulFu
         DokQ==
X-Gm-Message-State: ALoCoQnrEdGgls7IvJUVy67EV8bX33AVWZITqjhw9Jbdjrw59GD8cykniRa2o1OL+CHF4S4m5+8V
X-Received: by 10.170.173.1 with SMTP id p1mr1469346ykd.101.1442012716524;
 Fri, 11 Sep 2015 16:05:16 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 11 Sep 2015 16:05:16 -0700 (PDT)
In-Reply-To: <68DDAE70-85F2-4873-BDBD-373985A49815@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277703>

On Wed, Sep 9, 2015 at 8:06 PM, Vitali Lovich <vlovich@gmail.com> wrote:
>> Doh! I see what you're missing now after rereading the email closely.
>> You can add a --quiet option,
>> but --verbose or --progress just errors out, but you want that as a
>> possible argument for git clone
>> inside the git submodule update code.
> Yes exactly.

Instead of cloning with submodules, you could also clone only the
superproject and then do a git fetch --recuse-submodules=yes -v
instead soonish.
