From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Wed, 18 Mar 2015 06:05:15 +0700
Message-ID: <CACsJy8AiHHKBD4vV5aJec9CGzBqfSCNU6-j=LjDhsp2VrC55+A@mail.gmail.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 00:05:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY0Ya-0007tu-0C
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 00:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbbCQXFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 19:05:47 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34360 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbbCQXFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 19:05:46 -0400
Received: by iecsl2 with SMTP id sl2so24255719iec.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+8EI3L7mLbiTEVQ8S9DExY/8SnEALgcdqDMfOyC2UnA=;
        b=ZCUnuw7WdctRn65XjukmAIzKrlw4Ux6bGHBmFP3tNrPzMeE8WhhBUx/oysCNKxdWf8
         Guup5V91yRrMdricXpBI/uJhOLppieD1ui3SU5b7zf8nPLoWwv27eD4BsWEd8N1aYBkz
         FhNC0cDN88AsHAG3WAWeJO2i1P5JiHihSv8wvA2pOcA0snv82xasXBahbG5E0WU94Bil
         K36VKYr4baY60CWBKGQApauFfaFRlJQx9W+bhpJ0MUhBQ7XVAYa2kPulAY5EDMPu11/T
         TyHyWkF9ubQomvgpRE+l3KLkhN2ZzbDDLlK9fHYBo5ImjxJF9rBPWZmCpIbw+4YS3AdW
         lniA==
X-Received: by 10.107.47.216 with SMTP id v85mr122094076iov.86.1426633546147;
 Tue, 17 Mar 2015 16:05:46 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 17 Mar 2015 16:05:15 -0700 (PDT)
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265675>

On Tue, Mar 17, 2015 at 11:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Michael Haggerty (14):
>   numparse: new module for parsing integral numbers
>   cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
>   write_subdirectory(): use convert_ui() for parsing mode
>   handle_revision_opt(): use skip_prefix() in many places
>   handle_revision_opt(): use convert_i() when handling "-<digit>"
>   strtoul_ui(), strtol_i(): remove functions
>   handle_revision_opt(): use convert_ui() when handling "--abbrev="
>   builtin_diff(): detect errors when parsing --unified argument
>   opt_arg(): val is always non-NULL
>   opt_arg(): use convert_i() in implementation
>   opt_arg(): report errors parsing option values
>   opt_arg(): simplify pointer handling
>   diff_opt_parse(): use convert_i() when handling "-l<num>"
>   diff_opt_parse(): use convert_i() when handling --abbrev=<num>

Thank you for doing it. I was about to write another number parser and
you did it :D Maybe you can add another patch to convert the only
strtol in upload-pack.c to parse_ui. This place should accept positive
number in base 10, plus sign is not accepted.
-- 
Duy
