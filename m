From: Stefan Beller <sbeller@google.com>
Subject: Re: git pull not ignoring the file which has been sent to the
 temporary ignore list
Date: Fri, 23 Jan 2015 13:38:55 -0800
Message-ID: <CAGZ79kaJkDjr7uPScKgO=P5nVZ4sQgn1aQNf9MwVuHMcA4a2NQ@mail.gmail.com>
References: <3278910.5D06XWKxyS@linux-wzza.site>
	<xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
	<4004424.cytMaov38D@linux-wzza.site>
	<CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
	<xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arup Rakshit <aruprakshit@rocketmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YElwT-00052e-Ci
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 22:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbbAWVi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 16:38:57 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34631 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbAWVi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 16:38:56 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so4270130igk.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zBcBJqj+LUv2uF00MmfMd5j8EnAUN+8ob/VkdUTx+nY=;
        b=AbS+RXgl3CbfHqBvXZrkHC10GRgjf4yNbaSyT2iTNPvhOp4eBG6fVS90szfEOZe6ER
         58w/JqDXwyG/uHryeZ2sDwtgxLhOydMUrmazLPASPhGRX9MhvBgKh/mG91r4jh3L+uqq
         an7R6as+BktSwZFpEhmsL0pcedKRSYsVr9PMSmEbvKVLd6ybptmLrSSSiuhXIVRwIpen
         I9nLEec77QywQQhnU3OIRPzf+USBenB6iE+DJMEU9bK/BQMdKvZmNrPXGyZNjASWUlmE
         pSONSQ7ynkhPKt8UjugXuAvLQZGF0casooaN9cxRs66+pcjqCRR1ActmvSHRR1Kbpcst
         5Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zBcBJqj+LUv2uF00MmfMd5j8EnAUN+8ob/VkdUTx+nY=;
        b=S9wp5SSOhZ0KNsI3am6Qe8FuiG86MYCvoJ4GFMxUguLqWec/w0zL+RZMkYOPB5dHtI
         G+g9FxhQMEehB3aBAVLOSPJnUXMn3hKDUNzNh+S0UZNHazkLHco+YU+//GgHIFNz8SFo
         2O5dmLSKiN+9vu9ZZtOZeF064OhgkDsesKXgNs5SdtUKBGwYk/qAD9y75X7AhkAzUj71
         E+TkDzLdECirxwnspszyYfoghzvbQMNVXSwShGLf25mlm9a9vN/Loz+lbx521mg5/CFC
         DinUzPs62w/BR+URNY0AUo0X17eiABFz3MmW6BskPI2U2I+Sbs5rTZybwAi6c71wUp4o
         ixEw==
X-Gm-Message-State: ALoCoQm4xfnn8u9ccfF/yHx7iEUNhfiKO4NrWa4ogT3EZ4BBIvNnUSMRCNNCz4IukubjS7/U03PX
X-Received: by 10.50.222.70 with SMTP id qk6mr4322717igc.47.1422049135726;
 Fri, 23 Jan 2015 13:38:55 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 13:38:55 -0800 (PST)
In-Reply-To: <xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262963>

On Fri, Jan 23, 2015 at 1:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Good answer for ".gitignore".  In general, you do not "ignore local
> changes" to tracked paths.
>

I assumed Arup would want to ignore more than is in the upstream project,
so you'd come up with an appendix to the .gitignore file because that file
is rather obvious to find (it's printed when git pull modifies it,
'ls' just find it,
you'd not look into .git/info/exclude by chance)

Assuming you want to ignore less than the upstream project (delete some
lines from .gitignore) it get's tricky in my opinion. Either have a local commit
and just use 'git pull' to resolve the conflicts with upstream. The problem then
arises if you want to publish your changes (such as pushing your changes and
creating a pull request, then you have that commit included, which you maybe
don't want to include)

Mind, that I am talking about possible work flows to circumvent an
assumed problem
which would result in problems as described in the first mail.
