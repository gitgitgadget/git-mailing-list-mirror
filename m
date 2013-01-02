From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 00:02:47 -0800
Message-ID: <20130102080247.GA20002@elie.Belkin>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqJP7-0001UG-Oh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab3ABIKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 03:10:00 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:59987 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3ABIJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 03:09:58 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so7756355pbc.23
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FBzoHhIoIrardKj+nnuNGs4fgeRjHMLBybDrDW+FJdM=;
        b=uR8pN1QpVV61gq19+DOLDS5xaYqOXopemvwDPGFq6kWcrNDEqup33uVWqBo7NpuIdM
         jKmL9xdeGCoJdqBH5I6o0wchL2RhYlNYNZtBG/15hrvZapT0YP3AK3v0sH7AOandYOBN
         U5YeT21r2Se+BGGv1oUPDgKMUgCKFVHUv3W8603niMOrkwwajjx6bCV+UGqcUluRjhJA
         VejLKsF6oH1//3U8uKOifShX/BbcE22Teu1BgowHA8u96QzYHvQFJm+EWpr66wIGp8c/
         h1Zu9Rnq4eeEAOyIdOl3yU2fi/DsSgpPP9lskd5anIksFbocc+VLr5vjPWXI1ls3JV6M
         8drA==
X-Received: by 10.68.238.8 with SMTP id vg8mr142590878pbc.26.1357113776921;
        Wed, 02 Jan 2013 00:02:56 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id n11sm28016447pby.67.2013.01.02.00.02.54
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 00:02:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130102003344.GA9651@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212502>

Hi,

Eric S. Raymond wrote:
> Junio C Hamano <gitster@pobox.com>:

>> So..., is this a flag-day patch?
>>
>> After this is merged, users who have been interoperating with CVS
>> repositories with the older cvsps have to install the updated cvsps
>> before using a new version of Git that ships with it?
>
> Yes, they must install an updated cvsps. But this is hardly a loss, as
> the old version was perilously broken.

Speaking with my Debian packager hat on: the updated cvsps is not
available in Debian.  "git cvsimport" is, and it has users that report
bugs from time to time.  With this change, I would either have to take
on responsibility for maintenance of the cvsps package (not going to
happen) or drop "git cvsimport".  That's a serious regression.

The moment someone takes care of packaging the updated cvsps, I'll
stop minding, though. ;-)

I wouldn't be surprised if the situation on other OSes is similar.
This is too early to require such a dependency.

Hope that helps,
Jonathan
