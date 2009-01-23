From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Fri, 23 Jan 2009 13:04:22 +0100
Message-ID: <200901231304.23977.jnareb@gmail.com>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org> <200901120225.30175.jnareb@gmail.com> <1232548106.4977310a95d8f@mail.nimag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Sebastien Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQKms-0002Bz-Sr
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 13:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbZAWMD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 07:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZAWMDz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 07:03:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:35872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZAWMDy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 07:03:54 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2527567fgg.17
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KdZYTBitU9nPKKHKVzFNcJWbYsI9rxql+IM6ms3Fkic=;
        b=TfKtq1yeZoJwCPMp0Y7C+Q92O0aX12ImMUDKoH8GhWgxDLm9jCo/ruPzZoKCn7TNyS
         s0DfjUt+P9TpXepM7xfynDyw2uE+CYYhcBevOQY1zmbKGydd4hWGUGxvQvzh97plBK+J
         0hXKO5U/WEPcEvQqCjfGh6qd4vNMaBgqeAhjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aMnDJ5M9P6zNaoEw5yPnvQFc/uZIVmKLb1A3i9rfsmCLNp4DnEYgIY9FvLJ2nBYnFs
         2FGUtL8yT1FApsBNce2jrOHYQcucqpURv5ywsRr5L/E54MAZYbKaIgXVSBqD2/wi8YxX
         dd/SqHhIJu1iLb0/P6h1Sorq6SaUagusCgK+c=
Received: by 10.86.93.19 with SMTP id q19mr646091fgb.62.1232712232172;
        Fri, 23 Jan 2009 04:03:52 -0800 (PST)
Received: from ?192.168.1.11? (abwn47.neoplus.adsl.tpnet.pl [83.8.237.47])
        by mx.google.com with ESMTPS id 4sm2651315fgg.54.2009.01.23.04.03.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 04:03:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232548106.4977310a95d8f@mail.nimag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106875>

On Wed, 21 Jan 09, Sebastien Cevey wrote:

>>>>> ----------------------------------------------------------------
>>>>> [Actively cooking]
>>>>>
>>>>> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>>>>>  - gitweb: Optional grouping of projects by category
>>>>>  - gitweb: Split git_project_list_body in two functions
>>>>>  - gitweb: Modularized git_get_project_description to be more generic
>>>>
>>>> This I think needs some further cooking.  I guess with addition of one
>>>> more patch to series categories could be sorted together with projects
>>>> they contain, and not always have to be in fixed ordering.
>>> 
>>> These should be moved to the Stalled category; nobody seems to be
>>> discussing improvements and sending updates to the series as far as I
>>> recall.
>> 
>> I think it is just the author being slow moving; there was quite
>> a bit of time between subsequent versions of this patch series.
> 
> I don't recall what was left to do on top of the series of patches I submitted,
> could you refresh my mind on that if it still needs to be done? I remember the
> discussion trailing off as categorized ordering was being discussed..

I'd have to take a fresh look at discussion but I remember two things:
first, that the code dealing with filtering out projects (e.g. removing
forks) is high incompatibile with introducing later limiting number of
projects per page, as it currently filters out paths _during printing_.
So we might want to have this cleanup before your series (which now
include a bit unnecessary preparation for projects_list view pagination).

Second, there was IMHO one unnecessary sorting, as with one more commit
we can have quite simply categories sorted in order of sorting project
they contain, which means that if we sort projects by age (youngest or
rather most recently changed first) then with one more commit we can
have category containing freshest project first.

I'll try to review this series soon, and if you don't have time I'll
resend them with those minor corrections.
-- 
Jakub Narebski
Poland
