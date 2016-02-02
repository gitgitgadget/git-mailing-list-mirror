From: Andrew Martin <amartin@xes-inc.com>
Subject: Re: git object-count differs between clones
Date: Tue, 2 Feb 2016 10:21:17 -0600 (CST)
Message-ID: <203317792.714602.1454430077194.JavaMail.zimbra@xes-inc.com>
References: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com> <vpq7finm6v8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 02 17:21:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQdhl-0000Vn-OV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbcBBQVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 11:21:22 -0500
Received: from xes-mad.com ([216.165.139.218]:10007 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbcBBQVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:21:20 -0500
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id u12GLHi0005833;
	Tue, 2 Feb 2016 10:21:17 -0600
In-Reply-To: <vpq7finm6v8.fsf@anie.imag.fr>
X-Originating-IP: [10.52.16.96]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - GC47 (Linux)/8.0.6_GA_5922)
Thread-Topic: git object-count differs between clones
Thread-Index: ku0jODb2qrPaqHVltNTxiNjs9OLOYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285272>

----- Original Message -----
> From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> To: "Andrew Martin" <amartin@xes-inc.com>
> Cc: git@vger.kernel.org
> Sent: Tuesday, February 2, 2016 10:09:31 AM
> Subject: Re: git object-count differs between clones
> 
> Andrew Martin <amartin@xes-inc.com> writes:
> 
> > I ran "git fsck" on both, which reported no problems. Moreover, I ran "git
> > gc"
> > and made sure there were no objects pending garbage collection,
> 
> It's not sufficient: you may have objects reachable from your reflog,
> hence not candidate for garbage collection. Since the reflog is not
> propagated, pushing + cloning will not transfer these objects if the
> reflog is the only way to reach them.
> 
> You may try expiring your reflog and "git gc" again.
> 
Matthieu,

Thanks, I found some commits that are not referenced in any branch. How can I
remove these from the reflog? I tried running
"git reflog expire --expire=now --expire-unreachable=now --all" followed by
"git gc" but still the same number of objects remain.

Thanks,

Andrew
