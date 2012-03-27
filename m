From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Merge-friendly text-based data storage
Date: Tue, 27 Mar 2012 17:46:25 +0200
Message-ID: <4F71E0D1.2040600@ira.uka.de>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com> <4F718496.4030808@ira.uka.de> <CAD77+gR=p+jhN5qNoRgjtQPHqgqrdtcSmqAy_4d0NUaqE6ZkVg@mail.gmail.com> <7vzkb2jchu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCYan-00049U-E3
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 17:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab2C0Pps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 11:45:48 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57589 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131Ab2C0Pps (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 11:45:48 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SCYaQ-0004XS-9w; Tue, 27 Mar 2012 17:45:45 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SCYaQ-0000U4-56; Tue, 27 Mar 2012 17:45:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vzkb2jchu.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1332863145.295590000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194052>

On 27.03.2012 17:21, Junio C Hamano wrote:
> Richard Hartmann<richih.mailinglist@gmail.com>  writes:
>
>>> the only way
>>> would be to store each data line in its own file. As you store file paths
>>> that would even fit, but I doubt it is what you had in mind
>>
>> I considered this as well, but that's extremely expensive and wasteful.
>
> And it does not solve anything.  The "version" file may cleanly merge to a
> new version, and there is no way for the merge result of "version" file to
> affect the outcome of merges in other files.

It solves the data merging.

And since a version change is presumably a very scarce event, this could 
be solved with a merge hook that simply aborts the merge with a message 
how to update the older version, then commit and merge.
