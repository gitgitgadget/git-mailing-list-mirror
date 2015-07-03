From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: add log.follow config option
Date: Fri, 03 Jul 2015 10:47:15 -0700
Message-ID: <xmqqy4ix3zh8.fsf@gitster.dls.corp.google.com>
References: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
	<vpq8uazo9y6.fsf@anie.imag.fr>
	<xmqqvbe37eyy.fsf@gitster.dls.corp.google.com>
	<1435862617.30946.2.camel@twopensource.com>
	<vpqr3op676u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB53b-000520-8u
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbbGCRrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:47:20 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34137 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbbGCRrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:47:18 -0400
Received: by igcsj18 with SMTP id sj18so192054051igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QsxxC6m+49e3GyuWR/vbg7G1v9IfXApg8v6J3Kla3FM=;
        b=VzvmESR1LFDhYrQl3jQs4bb2DqjjXjIYbiRA4vbSDuzUW0ealxYcvGcBmvLXmYvCX4
         PhBKMIbFf1v9d5ITMjuB5Aq4Hc1G8zjN+Xg5XMMbvzcDjZgYt2Ftc9k/Xt+lqoe0lfMM
         /mkEpbVwbSynYGHe5NJOZdULD2s4YLOTpREyzbIsJC/hX7Mr0MqLkIZXWb7WmY/Nj1Dq
         4n45G9vjDuKz4wciSE+ycVKD+OfhvfDBDm4Ko4JU7z7eZWk7B9C0GRqZhNwyRNTfi5WY
         JIcxf4IRmwowR+snEIsPL0P9j/h3EITf2An6cAk4eW8h8MdBlKmmejL8EYR39SSfZPJo
         NEHg==
X-Received: by 10.50.110.3 with SMTP id hw3mr23940139igb.20.1435945637213;
        Fri, 03 Jul 2015 10:47:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id a82sm6606321ioe.22.2015.07.03.10.47.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:47:16 -0700 (PDT)
In-Reply-To: <vpqr3op676u.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	03 Jul 2015 09:17:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273302>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> Twitter's history is almost completely linear, so it's useful for us.  
>>
>> Since it looks like the patch won't be useful outside of our context,
>> I'll just rewrite it to check the pathspec count, and not upstream it
>> until follow becomes more general.
>
> As long as it's an opt-in and that the documentation states the
> limitations clearly enough, I think it makes sense to me to have this
> upstream.

Perhaps.  But at least "log -- 1 2" and "log --" should not be broken
for those that set the configuration.

Unless you are counting these as also "limitations", that is.
