From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Define constants for lengths of object names
Date: Thu, 1 May 2014 10:20:07 -0700
Message-ID: <20140501172007.GZ9218@google.com>
References: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu May 01 19:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfuem-0005lG-O0
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 19:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbaEARUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 13:20:13 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38471 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaEARUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 13:20:11 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so2072641pde.40
        for <git@vger.kernel.org>; Thu, 01 May 2014 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3nQAb75Mo0aIX5FcDJWCxR6RLkPrTIXWOdPHtSIInzU=;
        b=ajDXj7oymV4dDbKDn+S7mtjvznGa7DkmakXc87np0BR9CO+/71b9DLTAVgVOROa/OM
         lgia02rZG9PT6TZz3SB7rMYO+fb8al0FR5RkkZL61XnRyKLnezKuv2pwKjztD8F84+xM
         TuTwQRkI4+S6Z+l85S42ojzTKNI7HOkJ9Q4GM48+lEkHEkdIExbYdo19CA4icHdp0hoA
         fAtBl3dpVxJSzKZTYfDIOEhAfnpENF/GQ8bUnNVOje6cXktv8LbvL/8j9Cx36jM/X6Ya
         ipJEVIL0D1GXgyNsaOATYxLhGncdmNdzNn+8+I6/p+JABx3z5va23lWzYepQlzNvxuPr
         56Yw==
X-Received: by 10.66.164.201 with SMTP id ys9mr23574141pab.40.1398964810995;
        Thu, 01 May 2014 10:20:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pb7sm161432016pac.10.2014.05.01.10.20.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 10:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247816>

Hi,

brian m. carlson wrote:

> --- a/object.h
> +++ b/object.h
[...]
> @@ -49,7 +56,7 @@ struct object {
>  	unsigned used : 1;
>  	unsigned type : TYPE_BITS;
>  	unsigned flags : FLAG_BITS;
> -	unsigned char sha1[20];
> +	unsigned char sha1[GIT_OID_RAWSZ];

Maybe my brain has been damaged by reading code from too many C
projects that hard-code some constants, but I find '20' easier to read
here.

What happened to the

	struct object_id {
		unsigned char id[20];
	};

	...

	struct object {
		...
		struct object_id id;
	};

idea?

Thanks,
Jonathan
