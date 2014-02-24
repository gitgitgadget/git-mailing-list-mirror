From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] Document a bunch of functions defined in sha1_file.c
Date: Mon, 24 Feb 2014 12:08:55 -0800
Message-ID: <20140224200855.GI7855@google.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
 <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu>
 <530B8CEB.5040903@gmail.com>
 <530BA530.3070603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1pr-00015h-6M
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbaBXUJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:09:00 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34271 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbaBXUI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:08:59 -0500
Received: by mail-pd0-f171.google.com with SMTP id r10so1223957pdi.30
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5rTLpp5QmwSXHo64f3ApJdeiYE6+C++s3kEnpBZ8T7s=;
        b=A5ktd2IYPaYEoO424t9wj+Jhw2xQUtbxJgxo3nagJoFs0tU4dnL/lWuRB4S3KvNSwH
         qlXNQvyy0Z1fD7S8nw38idNl5hrb9k0c0HLZ7GvuruukVVwwKubO9kUuadYtOGe8/bzo
         RsLtLu3B1ThraQykMegGwaWMr6XFSrlmDJbORixZWWQdySU4eeffUA5XmE9jYlJN3UFe
         QF237SG6xcK9flTWCjDaoOW7ChI6IkPnFJQ6v8l3rO0ep7Q9svT2JQ5Bxg1TOjr3vViR
         dvc5L6aez6uaxqW+i+YT7N11X/xLLkCrQYs8imlmXmF+AitFC1Kv7f1sJQRySXfgOcYo
         fFYQ==
X-Received: by 10.68.135.67 with SMTP id pq3mr50880pbb.63.1393272538796;
        Mon, 24 Feb 2014 12:08:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id hb10sm2851380pbd.1.2014.02.24.12.08.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Feb 2014 12:08:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <530BA530.3070603@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242638>

Hi,

Michael Haggerty wrote:

> No, this hasn't changed.  I've been documenting public functions in the
> header files above the declaration, and private ones where they are
> defined.  So I moved the documentation for this function to cache.h:
>
> +/*
> + * Return the name of the file in the local object database that would
> + * be used to store a loose object with the specified sha1.  The
> + * return value is a pointer to a statically allocated buffer that is
> + * overwritten each time the function is called.
> + */
>  extern const char *sha1_file_name(const unsigned char *sha1);
>
> I also rewrite the comment, as you can see.  The "NOTE!" seemed a bit
> overboard to me, given that there are a lot of functions in our codebase
> that behave similarly.  So I toned the warning down, and tightened up
> the comment overall.
>
> Let me know if you think I've made it less helpful.

In the present state of the codebase, where many important functions
have no documentation or out-of-date documentation, the first place I
look to understand a function is its point of definition.  So I do
think that moving docs to the header file makes it less helpful.  I'd
prefer a mass move in the opposite direction (from header files to the
point of definition).

On the other hand I don't feel strongly about it.

Hope that helps,
Jonathan
