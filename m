From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Thu, 13 Mar 2014 06:26:27 +0700
Message-ID: <CACsJy8D-GpuepvoUfTzAVgd=Uo6U90V9=kYnfUD-0SOsYK7e9Q@mail.gmail.com>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
 <5320818C.8070200@web.de> <CALs4jVFpr=YVAagJSEkAJ6qGJmYWNdu4ZXXvMYQRd0KYQXcVQA@mail.gmail.com>
 <532097D0.4070909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Quint Guvernator <quintus.public@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:57:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNt1s-0003vT-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 00:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbaCLX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 19:57:41 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:59929 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaCLX5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 19:57:40 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so332128qcx.10
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1DC/x5A4uu316PF4kg5lOn7Q/vGrboSqliPja+gz6YE=;
        b=fSSBfghPed7xjjIQ6kH/zBiAneewsh11XYWjhMJdoTVDOAKMA/+JZWpysQ9rGmNmDS
         lo9nZyeRLk6aInZjXl8IHlqfSY7q6QOzOcxLmO5OOKGblPt3Nytq52zRNKKJ7MoEnFr6
         ivrObZWa6fBJqtQTD2D4z0Z0vls2+lL+26NH7XiSax14RIrsbq/SER273WKrcfU46qYu
         Yi3OgHYFKEFLkstPyc43jjqNO8b8MT/MTSLkuixOV3U89PzVCezF7BvZvmcWQ8B0MyDk
         vP/rNFS1mKilY/QrtQ6F+nSwNTSfjwl/e+L6IjQsnBqWy9+F3RT3qFomBY9ohBBWtdKE
         wsSg==
X-Received: by 10.140.36.200 with SMTP id p66mr303946qgp.54.1394666817920;
 Wed, 12 Mar 2014 16:26:57 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Wed, 12 Mar 2014 16:26:27 -0700 (PDT)
In-Reply-To: <532097D0.4070909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244012>

On Thu, Mar 13, 2014 at 12:22 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> That spot uses memcmp() because ce->name may
> not be 0-terminated.

ce->name is 0-terminated (at least if it's created the normal way, I
haven't checked where this "ce" in submodule.c comes from).
ce_namelen() is just an optimization because we happen to store name's
length if it's shorter than 4096, so there's no need to
strlen(ce->name) again.
-- 
Duy
