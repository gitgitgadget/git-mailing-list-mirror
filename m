From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: How to identify the users?
Date: Thu, 31 Jan 2013 17:16:48 +1100
Message-ID: <CAH5451kaXQj3Qz0P_Ydd+BnXwiENvqGP8tg4hHOgU8i5J_x5Lg@mail.gmail.com>
References: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Scott Yan <scottyan19@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nZj-0004nd-4u
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab3AaGYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:24:22 -0500
Received: from mail-vb0-f47.google.com ([209.85.212.47]:56315 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3AaGYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:24:20 -0500
Received: by mail-vb0-f47.google.com with SMTP id e21so1532378vbm.20
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bec8UF61vKoWY4uDoC/yWzrqhwbKoYjBBhNVLJO+qrQ=;
        b=0wRmb/pHXavR2UCrhNQ4ziRHST+/xRpg7r7KzmZh6Gi04zKN+riho5M4ae7KyvY4c1
         hKFGTm7hQ/fNdRkwr9I+Pz3uDXXqf1//vxi2KNNC3mG+o6FE9wenEqiYIWhGOUSdQ+o3
         rwZKi2KWQKvQxtD+Pzy4mD3Q1p6bMS1LoVeqqbN8fY0HAm+DlkgYax7XDYGYUafvWgwh
         5WWcRDtdwHuO9PfqOgY1l7aKLCSqjIhDbQIKo4lo5UwAuh4yxCfVkkX4OJxjbpirmV0w
         w29dsxN1v0NLwm93uq2SNlmrB6KiKon4vxJnsDIo4N4qWOn4famwhX5ZKwyus6ZV9sJb
         Y9iA==
X-Received: by 10.58.216.97 with SMTP id op1mr2914560vec.21.1359613029146;
 Wed, 30 Jan 2013 22:17:09 -0800 (PST)
Received: by 10.220.107.82 with HTTP; Wed, 30 Jan 2013 22:16:48 -0800 (PST)
In-Reply-To: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215096>

(resending previous response. Forgot to turn off HTML, and apprently
gmail doesn't wrap lines automatically anymore?)

On 31 January 2013 16:52, Scott Yan <scottyan19@gmail.com> wrote:
>
> The user info of git client (user name and email) is set by the users
> themselves, so , how to avoid userA pretend to be userB?
>
> Git server could authentication the user, but it do nothing about the
> user info of commit message.


The simplest thing is to have the server reject commits that have the
'committer' set to someone other then the  authenticated user.

Of course, there are potential workflows that this would cause problems
for, such as if you sync directly to another user's repository and then try
and push those to a central server.

The most robust system would probably involve using signed tags to
verify what is being pushed, however I am not aware of any set-ups that
have done this yet.

Regards,

Andrew Ardill
