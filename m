From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 2 Aug 2012 09:07:54 -0700
Message-ID: <20120802160753.GA17158@copier>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 18:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swxwe-0001U2-UN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 18:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab2HBQIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 12:08:11 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34283 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2HBQIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 12:08:10 -0400
Received: by ghrr11 with SMTP id r11so2422753ghr.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J0NUqUj+0DAPUeqKzoKVAZxlpaP6gLJ4RYP5yFQb4FM=;
        b=IKzWwXqfvo/HWtplEO3Z9X4+sHhM4ykHkfvNcCmf3u71l0bTPqg/uHyfwIy30yZd60
         yIVbcBfOa+kfA6RRmuFvwqP9FVx9sjF62rFpl9ZG9hDD80nyuNJ18xigU2fw42yLi5jM
         Ta90AtX8yu8dRY7zv4PQuf0+UQ9qE0XqXgxVANyIxXIrNh89JXhNbTGkWAGeaiDU8pVH
         hH0dDY6g4/jJ6I3yJHNH2qmN58VWb61C+lml9pX+BEQUQTMQFJkmt84vnhaRZ8xHH8iY
         47HqOBUHa35PjOWESmWkUNcatuDiNpG4N8qkaa5RxUdzjPKwoOJr0JfAX/cIJ44u8ASf
         1vRg==
Received: by 10.50.181.136 with SMTP id dw8mr4700355igc.31.1343923689957;
        Thu, 02 Aug 2012 09:08:09 -0700 (PDT)
Received: from copier (cl-711.phx-01.us.sixxs.net. [2001:1938:81:2c6::2])
        by mx.google.com with ESMTPS id yh4sm11391471igb.1.2012.08.02.09.08.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 09:08:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120802103122.GA24385@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202783>

Hi,

Eric Wong wrote:
> "Michael G. Schwern" <schwern@pobox.com> wrote:

>> This patch series fixes git-svn for SVN 1.7 tested against SVN 1.7.5 and
>> 1.6.18.  Patch 7/8 is where SVN 1.7 starts passing.
>
> Thanks Michael.  I've made minor editorial changes (mostly rewording
> commit titles to fit the larger project).

Thanks from me as well.  I'm still worried about whether the increased
use of canonicalize_url will introduce regressions for the existing
SVN 1.6 support, and I should have time to look it over this weekend.

The comment in canonicalize_url "There wasn't a 1.6 way to do it" is
not true.  The relevant thread on the git list had a little
conversation about keeping svn 1.4 support, but I'm not sure why
that's relevant, given that svn_canonicalize_path has worked largely
the same way starting with SVN 1.1 (and on the other hand had
significant changes in SVN 1.7).

Hopefully you've looked this over carefully already and I'm worrying
needlessly.

Hope that helps,
Jonathan
