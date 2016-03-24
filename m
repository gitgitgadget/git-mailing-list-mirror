From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Mar 2016, #04; Wed, 23)
Date: Thu, 24 Mar 2016 07:42:07 -0000
Organization: OPDS
Message-ID: <54B6C1E1FE6A4BAEA07E97B7BA81EB01@PhilipOakley>
References: <xmqqpoukc30t.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:42:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aizuI-0004Sq-DI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 08:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbcCXHmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 03:42:10 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:25508 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252AbcCXHmI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 03:42:08 -0400
Received: from PhilipOakley ([92.22.21.19])
	by smtp.talktalk.net with SMTP
	id izu9aWRizEnBtizu9aKnhH; Thu, 24 Mar 2016 07:42:06 +0000
X-Originating-IP: [92.22.21.19]
X-Spam: 0
X-OAuthority: v=2.1 cv=YNU/sUyx c=1 sm=1 tr=0 a=I7bjfyOo2Kke1IIJyMFemw==:117
 a=I7bjfyOo2Kke1IIJyMFemw==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8 a=LmBk-rk3AAAA:8
 a=G-sI35Mni8sQ33JZkVUA:9 a=wPNLvfGTeEIA:10 a=IdEGqN_9JTMA:10
 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfN2xfs4PPFOZhQNN4t/R02ErBnM/khLHIATMuwwAT7wswU+tScq0N3OYwisbRgvOiYLjwEJAvDsjet/9ZS5ApaayCPc4sGET7EmrMxfmH+9rIIu7WYfs
 GVo0n49HS7kQ2BdVzWFqOGbYs9zrR91HaGE8B/im12ARP13DmGv/xZA+cXSZ9Vteec6v/iKA54z78w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289720>


----- Original Message ----- 
From: "Junio C Hamano" <gitster@pobox.com>


> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> Three more minor fix-up topics are to be merged by 2.8 final, but we
> are almost there.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>    http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
...
> [Cooking]
>
> * jc/bundle (2016-03-03) 6 commits
> - index-pack: --clone-bundle option
> - Merge branch 'jc/index-pack' into jc/bundle
> - bundle v3: the beginning
> - bundle: keep a copy of bundle file name in the in-core bundle header
> - bundle: plug resource leak
> - bundle doc: 'verify' is not about verifying the bundle
> (this branch uses jc/index-pack and jc/maint-index-pack-keep; is tangled 
> with jc/index-pack-clone-bundle.)
>
> The beginning of "split bundle", which could be one of the
> ingredients to allow "git clone" traffic off of the core server
> network to CDN.
>
...
Hi Junio,

I think there may be a concept clash between the ideals of a 'sneakernet 
bundle' and the 'resumable clone'.

The bundle capability still needs to work easily in sneakernet mode, and my 
reading of the proposed code for V3 (split-bundle) left the impression that 
it would be very hard for the user to do the manual transport of the files 
and place the split bundle in the right places such that a local clone from 
the bundle would still work.

Part of the issue is getting the naming right so so that there is no 
confusion between the two opposing capabilities (on-line vs off-line 
transfer).

There were a few other lesser point that I'll address when I have the right 
moment to reply to their respective messages.
--
Philip
