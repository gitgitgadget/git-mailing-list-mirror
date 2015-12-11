From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Case insensitive URL rewrite
Date: Fri, 11 Dec 2015 10:51:58 -0800
Message-ID: <CAGZ79kZbxFT6_rZUAfUW7Qof8n7mjU53VZb24uGru4LfTfFr=w@mail.gmail.com>
References: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
	<xmqq7fkkg7tq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:52:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7SnW-0004QB-4j
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 19:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbbLKSwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 13:52:01 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33395 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbbLKSwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 13:52:00 -0500
Received: by iouu10 with SMTP id u10so138624882iou.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 10:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EWQUg8Y2CmPschgMq1DYn12dLFloShipCtmtSSGfHcM=;
        b=jN7WuaJJ+7ZbDxoQz+qq0A7xYkyiP11XFEcBRRKTAp7E21+ZNbK/i6wVLABx0V5KYT
         34obTEZnsykIl9qrRJgZ/iltbo7FOleiippZXaV1cdzw3uBNV8kXi289Sstq2/6cGpf7
         y1cYQwaHNxMQtWWkGEokMOqG066/jKGbzuObA1Rhmiz6ppbmMgNCMBG+6iP4AHDHLYzK
         h/DpTChgD9Wrjo8HnxgkelsmUSflqit3GB3OExlcatibFa3g8gvD/YQHSOdYWgrQoJfH
         z3ySaJlbP0tJcBfEQlOnOQLBJBmoXqtmVKjXSOyBhLekbooEs72s0XdzKitUhTXuAcFc
         XubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EWQUg8Y2CmPschgMq1DYn12dLFloShipCtmtSSGfHcM=;
        b=Ian/qjBc5guSyR7EpFcXAz7T6T3tE/AtmoQhFdX1Q1bCf5rBDsAIaMFXaeFshGxCQn
         rj9BjdgJ7qS1gHe6GheQ3Q2CM0kK3FiR+TNgsGZNmevwQDDn0rZgdZ5CxiplEcXj8uQb
         MFt5qHXeQohItlAMD9Lih8RGlezaURBlF640f0jD4x3jiaSpN3+XWbCInoKEVWpYMUgo
         3iDAtxQewC2V6jyYCB6AFy9axoinWZ00PyN9ZwFiRpB2ePT7wtW9/Pwsb2p6tLqwhxp7
         dobnrGLFZE3K2HWHJh1FpQXmzjZyiOWiaLtWWPiABJlJiZh+F/o8Tx/h02c/N+2lCxMX
         Uqkw==
X-Gm-Message-State: ALoCoQkISnfJEw6igOEzq0AxhV9sykamHU7Ng2FO2UOk9uKBH/ji2pROb2wHVsg2eOCi4DuJh+nsPzOBf1veALXpWx9WnB1dFIRX05aNrnLPipsMThHM0UQ=
X-Received: by 10.107.35.15 with SMTP id j15mr18556905ioj.9.1449859918928;
 Fri, 11 Dec 2015 10:51:58 -0800 (PST)
Received: by 10.107.141.1 with HTTP; Fri, 11 Dec 2015 10:51:58 -0800 (PST)
In-Reply-To: <xmqq7fkkg7tq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282268>

On Fri, Dec 11, 2015 at 10:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On the other hand, these two MUST be treated as different by
> default:
>
>     git clone https://github.com/GIT/GIT (differences outside host part)
>     git clone git@github.com:GIT/GIT     (differences outside host part)

This is one of the more obvious examples I would think as the protocol is
different. What about:

     git clone git@example.com:git/git     (differences outside host part)
     git clone git@example.com:GIT/GIT     (differences outside host part)

If the host has a filesystem which respects capitalization, these may be
two different repositories.
