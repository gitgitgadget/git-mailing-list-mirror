From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Sun, 15 Jun 2014 03:10:40 -0400
Organization: Twitter
Message-ID: <1402816240.5629.83.camel@stross>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	 <xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	 <CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
	 <CAL=YDWnHubbC3eOUjHtbiddG0HiaNUW13=GRMXKfyxB+Yomq_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 09:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww4bO-0004jl-K3
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 09:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbaFOHKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 03:10:50 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:41622 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaFOHKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 03:10:49 -0400
Received: by mail-qa0-f41.google.com with SMTP id cm18so5827221qab.14
        for <git@vger.kernel.org>; Sun, 15 Jun 2014 00:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=vWzg2COHuaVXj3usBsVG8fg8jpHdstujEKRELW8iz9k=;
        b=ZofZ16y3VIROa4JBH4vuTfT/Mqwac+PE7SCgid96s+vt8XC3iG2npwF6Mf/NbEZdog
         +1vY8mOefwGAIdbqUtdNyKDGwFaF6MDHF3CdWvs6YjoGblzAB9rB5uYsvKnSD3iihoM5
         A36EkJ5GZbpFjvHr7tjmhxNOPxXGF0It+qyfl4jiGgfdFaVM2bm7d3SBDCjSBhlxdBW0
         XSK4AGH77dNgj1lSEisw0RAVIEqO/a9Cksmt2NOoSNkPSenDHc4+OHFQ+0nQoCHMt+wJ
         RFGLjLUK3oUQ7dOrTYcJzhip42xv625YSlS6fX2KJluT6NpWSQuqtKQbSdpLb4dyhmIb
         XHRg==
X-Gm-Message-State: ALoCoQmElmH3RuqYk26Qg+3I0ydxMAEwKPfgfrpwyZ4EDZTvPmg/XMuLQJbrWM8v3c8zvrYjCEAM
X-Received: by 10.140.43.100 with SMTP id d91mr15872489qga.11.1402816248180;
        Sun, 15 Jun 2014 00:10:48 -0700 (PDT)
Received: from [172.18.24.99] ([8.25.196.26])
        by mx.google.com with ESMTPSA id d2sm4421981qga.2.2014.06.15.00.10.46
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 15 Jun 2014 00:10:47 -0700 (PDT)
In-Reply-To: <CAL=YDWnHubbC3eOUjHtbiddG0HiaNUW13=GRMXKfyxB+Yomq_g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251670>

On Fri, 2014-06-13 at 12:05 -0700, Ronnie Sahlberg wrote:
> Thinking about it more.
> 
> I think we want to wait until the ref transaction API work is
> finished. The ref transactions API is in progress and it aims to add
> transactions for ref updates as a first step but then it aims to
> define a public API for all public ref functions. As part of that I
> will also develop support for pluggable ref backends. The first
> backend will be the current files based structure but I also will add
> an optional backend using a TDB database.

OK, in that case I'll shelve this patch for now (except that we'll
probably use it internally)  If for some reason pluggable ref backends
don't work out, we can always revive it.

Thanks to all for the reviews.  You can find the latest version at
https://github.com/dturner-tw/git/tree/case-ref .
