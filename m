From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 38/44] refs.c: pack all refs before we start to rename
 a ref
Date: Thu, 22 May 2014 10:51:53 -0700
Message-ID: <20140522175153.GQ12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-39-git-send-email-sahlberg@google.com>
 <20140521235741.GN12314@google.com>
 <CAL=YDW=vY_09An0encywRoAexAEoQK=SbOe5Dt_FJmsFnwoCrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnX9s-0005lo-FS
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 19:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbaEVRv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 13:51:56 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43526 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbaEVRv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 13:51:56 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so2808157pad.32
        for <git@vger.kernel.org>; Thu, 22 May 2014 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C/yvnZeynBA+vvBWegev4NwItK5pN9XkvfIg4A1jT0A=;
        b=HM+sWrVaDe7gdS8gxs7U6XGAbxBnUaRULk0OzVK1SrthFURQwXfTIkvFuWHLhe9NAg
         YnDnRKtmWi4+VSHrM7yA1dDP9iqlRttFZcxQ0hIvifa88Id/TdKchUNj6gAUMzEOa1qf
         DCszoLuYoGIzoaRqeYLKXHLamStyaqpLqCsG7hJgUtK1aUmvh/Gfx//mo1tuVy3kXsQq
         fOLhW5824rZwwi0xZpzkqi2bmyjRnsgiaJAJwhwvRyLXaOF1ZWTfnhqAymY+nOIenYZq
         doSOJzA5FwY9UHOHS5gu6x5CQ3T0ekWATYMZpHQ8RGhgqIm8uMyrb0u0ZSAmV27zFSwK
         BHZQ==
X-Received: by 10.66.162.137 with SMTP id ya9mr37812035pab.31.1400781115771;
        Thu, 22 May 2014 10:51:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id av4sm2103952pac.8.2014.05.22.10.51.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 10:51:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=vY_09An0encywRoAexAEoQK=SbOe5Dt_FJmsFnwoCrg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249922>

Ronnie Sahlberg wrote:
> On Wed, May 21, 2014 at 4:57 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:

>>> This means that most loose refs will no longer be present after the rename
>>
>> Is this to handle the "git branch -m foo/bar foo" case or for some other
>> purpose?
>
> Yes. That is the main reason.

Thanks.  Please say so in the log message.  Remember that people of
the future debugging and trying to figure out how to fix the latest
regression without breaking something else and whether to just revert
your patch cannot read your mind. ;-)

Hope that helps,
Jonathan
