From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] parse-options: remove OPT_BOOLEAN
Date: Sun, 8 Dec 2013 14:23:52 -0800
Message-ID: <20131208222352.GA9108@google.com>
References: <1386392573-27367-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 08 23:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpmm3-0002pM-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 23:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab3LHWYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Dec 2013 17:24:05 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:39461 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab3LHWYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 17:24:02 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so2069217yhz.41
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sX6K6B5IGa4t0Qg+udcF/GC2sriXNgptRbkhONiQXB0=;
        b=uvlhKJk9DMnTGSaUyblfenzn6GUL0yXX6oJq03CL7MBdjqmBdsZGv3LuQfDrlHCLPy
         W6wRTO0/O47xtuxy4V2zFjUTyc8sIQdM7MRdy1xERGbLj+/h4s5SAVGGBdyLml2GNuVG
         Rr6EQKFG80ZBGGXr7kawHVCVTU+guMECNmOeYGczYXrF8qjfhChSPn5M5CfI8omo3hwm
         ASMu+shHLm83KtbOV/AhyFyaj4+xRMr4ZqUQzsI6/jO6+Z9CecyXRCfK7UUrwnzyVtGC
         z+cW7pXnYHKgqPqvlZJ10R/+DfAA3osVabYNwvOahons+bOo1CwIM7bKF5WVqO2A4mNF
         sJeg==
X-Received: by 10.236.42.231 with SMTP id j67mr366316yhb.131.1386541439456;
        Sun, 08 Dec 2013 14:23:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id j67sm12105891yhe.26.2013.12.08.14.23.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 08 Dec 2013 14:23:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386392573-27367-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239052>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> After a86a8b9 (sb/parseopt-boolean-removal), the deprecated
> OPT_BOOLEAN is not used anywhere except by OPT__* macros.

Yeah, I noticed the same thing too recently.

[...]
>                                              All OPT__DRY_RUN call
> sites have been checked and they look safe for OPT_BOOL.

This is the only functional change from the patch.  A repeated
--dry-run that behaves differently from --dry-run would be very weird,
and a quick check of OPT__DRY_RUN uses in pu confirms that with
current callers the patch is a no-op (except in the weird case that
someone overflows an "int" with a very long -nnnnnnn...  commandline).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
