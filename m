From: Hans-Christoph Steiner <hans@at.or.at>
Subject: Re: developing a modified Linux-style workflow
Date: Tue, 4 Jan 2011 14:01:21 -0500
Message-ID: <344D6422-8F2B-4545-A680-06F434C17F5B@at.or.at>
References: <E54235A96EB484418EBD9509F37176D210049C61@htmail10.hightouchinc.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaC8Q-0008TZ-5B
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab1ADTBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:01:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39378 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624Ab1ADTBX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 14:01:23 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 642B820C05;
	Tue,  4 Jan 2011 14:01:22 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 04 Jan 2011 14:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references; s=smtpout; bh=LQnrg/1Dx1laKxY8XOf7V1ETI+I=; b=YPYnFacBWJIla19qtJzpWIqk6Dtk3E1/PSq6iRppJwGC9ekyKdJnX1kJUXemSXov/34LNi4YfkLDDHqntc5yqnj027QZaaekGFrc7/dVizF3es4DVOJ8x3KpHTGWbkbj2v0hB+1UWzrA5dFQY76B8+59gRXCjs57+ENCGPFncm0=
X-Sasl-enc: Dl+9vYvBuwh5fz1e7eXzz5WSXxylflQPhXYfkeY+iQXE 1294167682
Received: from [192.168.0.49] (rrcs-72-43-163-158.nyc.biz.rr.com [72.43.163.158])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 26697402A8C;
	Tue,  4 Jan 2011 14:01:22 -0500 (EST)
In-Reply-To: <E54235A96EB484418EBD9509F37176D210049C61@htmail10.hightouchinc.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164505>


On Dec 13, 2010, at 11:16 AM, Neal Kreitzinger wrote:

> "Hans-Christoph Steiner" <hans@at.or.at> wrote in message
> news:7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at...
>>
>> Hey all,
>>
>> (and my second post on this list...)
>>
>> I've gotten pretty good at git, and its helping me already with   
>> managing
>> the very odd workflows I have with the software I work a lot  on  
>> called Pd
>> (http://puredata.info).  My role in Pd development is  like a Linux
>> lieutenant.
>>
>> I also the main dev for an app called Pd-extended, which is based  
>> on  Pd.
>> Now I'm stuck trying to figure out how to use git to match my   
>> current
>> workflow for Pd-extended, which is a kind of long-lived  branch,  
>> almost
>> like a friendly fork.  So its kind of close to the  Linux workflow  
>> with me
>> as a lieutenant, but not quite.
>>
>> What makes it tricky is that I make releases directly from my repo   
>> that
>> are widely used.  So my repo is both lieutenant and dictator at   
>> the same
>> time.  So that's where I am stumped.  I want to be able to  rebase  
>> and
>> push to a public repo, but that would be stupid.  So there  has got  
>> to be
>> another way.
>>
>> .hc
>>
> I don't think pushing to a public repo is stupid.  You could create  
> a bare
> repo with a Pd branch and Pd-extended branch that contain the  
> production
> versions of Pd and Pd-extended.  The main reason our shop chose git is
> because it allows us to easily have multiple concurrent versions of
> production by having a branch for each of our custom versions.  These
> versions eventually get merged together into a major release, but in  
> the
> meantime they are longlived branches representing the productional
> customized system for each major customer.
>
> *If* you end up merging Pd and Pd-extended at some point, then you  
> could
> have another branch for that, e.g. master or Pd-master or whatever.   
> BTW,
> you do not have to use master as the representative of your final  
> merged
> work so don't think that is the way you HAVE to do it.  It's just the
> default, and a common practice for systems with a single version of
> production.  Master can become vestigial or secondary, if you choose  
> to
> create a new branch called Pd-master, etc. to represent your  
> eventual merges
> of Pd and Pd-extended.


For me the biggest feature that I am looking for is the automatic  
merging of commits, and second, having a branch that puts my  
collection of patches/commits ahead of the Pd master so that its easy  
to manage the patches.  I don't think I see how I could do that with  
this multiple branches idea.  Is that possible?

.hc



----------------------------------------------------------------------------

I have the audacity to believe that peoples everywhere can have three  
meals a day for their bodies, education and culture for their minds,  
and dignity, equality and freedom for their spirits.      - Martin  
Luther King, Jr.
