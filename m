From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 05:48:10 -0500
Message-ID: <5362266a3ca00_284da2f2eca3@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 12:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfohZ-0000na-DM
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 12:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbaEAK6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 06:58:49 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:45232 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbaEAK6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 06:58:48 -0400
Received: by mail-yh0-f48.google.com with SMTP id v1so2805619yhn.21
        for <git@vger.kernel.org>; Thu, 01 May 2014 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=krU406uP5Hty1Yuk8EbC5zCGqzr26dg9n+DIuQAdx4s=;
        b=GjLCP3Nbc2BEKdshy+CRY4o4mfx6Xc4oJFZhpyACApbSNI9wlfIN6T4ORcvVWE2mCI
         Ri7P8oGBrSJVIvHJ8j4M84B89fISKTTOQU9rfRbPkaVzA99Wd0jN122ggpr+N5ero8qX
         OvYR8ahJgSI8hz1UBkeG6nk91MaOvusObqjYm4JCZbfieM/EnZNs4Oj/R0p2TYwjQPAq
         eVV6BQazL/52dt8y4onaLEHPjrBqjrdoQwKyF/vJh+fVygPCwLPXUY9gJ4mylwvNHt6P
         RXtb028yrUS+UKCH9bf1b7qW2+EghWmcIRwZN8DDg9J1Cgdh8T7AlQU4vua04//N83TE
         nDYg==
X-Received: by 10.236.140.16 with SMTP id d16mr13505948yhj.55.1398941927890;
        Thu, 01 May 2014 03:58:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c66sm48224952yhk.23.2014.05.01.03.58.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 03:58:46 -0700 (PDT)
In-Reply-To: <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247808>

brian m. carlson wrote:
> On Wed, Apr 30, 2014 at 05:25:59PM -0500, Felipe Contreras wrote:
> > Marc Branchaud wrote:
> > > On 14-04-30 04:14 PM, Felipe Contreras wrote:
> > > > What is wrong when `git pull` merges a fast-forward?
> > > 
> > > Nothing.  Everything.  It depends.
> > 
> > It depends on what? I don't see how a fast-forward `git pull` could
> > possibly have any trouble.
> > 
> > > > The problems with `git pull` come when you can't do a fast-forward merge, right?
> > > 
> > > Some of them, maybe most of them.
> > 
> > Name one problem with a fast-forward merge.
> 
> At work, we have a workflow where we merge topic branches as
> non-fast-forward, so that we have a record of the history (including who
> reviewed the code), but when we want to just update our local branches,
> we always want fast-forward:
> 
>   git checkout maintenance-branch
>   # Update our maintenance branch to the latest from the main repo.
>   git pull --ff-only
>   git pull --no-ff developer-remote topic-branch
>   git push main-repo HEAD
> 
> So there are times when fast-forward merges are the right thing, and
> times when they're not, and as you can see, this depends on context and
> isn't per-repository.

That's not what I asked.

I didn't ask you if fast-forward merges were the right thing to do in
every situation.

I asked you, *when* people do a fast-forward merge (that is; when it's
possible and desirable), what are the problems that a fast-forward merge
causes?

I tired of waiting, so I'll answer for you: there are absolutely no
problems. The problems are only on non-fast-forward merges, and we have
a solution.

-- 
Felipe Contreras
