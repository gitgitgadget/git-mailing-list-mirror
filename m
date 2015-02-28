From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 2/5] upload-pack: support out of band client
 capability requests
Date: Sat, 28 Feb 2015 18:36:23 +0700
Message-ID: <CACsJy8D1xHh7tQkX=+4H_FvLdk53RmtNwVPNuo9Ng2x9oQFPjw@mail.gmail.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 12:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRfhe-0002hx-SQ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 12:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbbB1Lgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 06:36:55 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38335 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbB1Lgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 06:36:55 -0500
Received: by iecrd18 with SMTP id rd18so37238499iec.5
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 03:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vntGecxIcljXLMR5C0dPht4uR7feEdallnSIaeCCXao=;
        b=JzPlnFGkSZ6UEX6CUdIPbv4iDwASQZsR//QDLslf9NJ4C+2uJbkb6LIndkTq8gW+lB
         S70omd7JBjXisXfY7/2RIcIFlhJB3Em3zsiYwmpFX4xH5R/Ydy9VmW0LQMM4DpD7Mneh
         haLWf0kWcp/TJ36hKZgFvxwHGl+YMt++JBGiveW29dYwdCVZ76jyhDIbjoD7Bo8a6AI6
         ortV9Bu8NRahXdFlYzChfhzRSWF1zbvHxs2x9O24akcLbvlulCMwep5XfrLDBdME8qdm
         dX1IPuDKR3HmIs+c1KhQO2paJo75p3Taoz8gzNpYVrx55a0gky79dmHpNt6bSW60msj8
         Tj6g==
X-Received: by 10.107.167.145 with SMTP id q139mr25125475ioe.16.1425123414240;
 Sat, 28 Feb 2015 03:36:54 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sat, 28 Feb 2015 03:36:23 -0800 (PST)
In-Reply-To: <1425085318-30537-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264527>

On Sat, Feb 28, 2015 at 8:01 AM, Stefan Beller <sbeller@google.com> wrote:
> Notes:
>     v1:
>     I am still undecided if the client should then accept/resend
>     the capabilities to confirm them, which would make the client the
>     ultimate decider which capabilities are used.
>
>     My gut feeling is to rather let the server make the final decision
>     for the capabilities, as it will use some requested capabilities
>     already to not send out all the refs.

pack-capabilities.txt says

"Client will then send a space separated list of capabilities it wants
to be in effect. The client MUST NOT ask for capabilities the server
did not say it supports."

What was sent out of band is what the client can support, not what it
wants. So perhaps drop this patch and let the client decide exactly
what it wants.
-- 
Duy
