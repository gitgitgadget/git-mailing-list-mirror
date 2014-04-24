From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Wed, 23 Apr 2014 22:55:55 -0500
Message-ID: <53588b4b84323_59ed83d3083b@nysa.notmuch>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
 <1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
 <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
 <5281DB46.2010004@bbn.com>
 <5282977b2ecd_3b98795e785e@nysa.notmuch>
 <xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
 <xmqqob5pfa6j.fsf@gitster.dls.corp.google.com>
 <52a2f1c59de6f_29836d5e9830@nysa.notmuch>
 <xmqqbo0pyc2u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 06:06:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdAve-0007XL-HR
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 06:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbaDXEGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 00:06:24 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57143 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaDXEGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 00:06:23 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so2087203obc.31
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=5OFvkQ8SrSwCaFfB22PpL79AyhqNXtVTA12HmRgPr0U=;
        b=AJLsfqQ9yiAXIKR53EtPiOPKUzULEOT+MLS8phz2u9xpOmeJDAV4DyT5WVQYTzV2/h
         KbiN0wMV7MYkDsWPcDP18PvMabyq5a4AE2RaZnrEXjLNw/cTaXEBbaae0kWs93Js/0zu
         F+VFXVLU+psw1vUKN2l+47p5QSqNs3VLonXq7xClRhtXmNysPqc1kZHmX/x+4BRGOd98
         NNXoAYiIMVI7/mFZ+MhGe25qRJsQHknz2/x/yzmdsvKeKufMmMi/GRzEAGyC+oxDPKMQ
         /3n9PApFW+qGgXFKP/l34hl7V/iSgBewba22qqSs7t6muZOSdNsxtzQBQsUErglpcngo
         xy3A==
X-Received: by 10.60.51.69 with SMTP id i5mr45355306oeo.17.1398312382941;
        Wed, 23 Apr 2014 21:06:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm12528679oen.3.2014.04.23.21.06.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 21:06:21 -0700 (PDT)
In-Reply-To: <xmqqbo0pyc2u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246933>

Hi,

Sorry it took too long to reply to this.

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> But it does not have to stay that way.  In order to move things
> >> forward in that direction, this new configuration has to be
> >> distinguishable from the traditional "refspec", as it embodies a
> >> different concept.
> >
> > Is it a different concept?
> >
> >  % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
> >  % git fetch origin master
> >
> > What do you call this thing? ------^
> 
> The answer to that question is the "value of the 'remote.*.fetch'
> configuration variable".

You are avoiding the question: it's a refspec.

> There is no "refs/heads/next:refs/remotes/origin/next" here, because
> the 'fetch' configuration is not used as a refspec, but as something
> else.

Yet both remote.fetch and remote.push are a 'struct refspec', and the
documentation says they are a "refspec".

> My understanding of the added option parameter to "git fast-export"
> is that it is not about specifying the history being transferred,
> but is about mapping the name of the destination.  For example, does
> object between 'master' and 'next' participate in the datastream
> produced with this?
> 
> 	fast-export \
>             --refspec=refs/heads/master:refs/remotes/origin/master \
>             --refspec=refs/heads/next:refs/remotes/origin/next \
>             master
> 
> If this parameter were a refspec, as we have discussed already in
> previous rounds [*3*], we should be able to give it on the command line,
> like any normal refspec, instead of repeating the same thing
> (i.e. up to what commit should the history be transported) as in:
> 
> 	fast-export --refspec=refs/heads/master:refs/remotes/origin/master master
> 
> but just
> 
> 	fast-export refs/heads/master:refs/remotes/origin/master

Maybe in an ideal world, which we don't live in.

My guess is that trying to accomplish such a goal would result in an
unbelievable mess of the code that I wouldn't even want to think about where
to start to code this.

Moreover, `git grep refmap` returns me the following:

  t/t5516-fetch-push.sh:test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
  t/t5516-fetch-push.sh:test_expect_success 'with no remote.$name.push, it is not used as refmap' '

I'd say with --refspec is the simplest and most sensible way this can be
implemented.

-- 
Felipe Contreras
