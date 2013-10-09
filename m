From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 9 Oct 2013 14:11:01 -0700
Message-ID: <20131009211101.GM9464@google.com>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
 <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com>
 <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
 <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>
To: Paolo Giarrusso <p.giarrusso@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 23:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU12U-0006Vz-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 23:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab3JIVLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 17:11:09 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:40258 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab3JIVLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 17:11:07 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so1506470pbc.31
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e9b60oX7d06lc4ZBrprTU6KPHWAGKgRZwiUFXrZ/Kv4=;
        b=scA25tD3ha+s3hk7qSQ6tz5Yno25IujQZGqHtEA5GpBhEo6TOk8XWGQ1QA6d7+GoCp
         wOplScz4WbIZ5LjxXsjq1EPQvjU0sJSB17/T1Q/WZAZwIO1nDWd2StMQg6Dyv3jdCvKo
         qV3GqSknXqhdFuRr1Y3EPcLTgGzIr+EYE89pztynbxEoooVaYS17XgclHSUgNsWKStaw
         MbSKC4YdPmvmoiT+D1rmoSGCkBLczzaCEUOkPLTndJ+n7NbJDJUKYVhXVu5YDrMtAFWs
         /078DNG3nYzTL66CPP9or4RA+XraAZu/ymxld7zoURYHqK+UAWbL5br6RxrIzuETD751
         P9NQ==
X-Received: by 10.68.171.35 with SMTP id ar3mr9809495pbc.77.1381353066018;
        Wed, 09 Oct 2013 14:11:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xv2sm48586680pbb.39.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 14:11:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235842>

Paolo Giarrusso wrote:

> Seeing the email, I wonder whether there's hope something like that
> can be preserved in an email, and whether the code should use some
> escape sequence instead.

Yes, please.  Mind if I amend it to

	printf "%s\r" "$revcount/$revmax ($createcount)" >&2

?

[...]
>>         say()
>>         {
>>                 if [ -z "$quiet" ]; then
>>                         echo "$@" >&2
>>                fi
>>         }

I agree with the other reviewers that this should be fixed to use
printf, too, but that's another topic.

Thanks,
Jonathan
