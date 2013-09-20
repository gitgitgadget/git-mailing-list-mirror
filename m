From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: why doesn't "git bisect visualize" show all commit ids from the
 bisect log
Date: Fri, 20 Sep 2013 11:22:32 -0700
Message-ID: <20130920182232.GA30039@google.com>
References: <523C8F0C.6050203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 20 20:22:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN5Lp-0007YS-4H
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 20:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab3ITSWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 14:22:41 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50741 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab3ITSWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 14:22:40 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so689373pbc.8
        for <git@vger.kernel.org>; Fri, 20 Sep 2013 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1JntgAPABqgCEiGNJj/CUlG4JUe840jG61SodPAzr4k=;
        b=TRtifbi0YByeqyVv8cBgs6jj98q/k9cFcgRHDBXYPrgVNGRiEkE9Bxu7GNW98sV3JR
         xUs+zHo2ban9n851bIRU2VLBTq5rylr9tMnIgFJhgn4YtX8NNKf/CI+EaLw+meqEqxYw
         I+giqIAvd2JmldoNa3Zj3hbBxSDGleGbSSQOEMjJm7TwK1fqiO7+d+aZlwnBmeRkE9E7
         cylEgcS2b5kLxfDfalVMHnhZtSrBPa1p4sJaJPtKSdrUcIvYO10KYhdR/yVEOtSZomj2
         Rj6pDdBL7/nZ+hUPYC8LSDpuWv2kgg0v9T5M8EBonq/Nwa8wSA7vKKML0lGOwY93kzWD
         axJQ==
X-Received: by 10.68.17.131 with SMTP id o3mr9495309pbd.60.1379701360132;
        Fri, 20 Sep 2013 11:22:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dk3sm1739261pbc.32.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 11:22:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <523C8F0C.6050203@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235076>

Hi Toralf,

Toralf F=F6rster wrote:

> When run that command immediate after "git bisect start" somebody see=
s
> the full commit range as defined in "git bisect start".
>
> However running that command later after few git bisect steps" somebo=
dy
> is just presented with the remaining commit interval.
>
> Is this intended ?

"git bisect visualize" is meant as a tool to pin down the culprit
commit that produced a regression.  Sometimes after a few steps the
problematic commit is obvious, which can save some test cycles.

If you want to see the list of commits tested so far, "git bisect log"
can help.  To see the entire bisection state, even outside the
regression window, any old "gitk foo..bar" command will do --- the
bisection state is kept in bisect/* refs that show up in blue.

Can you say a little more about what you're trying to do?  Is the goal
to have a nice visualization of what "git bisect log" shows?  (I'm not
aware of any such tool, and I agree it would be a nice thing.)

Hope that helps,
Jonathan
