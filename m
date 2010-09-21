From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Allow git remote add but not git clone ( was Re: [PATCH/RFC]
 Documentation/git-gc.txt: add reference to githooks)
Date: Tue, 21 Sep 2010 13:52:57 -0700
Message-ID: <4C991B29.4030208@gmail.com>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com> <1277744834-7546-1-git-send-email-judge.packham@gmail.com> <20100921181406.GA7389@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:52:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9pa-0005Kc-8r
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab0IUUwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 16:52:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41497 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab0IUUwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:52:44 -0400
Received: by pvg2 with SMTP id 2so1563634pvg.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WkyToVxKn5dEXu3OeWI5yfhYUGaVPDuUeazu0oBkU/w=;
        b=tCnSBCpY0sJHfpJwgfdbmmHoqyE6q1kfOHMlJb0luPGJIHi2018QAUBNESugAb1ktU
         s6VEoCckC7B7zwqzh8hB8jvGg3+AwDEeLvV0iGHGvb5ljiZG4Asu937sVFzTioIC84To
         EA8TF6x8DJrdIKhtH1B/baCvW8FtfJz3GE37Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=jWrp7o/EWTOEgosLQK2L/hZ+SBU3+K+GsM/htEiKSFaXa4sR1ixMDBoSL4I/vuOnjc
         EEBwVmcGkTgJcxMf10qhEw3SbC3AIjxMv2I7qUMn5M32yqQjckPdrE6qsr5WXeVtpCP5
         MKGdjTvtOykrYuYAHehogCQyewwLkCuuHELH4=
Received: by 10.114.26.6 with SMTP id 6mr12594199waz.82.1285102362357;
        Tue, 21 Sep 2010 13:52:42 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d2sm16187692wam.2.2010.09.21.13.52.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 13:52:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <20100921181406.GA7389@huya.qualcomm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156759>

On 21/09/10 11:14, David Brown wrote:
> Subject: Re: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks

Wow odd thread to pickup. Hopefully someone that knows more than me will
notice the change of subject an provide a better answer.

> Suppose I want to publish some changes to a tree.  I have a server
> available where I can run a git daemon, but for one reason or another
> I want to force people to use the another git repo as a reference.
> The reason could be one of bandwidth, or someone who isn't comfortable
> making all of the other source available.  Ideally, someone who
> already has the other git repo cloned, and just adds mine as a remote
> wouldn't notice the difference.

Sounds like a reasonable motivation.

> Is there a way to do this?

As far as I know no. The mechanisms that git clone and git remote
add/git fetch are fairly generic so I doubt there is a way for the git
daemon to know which was run by the user at the other end. Maybe there
are other possible solutions outside of git to but a cap the amount of
data sent. Doesn't look like there are any hooks on the upload-pack side
of git daemon.

> If there isn't a way of doing this currently, is this something that
> others would find useful?

I personally wouldn't but I can see why some people might want this.
