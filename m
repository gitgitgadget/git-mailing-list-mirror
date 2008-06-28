From: "Robert Anderson" <rwa000@gmail.com>
Subject: Fwd: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 23:31:24 -0700
Message-ID: <9af502e50806272331vfdbf35ap10fc4375518de946@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
	 <20080628021444.GI5737@dpotapov.dyndns.org>
	 <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com>
	 <20080628040344.GK5737@dpotapov.dyndns.org>
	 <9af502e50806272320p23f01e8eo4a67c5f6f4476098@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 08:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCTza-00081s-Ae
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 08:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYF1Gb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 02:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754208AbYF1Gb1
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 02:31:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:52432 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbYF1Gb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 02:31:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so401370fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kc+wmEVeup2B9Wf3gD6rxFvYDXZIkbjdry/KFOAzGJk=;
        b=l3acOvCWRxCAtlSFVghkZJlNIKSbmP9ZtwpkYyM2eCWavepapmZlphXW7A40SiL172
         ojMovlifn5LC2JRtc/C/Nghr97wsbVbwYjs5bwH7LnFGTUqRZ3VsLLINb3zeLU4Sbp3p
         ZncG7FNgXFlXbNNGXsW05xw/0e9m6WEAwSI68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UMlvvnV7kKSqMDkyZ92hSb/w6O00txhPSzIX62vkaL8KDoINH2h9QmLcHdD+7VK6k7
         SYpwFplm3YDZobOcJ287gM3OyPSM8dYN0YZ801gB4nBhHRNjWFeuWMNBubHIP0CUCS19
         81NgHv06hVD4USalSVALsYr6C8+M20+53SGjQ=
Received: by 10.86.87.13 with SMTP id k13mr3148951fgb.1.1214634684565;
        Fri, 27 Jun 2008 23:31:24 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 27 Jun 2008 23:31:24 -0700 (PDT)
In-Reply-To: <9af502e50806272320p23f01e8eo4a67c5f6f4476098@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86707>

On Fri, Jun 27, 2008 at 9:03 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Do you think commit only tested changes is a common policy among
> Git users?

I think there are various flavors of "tested" for which the answer is
certainly yes.  I think that a line of development which always
builds, for example, is very, very common.

> And as I said before, git commit
> is probably closer to saving a file than to what cvs commit does.

That is putting scm into the development process at a level which is
far too intrusively fine-grained for my workflow, and for the workflow
of any developer that I work with, which is dozens.  I do not need to
record every "save of file."  That is useless and intrusive to me.  It
is, however, useful to me to record (commit) at points significantly
more coarse grained than that:  points which represent logically
distinct changes to the code that compile, for example.  Until then I
prefer to forget about my scm and have it stay out of my way until it
is needed to create those desired recorded states.

>> This is enforcing a two-step process where there only need be one the
>> vast majority of the time, to require that commit and publish be
>> separate operations.
>
> I don't see it is a problem.

Fine, you like doing extra work for no benefit.  Enjoy yourself.

> I don't see why you think that is inefficient or error prone.

Plainly not.  This is why I will construct some examples.

> You have your working directory let's say on Linux, and you have to
> test your changes on Windows. So what do you do?

I rebuild on about a dozen platforms simultaneously on a cross-mounted disk.

>> No.  I have experience with a wide array of source control systems.
>> CVS fits my mental model the least well.  git is pretty close, but it
>> is not there yet.  The current partial commit facility is the biggest
>> misfire, in my view.
>
> Do you have your personal experience of using it

Yes.

> I don't see why git should know it.

Clearly not.  Example 1:  is it ok to publish?  If temporary commits
exist, git should stop you.  But git has no idea if temporary commits
exist or not.

Bob
