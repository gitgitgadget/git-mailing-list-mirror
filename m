From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] post-receive-email: explicitly set Content-Type header
Date: Fri, 7 Oct 2011 15:19:32 -0500
Message-ID: <20111007201932.GC29712@elie.hsd1.il.comcast.net>
References: <1316505154-3904-1-git-send-email-zapped@mail.ru>
 <1316506023-5098-1-git-send-email-zapped@mail.ru>
 <4E785DC6.80105@viscovery.net>
 <20110920104256.GA11656@zapped.homeip.net>
 <4E7874B9.2060909@viscovery.net>
 <20111007090601.GA22541@elie.hsd1.il.comcast.net>
 <20111007165209.595834f2@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Fabian Emmes <emmes@informatik.rwth-aachen.de>,
	Alexander Gerasiov <gq@cs.msu.su>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 22:19:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCGtY-0001io-8M
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 22:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab1JGUTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:19:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54408 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab1JGUTn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 16:19:43 -0400
Received: by iakk32 with SMTP id k32so4558603iak.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KoJ/IKkvIGA1qhy/kl/exqVuMBHlglBMvrvyAEwlDDk=;
        b=oIwKQEVMqWmCcvDJlKxEto/D0gWWj0vnhhnjsnckBPJHHi7ZregwN5SvDVxMtKbG2q
         /LlMsiNjkYtgnnoUpra+nZeJhS9jBnpiMxDiaZUfLKVHZq7htONUmxgw+B7fnf9/3Doq
         p+xpzcO1ooO6FZdfBuO8+lTxZeaLW7legskTE=
Received: by 10.231.70.131 with SMTP id d3mr3846801ibj.90.1318018782770;
        Fri, 07 Oct 2011 13:19:42 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z11sm22338996iba.6.2011.10.07.13.19.40
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 13:19:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111007165209.595834f2@ashu.dyn.rarus.ru>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183105>

Alexey Shumkin wrote:

> In development process under Windows non-UTF-8
> encoding is used (cp1251 in my case). So, filenames have this encoding,
> and as we know Git stores their names as is - in cp1251 - without a
> conversion. And filenames are also used in diff-stat (with
> core.quotepath= false

Yes, when a person sets [core] quotepath to false, I think it's fair to
assume for now that the filenames are in the same encoding as
everything else (whether that's UTF-8 or something else).  Maybe it
would be possible in a separate patch to add a configurable list of
encodings to try out when formatting paths for display.

Jonathan
