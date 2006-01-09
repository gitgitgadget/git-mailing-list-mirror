From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:53:12 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, <torvalds-3NddpPZAyC0@public.gmane.org>,
	<linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<akpm-3NddpPZAyC0@public.gmane.org>, <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 06:54:03 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evpyf-0004V2-1E
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 06:53:57 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932385AbWAIFxz (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Mon, 9 Jan 2006 00:53:55 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1750934AbWAIFxz
	(ORCPT <rfc822;linux-acpi-outgoing>); Mon, 9 Jan 2006 00:53:55 -0500
Received: from fmr14.intel.com ([192.55.52.68]:64896 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750749AbWAIFxy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Mon, 9 Jan 2006 00:53:54 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k095rGpE016255;
	Mon, 9 Jan 2006 05:53:16 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k095rGmY027155;
	Mon, 9 Jan 2006 05:53:16 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006010821531608907
 ; Sun, 08 Jan 2006 21:53:16 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 21:53:15 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 8 Jan 2006 21:53:15 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUiMwPhgoBlx6KSjq/Dh8hEV8oYAAV/RaA
To: "Martin Langhoff" <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-OriginalArrivalTime: 09 Jan 2006 05:53:15.0685 (UTC) FILETIME=[FBD41D50:01C614E0]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


>On 1/9/06, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> Perhaps the tools should try to support what "a lot of people"
>> expect, rather than making "a lot of people" do extra work
>> because of the tools?
>
>I think it does. All the tricky stuff that David and Junio have been
>discussing is actually done very transparently by
>
>    git-rebase <upstream>
>
>Now, git-rebase uses git-format-patch <options> | git-am <options> so
>it sometimes has problems merging. In that case, you can choose to
>either resolve the problem (see the doco for how to signal to git-am
>that you've resolved a conflict) or to cancel the rebase. If you
>choose to cancel the rebase, do
>
>   cp .git/refs/heads/{<headname>,<headnamebadrebase>}
>   cat .git/HEAD_ORIG > .git/refs/heads/<headname>
>   git-reset --hard
>   rm -fr .dotest
>
>and you'll be back to where you started. Perhaps this could be rolled
>into something like git-rebase --cancel to make it easier, but that's
>about it. The toolchain definitely supports it.

This is completely insane.
Do you have any idea what "sometimes has problems merging" means
in practice?  It means the tools are really nifty in the trivial
case but worse than worthless when you need them the most.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
