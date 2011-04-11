From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 01:42:47 -0500
Message-ID: <20110411064247.GB6608@elie>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <20110410194739.GC28163@elie>
 <alpine.LNX.2.00.1104102028240.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 08:43:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Apw-0002Dt-1M
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 08:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab1DKGmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 02:42:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49172 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1DKGmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 02:42:53 -0400
Received: by iyb14 with SMTP id 14so5318012iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 23:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=q+CPpFLbiDQFTThT97MPHOMdneHuTzqc/0XnKXCdLAI=;
        b=xvh8P1LnXeDaitRCfM0gIyQkJHm2oR90lwEJE2YAu1Lc4osOxZ8f7WYwbTPzOiTm2i
         jfNm97cPpkn6Kua4LFIYMw+WWkEzE53sVfpBMG2eOPMCnTVvKmmGQC9yNWiEmdFCmOi6
         3j317okT322e2Ifkdrz5fkjKoxVjnIQ6A/SEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QCdjt+0lwVmcjy4QLDZJuiWV9FjBPldj/xY9H16zuCgJ2HRsSS4h/HSWh4c+c473x5
         R7U8vl04OCwZ6+8+po1qW9YgOUDugqXQVOpfxShlNYLEEZ5Qpi3ErnN1b3+7/QnfmA2g
         CbiMmONOVbuzjBxh4xa7dxya94QkJoM0+NdYk=
Received: by 10.42.99.133 with SMTP id w5mr7542938icn.437.1302504172988;
        Sun, 10 Apr 2011 23:42:52 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.ameritech.net [69.209.51.92])
        by mx.google.com with ESMTPS id hc41sm4009926ibb.47.2011.04.10.23.42.50
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 23:42:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104102028240.14365@iabervon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171310>

Daniel Barkalow wrote:

> My feeling is that "--skip" is actually "abort the pick, but continue the 
> rebase". I suppose there could be more than two levels, and people could 
> want to skip a higher-level chunk, but that's something to get to when 
> someone actually wants it

Ah, I think I see better now.  What was confusing was

	git cherry-pick foo..bar

for which --skip would mean "abort the pick, but continue the pick".
It fits very well into your story.  There are two levels: "atomic"
(for lack of a better word) operations, like a single cherry-pick, and
sequences of operations.

(As for the more-than-two-levels story, I want it, but I agree with
you that that is tangential to this project.  I find myself attempting
to go back and rearrange earlier commits during an interactive rebase
very often.)
