From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Tue, 21 May 2013 20:38:12 +0300
Message-ID: <519BB104.9060802@bracey.fi>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com> <1369132915-25657-3-git-send-email-artagnon@gmail.com> <7vppwkp961.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 19:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqnO-0000mV-EC
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab3EUR4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:56:18 -0400
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:57894 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3EUR4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:56:17 -0400
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id C4C4AFFBF48
	for <git@vger.kernel.org>; Tue, 21 May 2013 19:38:15 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 21 May 2013 19:38:15 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 21 May 2013 19:38:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <7vppwkp961.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 12755601520012202200
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeigedrtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500003/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeigedrtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225052>

On 21/05/2013 19:52, Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> The empty string '' looks ugly and inconsistent with the output of
>> <branch>@{<N>}.  Replace it with the string 'current branch'.
> Wouldn't that be '*the* current branch'?
>
> More importantly, doesn't "real_ref" have the name of the branch?
>
> Suppose the user said "git show @{10000}" instead of "git show
> master@{10000}" while on 'master'.
>
> It could be argued that it may look nicer to say "your current
> branch does not have enough update history" instead of saying
> "master does not..." (i.e. different input to ask for the same
> thing, different output depending on the way the user asked).  It
> also could be argued that they should produce the same diagnosis
> that is more informative.
>
> I am slightly leaning toward the latter.
That would also avoid the complaint I was about to make that putting 
'current branch' in scare quotes would be annoying.

Kevin
