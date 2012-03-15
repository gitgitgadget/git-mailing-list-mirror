From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: [PATCH] Use macro HANDLER_WRAPPER in sigchain to wrap clean
 function of sigchain
Date: Thu, 15 Mar 2012 18:35:28 +0800
Message-ID: <CAMocUqRuKXoNAmqzcxvDmt4Oo=NqkM=5WyqgDqfDBMcTK0Cq7w@mail.gmail.com>
References: <CAMocUqRsEvwnoV32Cr05dJeUj7iNDj1cLP5kAzgyMNEo1O0kCw@mail.gmail.com>
	<7vmx7kweus.fsf@alter.siamese.dyndns.org>
	<20120313205501.GB27436@sigill.intra.peff.net>
	<7vlin4td4g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	=?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 11:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8820-0007qa-CH
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 11:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2COKfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 06:35:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50394 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2COKfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 06:35:31 -0400
Received: by bkcik5 with SMTP id ik5so1978573bkc.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1XQLHkM5B7ZG+Y1fz2UO8VYLCD0Ls65YN6Vy6cECd2s=;
        b=vtznQgNGEv5bbN15Eb8/2A2uxRWGIhVt4iuDRzFnF9ynblmam1DKBQlB8NZrQNmtX6
         fhMT+zWqZ5CVAHht8jgjBy69mDeitsQaUr3A1UY+LiumnxOlKvO0I0N/47O3HBMkUcaA
         oZ3dYLs+2m9Vdook1OjfKCqgSvsz1wDJd0YWVfkWmpe1Cgdu8vYhcxHK/2tKDcxjxxll
         wHVClF3PBFc7tkY4RfuD5dsZGMFJeYOj2yfxSuMT2iIBYmxVjV1lpEM9KIz5CCYSekXw
         GYkn8MH1ZFetFU7Sll+2pYM0hDMPESJSJFDGSxboCg6p8KJPqeK9b90HTIEPPDcktT3j
         uXsg==
Received: by 10.204.136.200 with SMTP id s8mr2167943bkt.97.1331807728709; Thu,
 15 Mar 2012 03:35:28 -0700 (PDT)
Received: by 10.204.36.85 with HTTP; Thu, 15 Mar 2012 03:35:28 -0700 (PDT)
In-Reply-To: <7vlin4td4g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193208>

Eh. I really don't see why it is difficult to read. Although it _is_
error-prone, and also difficult to do further functionality extension.

BTW, if we want to generalize the clean_xxx_on_signal, how should we
deal with the exception I mentioned before(function named
cleanup_children in run-command.c which require one argument)? By
forcing all clean_xxx take one argument?

Also, many books mentioned that we should never use signal() in
portable program, use sigaction() instead, but there are plenty of
signal() in git. Why should we do so?
