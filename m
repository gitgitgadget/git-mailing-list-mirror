From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 22:10:15 +0200
Message-ID: <4F737027.5020503@ira.uka.de>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>	<7vbongyd67.fsf@alter.siamese.dyndns.org>	<vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzBY-0007Cu-F4
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab2C1UJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:09:30 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60869 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932206Ab2C1UJa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 16:09:30 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SCzBK-0001vr-Bm; Wed, 28 Mar 2012 22:09:27 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SCzBK-0003Zo-6U; Wed, 28 Mar 2012 22:09:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <vpqk424zfb1.fsf@bauges.imag.fr>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1332965367.839743000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194182>

On 28.03.2012 21:38, Matthieu Moy wrote:
> Holger Hellmuth<hellmuth@ira.uka.de>  writes:
>
>> and additionally the following three options:
>> b - choose the base version
>> <  - choose our version
>>> - choose their version
>
> What does it mean to "choose" in this context? In general, it means "put
> this into the index", but if the file is in conflicted state, you have 3
> different versions of the file in the index.

The only ways to exit with the proposed reduced options is to either 
quit adding this file (which is comparable to Eriks option 4) or 
resolving all conflicts in the file thereby allowing to add this file to 
the index.

> And you miss the most usefull (to me at least): "choose the version in
> the worktree".
>

But the conflicted chunks are of the form "<<<< our ... |||||||||| 
theirs >>>>>>" in your work tree. So there are two cases:

a) You have removed the markers thereby removing the conflict -> this 
means the chunk will not be offered to you as a conflicting chunk

b) You haven't removed the markers. Then there is a choice between base, 
our and their version.
If you had edited one of the versions between the conflict markers in 
your working tree without removing the markers (which wouldn't be a 
sensible thing) then it depends on whether the chunk in the working tree 
or the versions in the index are used as a basis for the choosing, but I 
suspect using the working tree version is easier to do.
