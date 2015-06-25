From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git name-rev not accepting abbreviated SHA with --stdin
Date: Wed, 24 Jun 2015 17:11:38 -0700
Message-ID: <xmqqsi9g8x51.fsf@gitster.dls.corp.google.com>
References: <558A2405.2090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 02:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7ulf-0000Ui-Fy
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 02:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbbFYALo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 20:11:44 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:32787 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbFYALm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 20:11:42 -0400
Received: by ieqy10 with SMTP id y10so44208652ieq.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 17:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rhB5CQoLXf9nFidCl8j8gk2C9SZIjpfNsOpMptGYs7Q=;
        b=IQ0OP8nFF1sCu+SKuVm16JUZ0UdDZ2XlXQtx490hywwWr/zssfzSGjEpf/DUHfaMlj
         LecwdDZ6UirK3iu6Nl6zQ0RHkLbVl6qFZJpK+OpjdVg6/z54VYm1WKfCvjXZULhmN1Hq
         wFJrg6FuPTT7JYu/vTHPCfCshI/opXvRJIdNJNYuZ2MZxrJi+rn4bULLHABDTzEodWU3
         nLlpK3KweCVp2xmEYT3Co2d/aet9OOlAytYEpaKzTYA/oeiSWq3ihrL3ytNYKnSmcrh5
         LqM3T2bD251CgbHzC2H9vlUUYmFAp4CN0NFbyfxqrI+LQZg95BeWu7YKl0S4MDNbQ/Cq
         MSdg==
X-Received: by 10.50.136.134 with SMTP id qa6mr521075igb.26.1435191101903;
        Wed, 24 Jun 2015 17:11:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id rr5sm2167729igb.7.2015.06.24.17.11.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 17:11:40 -0700 (PDT)
In-Reply-To: <558A2405.2090709@gmail.com> (Sitaram Chamarty's message of "Wed,
	24 Jun 2015 08:59:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272629>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> This *is* documented, but I'm curious why this distinction is made.

I think it is from mere laziness, and also in a smaller degree
coming from an expectation that --stdin would be fed by another
script like rev-list where feeding full 40-hex is less work than
feeding unique abbreviated prefix.
