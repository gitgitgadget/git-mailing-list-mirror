From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: log -p hides changes in merge commit
Date: Fri, 07 Jan 2011 14:27:34 -0500
Message-ID: <4D276926.2020407@cfl.rr.com>
References: <4D25F6BE.7010300@cfl.rr.com> <7vwrmhakdz.fsf@alter.siamese.dyndns.org> <4D262B05.2060306@cfl.rr.com> <20110106210438.GB15090@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHtZ-0001ym-Mu
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab1AGTWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:22:36 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:37304 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1AGTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:22:36 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=Inhw+Jdt7z1D3BivGPfn2aw54OvUEJw5lAn/booRZkE= c=1 sm=0 a=D86Jg8a-DgoA:10 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=ijR02lzDn6eqOa_-tBUA:9 a=XvR2V7OpgDCsnfRj3eHQGhfF2VYA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2826] helo=[10.1.1.235])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id FC/FB-13137-AF7672D4; Fri, 07 Jan 2011 19:22:34 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110106210438.GB15090@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164745>

On 1/6/2011 4:04 PM, Jonathan Nieder wrote:
> In case (1), -c will show a "combined diff" for files where master
> does not match either the old master or topic.  --cc, on the other
> hand, will correctly suppress these uninteresting diffs.
> 
> In case (2), -c will show a noisy "combined diff" as before.
> --cc will show a combined diff when the changes from both parents
> touch nearby code, even if it merged trivially.
> 
> In case (3), -c and --cc will show the semantically boring but
> syntactically interesting merge.
> 
> Case (4) is underspecified.  So let's give a more precise example:
> the old master and topic tried to fix the same bug in two incompatible
> ways.  When merging, I decide I like the topic's way better, so I
> resolve conflicts in favor of the topic.  Hopefully all unrelated
> changes on master were preserved!
> 
> In this case, -c and --cc will very likely show nothing at all.
> Each file matches one of the two parents (old master or topic) so
> there is no easy way to distinguish the case from (0) or (1).

That does help me understand the difference between -c and -cc, but I
still don't see why one or the other is not the default behavior of log
-p, instead of opting to never show anything at all for merges?
