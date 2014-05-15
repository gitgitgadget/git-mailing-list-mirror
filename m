From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 12/44] refs.c: ref_transaction_delete to check for
 error and return status
Date: Thu, 15 May 2014 12:51:52 -0700
Message-ID: <20140515195152.GJ26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-13-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1hA-00036R-Rd
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbaEOTv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:51:56 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45266 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEOTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:51:55 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so1501671pad.27
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tUJhy6/ddvJu1runiZ1tSOFA7XqPizzaA1NYZA3DS1U=;
        b=vS5Legj+cHteaaCQ1Gs1T4/Pwyk09V+5h+fw/yIDeQ5CKJhBF7bjJSxBynbz3tAnZ7
         rJ0aEjD55UxU876VfCt65hfk6y1JQBV4gKhqFDodytF9EGIOqm6kt/gdtbI28WdSPYxh
         SVOyQCjdx4E2orQC7neZc+KuUJ0e8kHUR1g/JXq4szVsM2fH6BjSVTkyBX/BZwiudV8+
         r23agSUEmWK5Z2OR2BbrRHlUDRCvq6QNJ/7wB74RNQdq0tsosIlzbyKWoUsqGj9CJtfM
         zmZvzt/heKMP78lxlNfsaIv81JUPrqHT7KG701RQZvoYwXKwY1mzvMReD37zsl/RsABl
         AuGA==
X-Received: by 10.67.4.195 with SMTP id cg3mr14814309pad.21.1400183515441;
        Thu, 15 May 2014 12:51:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gu1sm10559011pbd.0.2014.05.15.12.51.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 12:51:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-13-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249196>

Ronnie Sahlberg wrote:

> Change ref_transaction_delete() to do basic error checking and return
> non-zero of error.

Likewise: a 'struct strbuf *err' would make nicer error messages
possible.
