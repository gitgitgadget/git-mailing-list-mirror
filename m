From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v16 7/7] commit: add a commit.verbose config variable
Date: Fri, 6 May 2016 12:10:55 +0530
Message-ID: <CAFZEwPOeZBRVqctNYuiBYC=SaDtU7jHqmgMNWLUayfTUqC1xnw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-8-git-send-email-pranit.bauva@gmail.com>
	<xmqqbn4kb9m1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPMoqK0jLgvb9rm5j_0PHFO6Qg9OU1V_jxkFvL+wGGaNng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:41:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayZRk-0005Yv-4n
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 08:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbcEFGk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 02:40:58 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35155 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026AbcEFGk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 02:40:56 -0400
Received: by mail-yw0-f181.google.com with SMTP id g133so164221853ywb.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jCVujzdlDrlvKEpB4gSjgiBDKOh6rpQz+mBqsTxYo68=;
        b=k1HcW7Dk/UczWYvjH9Ge0UBz5bNlcPlF2H4VWB8BvTWcgZP65T8mB0xw5dCY0A7mYB
         O9zwQgnFisTCkdgcnQ7+yLUuRVRtu8GuC5nL1lwcABUpD/HyomKhVf5wp5/j1sUwUJ/N
         b9pjsXG5bxVaBo37NlHAcFMgACr9JLEr4kb1fb5ABXHABX/9R5XaygvrKnwGIgQ4qGKw
         A03Wve8n9nZ5JPkkG1shJ+PhnEs9qCwW8RiPetuA7vKvafztoUn+OJZRYuXG/VOkF70X
         c0244g3oqKYqpHpZCYbZbkhVjqTUeuQFWxMLkC8WC4LNCndskozLDcKu6I3AmeF0koQB
         S/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jCVujzdlDrlvKEpB4gSjgiBDKOh6rpQz+mBqsTxYo68=;
        b=k0OjTerVbJrJNux0sY6yO8N4fti0kJ/l7FLwnW+3uislVvEIbUHtSzQAnawg5PGV5x
         9Me6vdNmNu//DFMuM+06Jdegwg9GT2YdfrAHcaVlwvwpcQFFqnmWXi+KjJbDlq3hbJbA
         7eEfsAp5MsuBMTH5nfQ/Jxoi+75a50eIjuQQtKvt7UbWobzwzyYEoh6TcqaTNKEsoBos
         1qetFnWdrByPhfE6YgFS4NsL8ls39/xS4c8cRt7d9AVRg6qfARbIOdqrQMgPn3l3QOvp
         q026COaDRLJ/8SvNYEDXYQlIMXq2clxDu4U2wExnamHZGlGugb/rxOp6+RI1nMJ5pDlT
         IVGg==
X-Gm-Message-State: AOPr4FWXBochwBtGq84lHhciV5wmbDf9lDQSJLVWjDtkA7UmICgEJtDp4YH++gFn+nDvuGNWQ7q9SpymZdWSpg==
X-Received: by 10.13.244.134 with SMTP id d128mr11520926ywf.72.1462516855857;
 Thu, 05 May 2016 23:40:55 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 5 May 2016 23:40:55 -0700 (PDT)
In-Reply-To: <CAFZEwPMoqK0jLgvb9rm5j_0PHFO6Qg9OU1V_jxkFvL+wGGaNng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293746>

On Fri, May 6, 2016 at 10:35 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:

> I checked out your branch gitster/pb/commit-verbose-config and tests
> from t0040 seem to be failing. Don't worry I will handle those, I will
> squash your patch in mine and re-roll it again. I am still unsure how
> those tests broke. I will figure it out.
>
> Thanks for your help! :)

False alarm. I had a dirty build. The test suite passes perfectly.
Feel free to squash your patch in locally.
