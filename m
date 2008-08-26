From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 13:49:26 +0200
Message-ID: <200808261349.28771.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <200808261015.37023.jnareb@gmail.com> <cb7bb73a0808260358o41a04a9ara701e6c726cf2298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXx4P-0002xw-QF
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 13:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYHZLtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 07:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYHZLtl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 07:49:41 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:40167 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbYHZLtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 07:49:41 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1715410ika.5
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dq7ylzMkOGvuQ32cRqVbth37e8i56KFZ5qXVt+zvlTk=;
        b=TwBrAfiyXGt1HAsHzaes/2KlIXRfL64PZWd+GEFqy+b9gA9atk6ny/KZza6xn4HL/a
         QLHe2B4HmOQTjTV7ZgnTuo+B9uM2r+VHwDrb75i/Z/hrtHLgpZY5x0WAY51OR0rTPRWC
         Gu6rjHX8pOKp6zFCoROApBnJoy1Ap2fGNOhT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ECovgx/0O8r1jQBP3Hl1xyO79MOkz+SDZFVMa1qmmr2TsvpZyckaP+hivUWK91+Rvx
         myb0oGXxLs8GDWvtLKl7CrsCq0gp5DlLH3KrDv4YagytOUYs2kOWpgRObB4SaNvgGPti
         40Ik+uLFSb1pGCPJggIFDpv+S/hBf448jlvS0=
Received: by 10.210.104.20 with SMTP id b20mr8288385ebc.127.1219751378718;
        Tue, 26 Aug 2008 04:49:38 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.77])
        by mx.google.com with ESMTPS id 7sm6570390eyg.0.2008.08.26.04.49.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 04:49:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0808260358o41a04a9ara701e6c726cf2298@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93737>

On Tue, 26 Aug 2008 12:58, Giuseppe Bilotta wrote:
> On Tue, Aug 26, 2008 at 10:15 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > BTW. one thing that can be done is consolidation of "guessing action"
> > code: it is done by simply calculating what is to put in $action during
> > dispatch, or is done in 'object' view to calculate redirect URL with
> > proper action.  I have tried to bring them together, but patches were
> > I think lost in the noise.
> 
> Ah, but the problem is that guessing the action based on the object
> sometimes depends on the context: for some cases the 'commit' action
> is the correct one for commits, in other cases shortlog is preferred.
> This is why I introduced the %views hash in some of my patches.

By the way, this is argument *for* selecting action when generating
link, if it is possible without incurring unnecessary (if you don't
follow the link) performance penalty.  For example in the case of
ref markers links, you can link to 'log' in log view, 'shortlog'
in 'shortlog' view, perhaps even 'history' in 'history' and 'tree'/'blob'
views; or just 'shortlog' in all other views (for "commit subject"
line heading).

Just my 2 eurocents.
-- 
Jakub Narebski
Poland
