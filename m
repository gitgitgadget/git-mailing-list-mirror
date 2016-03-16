From: Phil Susi <phillsusi@gmail.com>
Subject: Re: git checkout --theirs fails
Date: Wed, 16 Mar 2016 08:45:57 -0400
Message-ID: <56E95585.30409@gmail.com>
References: <56E845F0.9020609@gmail.com>
 <CAGZ79kbzrpHowSLfCjB6wVfeX_3MUXAjD0rQdcugryWPMrTazQ@mail.gmail.com>
 <xmqqd1qv76rn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:46:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agAqd-0003DB-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbcCPMqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:46:44 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36784 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbcCPMqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:46:43 -0400
Received: by mail-vk0-f47.google.com with SMTP id c3so59780224vkb.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4dS7oG8vn0h7yrzGlA/j0BFgD6GcLzuTXJNlq4KmmAk=;
        b=jsyCh0GpcR4ZYHOmeDZLoEgIw/DrbwVxnLZAYhw3PozRetZiBQCoqNzz/cgMYQgmWz
         TV9k3podHm9WMA3W7DiPsuS6+hzmMvEbfmSLZgNAV5RqbX84JYnsaFD+YzwOGJvjpTLu
         AVXe0HUKQnE5uDgZE3hw/TiMSsSXA9ayTWrCSciRzn2lMynXBNJ4megmuleLSQOn0lIx
         JjLv/W9dVbb9IJeyQ4pb0Qww1FgSDeLmdyewcb1o0Dxt91G2zKQIOZsmwQyheiShXiED
         sgaH2EtgHk0c41y1/5OJ+V4OywFwmp/tMdkWIJQEmblZOA4okVRV+g9uaKRJD0zJn23k
         j4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4dS7oG8vn0h7yrzGlA/j0BFgD6GcLzuTXJNlq4KmmAk=;
        b=cwwh3v/Ar5Fgxol0oWkfKUbBAHMO9G2DXv7LCY94nG3dR/dDb0Gaercf+QgB8iNfuv
         mpTTSe4Yp+pjKP+v2PGqNDBxj+0IOcd9mkuP1s7ykGorEguHAl2uJqW9P0U3WqhS+cPE
         omidw1rulvw+3VYMzEgXKCkNP50QXVgjoIPOP1URixLhHVevxEbE7RSbMK0GoGMQAv0s
         3ksSGdFoG93LGkp1g4EUWOxhnAWiF38pOiiQSiWK1eM/j1jTzZ1UG9jHE+J0DxHWXzt5
         rTptBfobv2C48xMqzUIeccLWVbONU92bJFGPS/ECsJT1eY+2dl/K7QQGnL+SXxFXFI36
         Cb8w==
X-Gm-Message-State: AD7BkJITAQ1SdKckZzUxUU/Fd6Pv3/zAJUGwfF6XRgSXJ9ZLMr60ZbpXYuHOnpH2bRS8hQ==
X-Received: by 10.31.149.3 with SMTP id x3mr4235428vkd.46.1458132402412;
        Wed, 16 Mar 2016 05:46:42 -0700 (PDT)
Received: from [10.1.1.189] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by smtp.googlemail.com with ESMTPSA id v69sm984956vkv.18.2016.03.16.05.46.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 05:46:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqd1qv76rn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288966>

On 3/15/2016 5:47 PM, Junio C Hamano wrote:
> would fail when the path file/name is unmerged and does not have
> stage #3 entry, wouldn't it?  So with ".", unless all paths that
> match that pathspec (i.e. all available files) are either merged
> (i.e. without conflict) or have stage #3 entry, it is expected that
> the command would fail consistently to the case where a pathspec
> "file/name" that happens to match only one path is given, and that
> is the behaviour Phil saw, I would think.

Right... why is this though?  Why doesn't it just check out those files
that *do* have a #3 entry?  And also why the nonsense about switching
branches when you don't specify any path or branch?
