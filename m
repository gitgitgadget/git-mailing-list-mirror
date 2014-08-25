From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Mon, 25 Aug 2014 12:46:41 -0700
Message-ID: <20140825194641.GS20185@google.com>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:46:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0E4-0008LK-HE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbaHYTqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:46:45 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36301 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbaHYTqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:46:44 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so20921159pdb.27
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CXBxrinBpbCSjQXThQlV7ofNIbGvxdE+MkGxVpcK44E=;
        b=uTkZMOu+pRXV3Oxigr3Fbv0oT7dVosOwagF5Q2FGX8+ERU+rDnLz2dI+Qf+VuIndeK
         TVksRZ/JGmUieVhKNqb2RXNvSKA1WU5DkWYP9HuSJ98q5qiUnV7RIgoI5o0Odnfapt8L
         7KXTqGAncTlsfQ3aCncVs3OH2o/RZi38ySW3sFAA4O8M2aaDCDcpIaf7rda2IVyujtka
         wSRoYVeHSUgXxYUALALvlvmk6535T9Rqa3p1geUfNR6yRlKnnJgyEAYIBtnCBqw4OdNf
         kAi82HGFB+M10fCHC1vBge8JdoTPLhumrjMn+8HbOtp5ORxyImqC7IqZRQL04SaBwteA
         P/sA==
X-Received: by 10.68.143.165 with SMTP id sf5mr31227109pbb.103.1408996004075;
        Mon, 25 Aug 2014 12:46:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5425:d689:6054:193])
        by mx.google.com with ESMTPSA id dg5sm2548300pac.12.2014.08.25.12.46.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 12:46:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140822043303.GB18192@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255859>

Jeff King wrote:

> -LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> +LOCALIZED_C = $(C_OBJ:o=c) $(GENERATED_H)

Why is LIB_H dropped here?  This would mean that po/git.pot stops
including strings from macros and static inline functions in headers
(e.g., in parse-options.h).

The rest looks good.

Thanks,
Jonathan
