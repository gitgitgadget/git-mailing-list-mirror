From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 19:45:43 +0200
Message-ID: <200610201945.43957.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45390168.6020502@utoronto.ca> <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 19:45:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GayRJ-0005KC-1B
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992516AbWJTRpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992526AbWJTRpp
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:45:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:7376 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992516AbWJTRpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 13:45:45 -0400
Received: by ug-out-1314.google.com with SMTP id z34so689015ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 10:45:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rKZjcUKT7+OgasXvFE/+VLeejsqTrWn8NF0d1YepiUvOZ/MBQ3RGZfa1fMSz23LX7fJf+JO9goLQ8vnHiEpBdmC1NWzjNGGFCBIUn/5LUvC+y+k9ABkcdHUkbKnuGRUD5jBB0pHhRCQZ06QrtFR+WfuTR4Tfu6POMyMswrsTiSo=
Received: by 10.66.244.11 with SMTP id r11mr2306246ugh;
        Fri, 20 Oct 2006 10:45:42 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id k1sm1716966ugf.2006.10.20.10.45.41;
        Fri, 20 Oct 2006 10:45:42 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29509>

Linus Torvalds wrote:
> 
> On Fri, 20 Oct 2006, Aaron Bentley wrote:
>> 
>> All solutions have disadvantages.  We prefer the disadvantages that come
>> from using file-ids over the disadvantages that come from using
>> content-based rename detection.

If I remember correctly, git decided on contents (plus filename)
similarity based renames detection because 1), it is more generic
as it covers (or can cover) contents moving not only wholesome rename
of a file, and 2) because file-id based renames handling works only
if you explicitely use SCM command to rename file, which is not the
case of non-SCM-aware channel like for example patches (and accepting
ordinary patches is important for Linux kernel, the project git was
created for).

Another problem with file-id based rename handling is not handling
file copying (correct me if I'm wrong), and troubles with removing
or renaming a file, then having new file with old name.
 
> That's fine, but please don't call the git rename handling "maybe" or 
> "partial", like a lot of people seem to do. 
> 
> Git _definitely_ handles renames, both in everyday life and when merging. 
> Some people may not like how it's done, but other (I'll say "equally 
> informed", even though obviously I know better ;) people really don't like 
> the way bzr or others do their rename handling.

I think that "partial" refers to not complete handling of renames
for file history; pathspec doesn't follow history. Although the
information is there in SCM, it's the tools that need extension
(the --follow of rename following single file pathspec limit
proposal).

There was also suggestion of rr2-cache, which would record corrections
to automatic rename detection (rename/copy conflict resolving) 
if I remember correctly.
-- 
Jakub Narebski
Poland
