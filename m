From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 3/4] Speed up is_git_command() by checking early for
 internal commands
Date: Wed, 22 Jan 2014 22:05:09 +0100
Message-ID: <52E03285.2070305@gmail.com>
References: <52C58FD7.6010608@gmail.com>	<52C59107.6080005@gmail.com>	<371D58A5-4640-4125-9B69-E9A7B03B347F@acm.org> <CAHGBnuNNaKNx7FzjoNhorryR5eO2c0VvbUgRc_p01mabOVr+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: "Kent R. Spillner" <kspillner@acm.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 22:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W64zK-0007yF-W0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbaAVVFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:05:24 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:35119 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaAVVFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 16:05:21 -0500
Received: by mail-bk0-f53.google.com with SMTP id my13so64260bkb.40
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 13:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5mNlOd9Z0OS/LfY3b1C86g7wpgvBxYQSaWfcLGpHrCk=;
        b=ig1hh4xnVG9kI0h7Bvwd4NiGYD10rfmG4RiwFu+V0UQmXxw28Kj2WDPxnd3eqUN59P
         jkvM26LdQU3frCJfYjb5mvtDOcHeO5L4Du4DSwtEtb8FIXGqaZ1RMlA5ipGQYVwk0Cz4
         rj40oE6HWhDV4tE+yz1nXlFaw7YRlDvxBFV1hj9fPCcnB7VeGPRWNTfpeoq8132y9spq
         gHQz0sjXlz/YP/hTVDA5s9UQJNxr2VqgWyl5v1ROj9CQDvTdsC6mlfNucF0/gj1ywVRW
         l16/qVp/wldC3Vci1vtU8btdbiZaf/yiGDwiApsQJEXnVlnqU5Cmr2uuiW+mZhXeqEUg
         CDzQ==
X-Received: by 10.205.102.196 with SMTP id df4mr1283714bkc.2.1390424719516;
        Wed, 22 Jan 2014 13:05:19 -0800 (PST)
Received: from [192.168.188.20] (p4FC96989.dip0.t-ipconnect.de. [79.201.105.137])
        by mx.google.com with ESMTPSA id o11sm7178488bkg.13.2014.01.22.13.05.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 13:05:18 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHGBnuNNaKNx7FzjoNhorryR5eO2c0VvbUgRc_p01mabOVr+EA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240858>

On 05.01.2014 14:42, Sebastian Schuberth wrote:

>>> Since 2dce956 is_git_command() is a bit slow as it does file I/O in the
>>> call to list_commands_in_dir(). Avoid the file I/O by adding an early
>>> check for internal commands.
>>
>> Considering the purpose of the series is it better to say "builtin" instead of "internal" in the commit message?
>
> True, I'll fix this in a re-rool.

Sorry for not coming up with the re-roll until now, but lucky Junio has 
fixed this himself in c6127fa which already is on master.

-- 
Sebastian Schuberth
