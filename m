From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 11:43:52 +0300
Message-ID: <20060618114352.15191199.tihirvon@gmail.com>
References: <1150609831500-git-send-email-octo@verplant.org>
	<20060618110749.e6fb9030.tihirvon@gmail.com>
	<20060618082103.GA1331@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frssx-0000uz-2k
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWFRIn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWFRIn4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:43:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:32950 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932172AbWFRInz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:43:55 -0400
Received: by nf-out-0910.google.com with SMTP id y25so1136237nfb
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 01:43:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=VMwzgRFpDuhC/moaUMh9cCLSroUwagXqsToEQJYVQ5urkgNifJ7Wk6QNXgEOvXS2V3BfEl0V2yAZ5vuSWYoJvTRpCsSuy5be/vWrxgkN2c6qFlowk6rfdqPz6Jc1BLg1RTm06e9HvBd1FQpDNuu4RwEDFyrgfiN2wCi76vPKc2M=
Received: by 10.49.72.7 with SMTP id z7mr3512721nfk;
        Sun, 18 Jun 2006 01:43:54 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id c10sm5481389nfb.2006.06.18.01.43.53;
        Sun, 18 Jun 2006 01:43:54 -0700 (PDT)
To: Florian Forster <octo@verplant.org>
In-Reply-To: <20060618082103.GA1331@verplant.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22063>

Florian Forster <octo@verplant.org> wrote:

> GCC ignores the FAM in this case and allocates `sizeof (struct
> combine_diff_path)' bytes. However, this is not correct according to
> ANSI and prevents building using other compilers (e.g. Sun cc).

Fair enough.

> To be honest, I don't get the point of FAMs anyways. Why don't we just
> use a pointer to `struct combine_diff_parent' there in the first place?

In general FAMs are used to replace two mallocs with one.

    x = malloc(sizeof(struct foo) + 100)

instead of 

    x = malloc(sizeof(struct foo));
    x->y = malloc(100);

-- 
http://onion.dynserv.net/~timo/
