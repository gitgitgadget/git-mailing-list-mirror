From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/19] fsck: Introduce identifiers for fsck messages
Date: Fri, 19 Jun 2015 12:06:58 -0700
Message-ID: <xmqq8ubf8qlp.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<d36f30f8a9e4466862699f9f438b937c6279253e.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61d3-0003xH-OE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbbFSTHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:07:02 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34317 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbFSTHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:07:00 -0400
Received: by igboe5 with SMTP id oe5so23104095igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=z+Wkn5bE0zEN/is5YgOi1I1oUmc63bSIDjakSemGwuE=;
        b=U8H6Zsu+9zDWNAA73rZcCruqBfcBCuQCtWrwlZp5IIaZIiyDbig1yH+TOdBLAXt+li
         6OjBocJRAL8fhZoECXZr4WZ7sI2u6MsHdrtfTzfGC6CrNLac06ugsJfrHfMdk9AoQGGy
         BoLlKWvFbBBrVmHfvvziw9FQZTKeBB88LC4LBoFqfd7JoargGjkvpeBP8qzOfjGxrqVc
         ErER2TZIFiBoT8vfJOdliqQ7Oz9x1aVoLCGCk/3AJGsQI6l4AP8eXeiKM2Gy+uG8wHAN
         pmPxyqedOWs3haS5MHAu1nmUguaAN8U95w/a5oAnfXDHznt9W/ThWehv3Yn9EkfN6zaM
         U11w==
X-Received: by 10.42.166.200 with SMTP id p8mr13293552icy.25.1434740820075;
        Fri, 19 Jun 2015 12:07:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id j3sm2243423igx.21.2015.06.19.12.06.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:06:59 -0700 (PDT)
In-Reply-To: <d36f30f8a9e4466862699f9f438b937c6279253e.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:32:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272185>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of specifying whether a message by the fsck machinery constitutes
> an error or a warning, let's specify an identifier relating to the
> concrete problem that was encountered. This is necessary for upcoming
> support to be able to demote certain errors to warnings.
>
> In the process, simplify the requirements on the calling code: instead of
> having to handle full-blown varargs in every callback, we now send a
> string buffer ready to be used by the callback.
>
> We could use a simple enum for the message IDs here, but we want to
> guarantee that the enum values are associated with the appropriate
> message types (i.e. error or warning?). Besides, we want to introduce a
> parser in the next commit that maps the string representation to the
> enum value, hence we use the slightly ugly preprocessor construct that
> is extensible for use with said parser.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Nicely implemented.  Looks good.
