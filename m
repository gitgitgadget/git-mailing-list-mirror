From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Sat, 7 Sep 2013 00:19:39 +0100
Organization: OPDS
Message-ID: <94A71512041A4F9BB402474DB385E310@PhilipOakley>
References: <20130906155204.GE12966@inner.h.apk.li><6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley> <xmqqfvthyfui.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 01:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI5Hc-0001kD-QZ
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 01:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab3IFXRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 19:17:35 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:44520 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750867Ab3IFXRe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 19:17:34 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ak4MAANiKlJOl3GZ/2dsb2JhbABbgweJbrhvBAQBgSYXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGFOAcBghIjwTePfIMkgQADiH2GEppMgTqBZzs
X-IPAS-Result: Ak4MAANiKlJOl3GZ/2dsb2JhbABbgweJbrhvBAQBgSYXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGFOAcBghIjwTePfIMkgQADiH2GEppMgTqBZzs
X-IronPort-AV: E=Sophos;i="4.90,857,1371078000"; 
   d="scan'208";a="587701596"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with SMTP; 07 Sep 2013 00:17:31 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234109>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Does this have any impact on the alleged bug in `git bundle --all`
>> (which can then be cloned from) where the current HEAD ref wasn't
>> included in the bundle? Or am I mis-remembering?
>
> Not "current HEAD ref", but "git clone" will fail to check out from
> a bundle that does not include HEAD ref (it is easy to just say
> "reset --hard master" or whatever after it, though).
>
> I think I suggested to update "git bundle" to include HEAD when
> there is no HEAD specified some time ago, but I do not think anybody
> was interested, so this may be a non-issue.
>
Just had a quick look at a very quick test repo (10 objects, 2 branches) 
and the bundle file does contain the HEAD ref, but again it has the two 
ref/heads/* are better than one problem, in that the clone from the 
bundle checks out master, whilst the source repo has feature checked 
out.

Philip 
