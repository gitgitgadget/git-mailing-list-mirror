From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] path: optimize common dir checking
Date: Mon, 05 Oct 2015 13:43:21 -0700
Message-ID: <xmqqoagdxd06.fsf@gitster.mtv.corp.google.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
	<1441073591-639-3-git-send-email-dturner@twopensource.com>
	<5611E7B1.3090001@alum.mit.edu>
	<xmqqd1wtz0w2.fsf@gitster.mtv.corp.google.com>
	<1444075810.5158.7.camel@twopensource.com>
	<xmqqsi5pxdc0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:43:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCbY-0002Mg-7x
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbbJEUnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:43:24 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36048 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbJEUnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:43:23 -0400
Received: by pablk4 with SMTP id lk4so185768686pab.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OeBg/4SSMmLCkzfwmLg1GO0epNJz4rVW1E/VPqgkDRU=;
        b=EXBChfnIttDbXdOSYdPZphyJTRoYRys/S81sRFzQMgIcaD4a8Beuts6B6hUtKXXU2T
         ttZ/NMxVNgzZ583iZs4l6YzZh/EZ4fR4xLdJ8oTW5W1l58ggAnuthAjzZZfa9o+xyYyM
         MAIVWaouUjCFuuwNcpGLz4GtCxQ4X6+/Gkrj/+cNU4Q2KazLbVjzRryDnGW6HJA54r53
         cxjEz+urfTuz4xL8zaZHsGJ500EsbhSiAMINArUW6qmYntz4KTlJifjXljbs8yjMNMAR
         4UCz+3oKXex9yN/dMQZuFpaaHZjKhTqi93i3qiUNI08H1ID9lCRyJFe6W4hFkQeteZYL
         TAEA==
X-Received: by 10.66.146.197 with SMTP id te5mr37676441pab.35.1444077802669;
        Mon, 05 Oct 2015 13:43:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id rp5sm29441285pab.0.2015.10.05.13.43.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 13:43:21 -0700 (PDT)
In-Reply-To: <xmqqsi5pxdc0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 05 Oct 2015 13:36:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279090>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> But this is a benchmark of just git_path.  I don't happen to see any
>> cases where git_path is taking up an appreciable amount of runtime.
>>
>> I only added this because Junio requested a speedup.  So I am perfectly
>> happy to drop this patch from the series.  
>
> Ok, then let's drop it for now.  Thanks.

Having said all that, this conversation happened way after I started
today's integration cycle, I am not inclined to redo all of that,
especially with extra tagging involved in the work done today.

So it is in 'master' now.  I'm open to a patch to revert this
commit, though.

Thanks.
