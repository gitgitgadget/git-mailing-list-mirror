From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for
 git-rebase
Date: Fri, 18 Mar 2016 12:01:34 +0100
Message-ID: <20160318110134.GA16750@hank>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
 <1457779597-6918-2-git-send-email-pyokagan@gmail.com>
 <alpine.DEB.2.20.1603160855390.4690@virtualbox>
 <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
 <alpine.DEB.2.20.1603161656130.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 12:01:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ags9Y-0002sf-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 12:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbcCRLBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 07:01:08 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38311 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbcCRLBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 07:01:04 -0400
Received: by mail-wm0-f44.google.com with SMTP id l68so31585077wml.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWyOx5jSzQeCG/84uMBgvZJ5k7IWavsL++N6Xyqk5uQ=;
        b=Fq+qZLOsfP1XWcx97tQup+wSsEALI1UNlNT92DzaOkJKwiSWNHukwefo7PyWpP2KqP
         xsao3WGS44zRs7kZpvZ3WNLhPSmhyASeM6nauttgS3rk4uqGahZjYycfSOdtfZtc+LbG
         y32Nyo6H/ket4gk3Ak8jI+GhIIs2UqloU9LHs5xNNvoP5C/V6JK7Py7436diksWoqdzc
         TyrfEnSTJ1xzG7osz/8X/hIMfIb62G6PK6s1+6R4bI3WRodz2P6/4/cOm5uydpnh2EFS
         r3q+/p/VrgQyd5QGZ8fC413ttnX6ZhMOfE1RVro5XMfOwPol5g/niMZ71XJoTQaeuvG5
         IgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWyOx5jSzQeCG/84uMBgvZJ5k7IWavsL++N6Xyqk5uQ=;
        b=JiEBxgByatuz5vtMKDckDNUGI7tZKqzuUEV1cXImFnwImT8OW3atrexw81HYubT0f1
         T6qL2BhwW9NB+ViHqkPe9ZmU5uETstyKGOStIX1jGwFV9N9wKFzDot2vDhxOtc+EiplG
         3tjaIzJ7f1NYn5T/cWEAhIKHXMbZURaFf3kKBbbpiNgXx7WzmtES48UdgSWKbvY96DkP
         +YuIz5+4mZWZUBu4SC8fFGg3Ys378OzNBX6JqaCmtdxeiu0PVMlRKUgJB2H6cn6u+q4m
         5EeP4/uN/e8ZJ1dSihawkrjmB3puv9n92v2PPKET1FNfeC1cjYUb0f2AnisIQZrHrODx
         8GJA==
X-Gm-Message-State: AD7BkJIwdLDCNJdp2fhJlMgcGecRXgqXaxugEIeh4eDzIiszIVi6XfhA+jIPPqsqb7/pFA==
X-Received: by 10.28.11.131 with SMTP id 125mr43204850wml.58.1458298862907;
        Fri, 18 Mar 2016 04:01:02 -0700 (PDT)
Received: from localhost (host86-185-232-204.range86-185.btcentralplus.com. [86.185.232.204])
        by smtp.gmail.com with ESMTPSA id ka4sm11729674wjc.47.2016.03.18.04.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2016 04:01:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1603161656130.4690@virtualbox>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289214>

On 03/16, Johannes Schindelin wrote:
> Hi Paul,
> 
> On Wed, 16 Mar 2016, Paul Tan wrote:
> 
> > On Wed, Mar 16, 2016 at 3:58 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Sat, 12 Mar 2016, Paul Tan wrote:
> > >
> > >> diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
> > >> new file mode 100755
> > >> index 0000000..aaca105
> > >> --- /dev/null
> > >> +++ b/t/perf/p3404-rebase-interactive.sh
> > >> @@ -0,0 +1,26 @@
> > >>
> > >> [...]
> > >>
> > >> +test_perf 'rebase -i --onto master^' '
> > >> +     git checkout perf-topic-branch &&
> > >> +     git reset --hard perf-topic-branch-initial &&
> > >> +     GIT_SEQUENCE_EDITOR=: git rebase -i --onto master^ master
> > >> +'
> > >
> > > This measures the performance of checkout && reset && rebase -i. Maybe we
> > > should only test rebase -i?
> > 
> > test_perf runs the same script multiple times, so we need to reset
> > --hard at least to undo the changes of the rebase.
> > 
> > I think we can remove the reset if we use rebase -f and rebase onto
> > the same base, but -f was not implemented in this patch series.
> 
> Hrm. rebase -f just makes the reset an implicit part of the rebase, so it
> seems we cannot perf *just* the rebase. We are stuck with perf'ing also
> the reset. Sad.

I had the same problem back when I was working on index-v5 and posted
a patch series.  The discussion about it is at [1].  Maybe it could be
worth resurrecting?

[1] http://thread.gmane.org/gmane.comp.version-control.git/1379419842-32627-1-git-send-email-t.gummerer@gmail.com

-- 
Thomas
